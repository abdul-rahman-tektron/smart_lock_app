import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:smart_lock_app/core/model/error_response.dart';
import 'package:smart_lock_app/core/model/forgot_password/forgot_password_request.dart';
import 'package:smart_lock_app/core/model/forgot_password/otp_verify_request.dart';
import 'package:smart_lock_app/core/model/forgot_password/reset_password_request.dart';
import 'package:smart_lock_app/core/model/login/login_request.dart';
import 'package:smart_lock_app/core/model/login/login_response.dart';
import 'package:smart_lock_app/core/model/package/package_count_response.dart';
import 'package:smart_lock_app/core/model/package/package_list_response.dart';
import 'package:smart_lock_app/core/model/profile/edit_profile_request.dart';
import 'package:smart_lock_app/core/model/profile/get_profile_response.dart';
import 'package:smart_lock_app/core/model/settings/change_password_request.dart';
import 'package:smart_lock_app/core/model/settings/help_support_request.dart';
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
      String pathUrl = "${ApiUrls.pathPackageList}?receiverId=$receiverId";

      if (statusId != null && statusId.trim().isNotEmpty) {
        pathUrl += "&statusIds=$statusId";
      }

      if (pageNumber != null) {
        pathUrl += "&pageNumber=$pageNumber";
      }

      if (pageSize != null) {
        pathUrl += "&pageSize=$pageSize";
      }

      final response = await networkRepository.call(
        method: Method.get,
        pathUrl: pathUrl,
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

  Future<Object?> apiForgotPassword(ForgotPasswordRequest requestParams) async {
    try {
      final response = await networkRepository.call(
        method: Method.post,
        pathUrl: ApiUrls.pathForgotPassword,
        body: jsonEncode(requestParams.toJson()),
        headers: buildHeaders(),
      );

      final statusCode = response?.statusCode;
      final data = response?.data;

      if (statusCode == HttpStatus.ok) {
        final commonResponse =
        commonResponseFromJson(jsonEncode(data));
        return commonResponse;
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

  Future<Object?> apiOTPVerification(OtpVerifyRequest requestParams) async {
    try {
      final response = await networkRepository.call(
        method: Method.post,
        pathUrl: ApiUrls.pathOTPVerify,
        body: jsonEncode(requestParams.toJson()),
        headers: buildHeaders(),
      );

      final statusCode = response?.statusCode;
      final data = response?.data;

      if (statusCode == HttpStatus.ok) {
        final commonResponse =
        commonResponseFromJson(jsonEncode(data));
        return commonResponse;
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

  Future<Object?> apiResetPassword(ResetPasswordRequest requestParams) async {
    try {
      final response = await networkRepository.call(
        method: Method.post,
        pathUrl: ApiUrls.pathResetPassword,
        body: jsonEncode(requestParams.toJson()),
        headers: buildHeaders(),
      );

      final statusCode = response?.statusCode;
      final data = response?.data;

      if (statusCode == HttpStatus.ok) {
        final commonResponse =
        commonResponseFromJson(jsonEncode(data));
        return commonResponse;
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

  Future<Object?> apiChangePassword(ChangePasswordRequest requestParams) async {
    try {
      final response = await networkRepository.call(
        method: Method.post,
        pathUrl: ApiUrls.pathChangePassword,
        body: jsonEncode(requestParams.toJson()),
        headers: buildHeaders(),
      );

      final statusCode = response?.statusCode;
      final data = response?.data;

      if (statusCode == HttpStatus.ok) {
        final commonResponse =
        commonResponseFromJson(jsonEncode(data));
        return commonResponse;
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

  Future<Object?> apiEditProfile(EditProfileRequest requestParams) async {
    try {
      final formDataMap = <String, dynamic>{
        "FullName": requestParams.fullName,
        "PhoneNumber": requestParams.phoneNumber,
      };

      if (requestParams.password != null &&
          requestParams.password!.trim().isNotEmpty) {
        formDataMap["Password"] = requestParams.password!.trim();
      }

      if (requestParams.profileImage != null) {
        formDataMap["ProfileImage"] = await MultipartFile.fromFile(
          requestParams.profileImage!.path,
          filename: requestParams.profileImage!.path.split('/').last,
        );
      }

      final response = await networkRepository.call(
        method: Method.put,
        pathUrl: "${ApiUrls.pathEditProfile}${requestParams.tenantId}",
        body: FormData.fromMap(formDataMap),
        headers: buildHeaders(isFormData: true),
      );

      final statusCode = response?.statusCode;
      final data = response?.data;

      if (statusCode == HttpStatus.ok) {
        final commonResponse = commonResponseFromJson(jsonEncode(data));
        return commonResponse;
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

  Future<Object?> apiGetProfile(int tenantId) async {
    try {
      final response = await networkRepository.call(
        method: Method.get,
        pathUrl: "${ApiUrls.pathGetProfile}$tenantId",
        headers: buildHeaders(),
      );

      final statusCode = response?.statusCode;
      final data = response?.data;

      if (statusCode == HttpStatus.ok) {
        final getProfileResponse = getProfileResponseFromJson(jsonEncode(data));
        return getProfileResponse;
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

  Future<Object?> apiHelpSupport(HelpSupportRequest requestParams) async {
    try {
      final response = await networkRepository.call(
        method: Method.post,
        pathUrl: ApiUrls.pathHelpSupport,
        body: jsonEncode(requestParams.toJson()),
        headers: buildHeaders(),
      );

      final statusCode = response?.statusCode;
      final data = response?.data;

      if (statusCode == HttpStatus.ok) {
        final commonResponse = commonResponseFromJson(jsonEncode(data));
        return commonResponse;
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
