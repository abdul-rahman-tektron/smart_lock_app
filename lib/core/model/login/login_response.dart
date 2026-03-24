// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? success;
  dynamic message;
  UserData? data;

  LoginResponse({
    this.success,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : UserData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class UserData {
  int? tenantId;
  int? flatId;
  String? email;
  String? fullName;
  String? phoneNumber;
  String? username;
  String? userType;
  bool? isActive;
  DateTime? createdOn;
  DateTime? lastLoginOn;
  String? buildingName;
  int? floorNo;
  String? flatNo;
  String? token;

  UserData({
    this.tenantId,
    this.flatId,
    this.email,
    this.fullName,
    this.phoneNumber,
    this.username,
    this.userType,
    this.isActive,
    this.createdOn,
    this.lastLoginOn,
    this.buildingName,
    this.floorNo,
    this.flatNo,
    this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    tenantId: json["tenantId"],
    flatId: json["flatId"],
    email: json["email"],
    fullName: json["fullName"],
    phoneNumber: json["phoneNumber"],
    username: json["username"],
    userType: json["userType"],
    isActive: json["isActive"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    lastLoginOn: json["lastLoginOn"] == null ? null : DateTime.parse(json["lastLoginOn"]),
    buildingName: json["buildingName"],
    floorNo: json["floorNo"],
    flatNo: json["flatNo"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "tenantId": tenantId,
    "flatId": flatId,
    "email": email,
    "fullName": fullName,
    "phoneNumber": phoneNumber,
    "username": username,
    "userType": userType,
    "isActive": isActive,
    "createdOn": createdOn?.toIso8601String(),
    "lastLoginOn": lastLoginOn?.toIso8601String(),
    "buildingName": buildingName,
    "floorNo": floorNo,
    "flatNo": flatNo,
    "token": token,
  };
}
