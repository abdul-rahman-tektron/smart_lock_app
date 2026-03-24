import 'dart:convert';
import 'dart:io';

import 'package:smart_lock_app/core/model/error_response.dart';
import 'package:smart_lock_app/core/model/login/login_request.dart';
import 'package:smart_lock_app/core/model/login/login_response.dart';
import 'package:smart_lock_app/core/model/package/package_count_response.dart';
import 'package:smart_lock_app/core/model/package/package_list_response.dart';
import 'package:smart_lock_app/core/remote/network/api_url.dart';
import 'package:smart_lock_app/core/remote/network/base_repository.dart';
import 'package:smart_lock_app/utils/enums.dart';

class CommonRepository extends BaseRepository {
  CommonRepository._internal();

  static final instance = CommonRepository._internal();

  /// POST: /Auth/login
  /// Purpose: Authenticates a user and retrieves an access token
  /// Stores the token in secure storage and saves user data in Hive for quick access

  Future<Object?> apiLogin(LoginRequest requestParams) async {
    try {
      final response = await networkRepository.call(
        method: Method.post,
        pathUrl: ApiUrls.pathLogin,
        body: jsonEncode(requestParams.toJson()),
        headers: buildHeaders(),
      );

      final statusCode = response?.statusCode;
      final data = response?.data;

      if (statusCode == HttpStatus.ok) {
        final loginResponse =
        loginResponseFromJson(jsonEncode(data));
        return loginResponse;
      } else {
        final error = errorResponseFromJson(jsonEncode(data));
        return error;
      }
    } catch (e) {
      return ErrorResponse(
        message: "Network error occurred",
        success: false,
      );
    }
  }

  Future<Object?> apiPackageList({
    String? receiverId,
    String? statusId,
    int? pageNumber,
    int? pageSize,
  }) async {
    try {
      final response = await networkRepository.call(
        method: Method.get,
        pathUrl:
        "${ApiUrls.pathPackageList}?receiverId=$receiverId&statusIds=$statusId&pageNumber=$pageNumber&pageSize=$pageSize",
        headers: buildHeaders(),
      );

      final statusCode = response?.statusCode;
      final data = response?.data;

      if (statusCode == HttpStatus.ok) {
        final packageListResponse =
        packageListResponseFromJson(jsonEncode(data));
        return packageListResponse;
      } else {
        final error = errorResponseFromJson(jsonEncode(data));
        return error;
      }
    } catch (e) {
      return ErrorResponse(
        message: "Network error occurred",
        success: false,
      );
    }
  }

  Future<Object?> apiPackageCount({
    String? receiverId,
  }) async {
    try {
      final response = await networkRepository.call(
        method: Method.get,
        pathUrl:
        "${ApiUrls.pathPackageCount}?receiverId=$receiverId",
        headers: buildHeaders(),
      );

      final statusCode = response?.statusCode;
      final data = response?.data;

      if (statusCode == HttpStatus.ok) {
        final packageCountResponse =
        packageCountResponseFromJson(jsonEncode(data));
        return packageCountResponse;
      } else {
        final error = errorResponseFromJson(jsonEncode(data));
        return error;
      }
    } catch (e) {
      return ErrorResponse(
        message: "Network error occurred",
        success: false,
      );
    }
  }
}
