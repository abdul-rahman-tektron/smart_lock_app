// To parse this JSON data, do
//
//     final changePasswordRequest = changePasswordRequestFromJson(jsonString);

import 'dart:convert';

ChangePasswordRequest changePasswordRequestFromJson(String str) => ChangePasswordRequest.fromJson(json.decode(str));

String changePasswordRequestToJson(ChangePasswordRequest data) => json.encode(data.toJson());

class ChangePasswordRequest {
  int? tenantId;
  String? oldPassword;
  String? newPassword;

  ChangePasswordRequest({
    this.tenantId,
    this.oldPassword,
    this.newPassword,
  });

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) => ChangePasswordRequest(
    tenantId: json["tenantId"],
    oldPassword: json["oldPassword"],
    newPassword: json["newPassword"],
  );

  Map<String, dynamic> toJson() => {
    "tenantId": tenantId,
    "oldPassword": oldPassword,
    "newPassword": newPassword,
  };
}
