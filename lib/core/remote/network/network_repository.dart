import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:smart_lock_app/core/remote/network/api_url.dart';
import 'package:smart_lock_app/main.dart';
import 'package:smart_lock_app/utils/enums.dart';
import 'package:smart_lock_app/utils/routes.dart';
import 'package:logger/logger.dart';

class NetworkRepository {
  NetworkRepository._internal() {
    // ✅ DEV ONLY: allow self-signed/invalid cert for this host
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return host == "192.168.10.105"; // allow only your API IP
      };
      return client;
    };

    _dio.interceptors.add(_buildInterceptor());
  }

  static final NetworkRepository _instance = NetworkRepository._internal();

  factory NetworkRepository() => _instance;

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: ApiUrls.baseUrl,
    responseType: ResponseType.json,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  );

  final Dio _dio = Dio(_baseOptions);

  final Duration _timeout = const Duration(minutes: 2);

  InterceptorsWrapper _buildInterceptor() {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        _logger.i("➡️  ${options.method} ${options.uri}");
        if (options.headers.isNotEmpty) _logger.d("Headers: ${options.headers}");
        if (options.data != null) _logger.d("Body: ${options.data}");
        handler.next(options);
      },
      onResponse: (response, handler) {
        _logger.i("✅ [${response.statusCode}] ${response.requestOptions.uri}");
        handler.next(response);
      },
      onError: (DioException e, handler) {
        final req = e.requestOptions;

        _logger.e("""
❌ DIO ERROR
• type: ${e.type}
• url : ${req.method} ${req.uri}
• message: ${e.message}
• status : ${e.response?.statusCode}
• data   : ${e.response?.data}
• dioErr : ${e.error}

• headers: ${e.response?.headers}
""");

        // Extra: print deeper socket/handshake causes
        final err = e.error;
        if (err is HandshakeException) {
          _logger.e("🔐 HandshakeException: $err");
        } else if (err is SocketException) {
          _logger.e("🌐 SocketException: ${err.message} (addr: ${err.address} port: ${err.port})");
        } else if (err is HttpException) {
          _logger.e("📡 HttpException: $err");
        }

        handler.next(e);
      },
    );
  }

  Future<Response?> call({
    required String pathUrl,
    Method method = Method.get,
    dynamic body,
    String? queryParam,
    Map<String, dynamic>? headers,
    bool urlEncoded = false,
    ResponseType? responseType,
  }) async {
    final url = _buildUrl(pathUrl, queryParam);


    final options = Options(
      headers: urlEncoded
          ? {'Content-Type': Headers.formUrlEncodedContentType, ...?headers}
          : headers,
      responseType: responseType,
    );

    // Check internet connectivity before making request
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // showNoInternetPopup(navigatorKey.currentContext!);
      _logger.w("No internet connection. Request to $url was not sent.");
      return null;
    }

    try {
      _logger.i("Request => ${method.name} $url");
      if (body != null) _logger.d("Request Body: $body");
      log("Request Body: $body");


      late Response response;

      switch (method) {
        case Method.get:
          response = await _dio.get(url, options: options).timeout(_timeout);
          break;
        case Method.post     :
          response = await _dio.post(url, data: body, options: options).timeout(_timeout);
          break;
        case Method.put:
          response = await _dio.put(url, data: body, options: options).timeout(_timeout);
          break;
        case Method.delete:
          response = await _dio.delete(url, data: body, options: options).timeout(_timeout);
          break;
      }

      _logger.i("Response [${response.statusCode}] from $url");
      _logger.d("Response Data: ${jsonEncode(response.data)}");
      log("Response Data: ${jsonEncode(response.data)}");

      return response;
    } on DioError catch (e, stack) {
      await _handleError(e);
      _logger.e("DioError returning response directly: ${e.response}");
      return e.response;  // return the raw Dio error response
    } catch (e) {
      _logger.e("Unexpected error during request to $url: $e");
      return Response(
        requestOptions: RequestOptions(path: url),
        statusCode: HttpStatus.internalServerError,
        statusMessage: "An unexpected error occurred",
      );
    }
  }

  String _buildUrl(String pathUrl, String? queryParam) {
    return Uri.encodeFull('$pathUrl${queryParam ?? ''}');
  }

  Future<void> _handleError(DioError error) async {
    final status = error.response?.statusCode ?? 0;
    final url = error.requestOptions.path;

    _logger.e("DioError [$status] from $url");
    _logger.e("Error response: ${error.response?.data}");

    switch (status) {
    // case HttpStatus.unauthorized:
    //   if (![ApiUrls.logi].any(url.contains)) {
    //     try {
    //       await SecureStorageHelper.clearExceptRememberMe();
    //     } catch (e, stack) {
    //       await ErrorHandler.recordError(
    //         e,
    //         stack,
    //         context: {
    //           'widget': 'Unauthorized Interceptor',
    //           'action': 'clearExceptRememberMe',
    //           'message': e.toString(),
    //         },
    //       );
    //       print("SecureStorage deletion error (unauthorized): $e");
    //     }
    //
    //
    //     navigatorKey.currentState?.pushNamedAndRemoveUntil(
    //       AppRoutes.login,
    //           (_) => false,
    //     );
    //   }
    //   break;

      case HttpStatus.forbidden:
        MyApp.navigatorKey.currentState?.pushNamedAndRemoveUntil(
          AppRoutes.notFound,
              (_) => false,
        );
        break;

      default:
      // Other error handling as needed
        break;
    }
  }

  void _logBody(dynamic body) {
    if (body == null) return;

    final text = body is String ? body : jsonEncode(body);

    // If Base64 exists, avoid printing full value
    final max = 500; // preview length
    final preview = text.length > max ? text.substring(0, max) : text;

    _logger.d("Request Body (preview ${preview.length}/${text.length} chars): $preview");

    // Optional: specifically log base64 length if you have that key
    try {
      final map = body is Map<String, dynamic> ? body : jsonDecode(text);
      final b64 = map["S_PhotoFileBase64"] ?? map["S_PhotoFile"] ?? "";
      if (b64 is String && b64.isNotEmpty) {
        _logger.i("Photo base64 length: ${b64.length} chars");
      }
    } catch (_) {}
  }
}
