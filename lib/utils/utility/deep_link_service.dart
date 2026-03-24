import 'dart:async';
import 'package:app_links/app_links.dart';

class DeepLinkService {
  static final DeepLinkService instance = DeepLinkService._();
  DeepLinkService._();

  final AppLinks _appLinks = AppLinks();
  StreamSubscription? _sub;

  Future<String?> getInitialToken() async {
    final uri = await _appLinks.getInitialLink();
    return uri?.queryParameters['token'];
  }

  void listen(Function(String token) onTokenReceived) {
    _sub?.cancel();

    _sub = _appLinks.uriLinkStream.listen((uri) {
      final token = uri.queryParameters['token'];
      if (token != null && token.isNotEmpty) {
        onTokenReceived(token);
      }
    });
  }

  void dispose() {
    _sub?.cancel();
  }
}