import 'dart:convert';

GetProfileResponse getProfileResponseFromJson(String str) =>
    GetProfileResponse.fromJson(json.decode(str));

String getProfileResponseToJson(GetProfileResponse data) =>
    json.encode(data.toJson());

class GetProfileResponse {
  bool? success;
  String? message;
  GetProfileData? data;

  GetProfileResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) =>
      GetProfileResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : GetProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class GetProfileData {
  int? tenantId;
  int? flatId;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? username;
  String? userType;
  bool? isActive;
  String? createdOn;
  String? lastLoginOn;
  String? profileImage;

  GetProfileData({
    this.tenantId,
    this.flatId,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.username,
    this.userType,
    this.isActive,
    this.createdOn,
    this.lastLoginOn,
    this.profileImage,
  });

  factory GetProfileData.fromJson(Map<String, dynamic> json) => GetProfileData(
    tenantId: json["tenantId"],
    flatId: json["flatId"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    username: json["username"],
    userType: json["userType"],
    isActive: json["isActive"],
    createdOn: json["createdOn"],
    lastLoginOn: json["lastLoginOn"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "tenantId": tenantId,
    "flatId": flatId,
    "fullName": fullName,
    "email": email,
    "phoneNumber": phoneNumber,
    "username": username,
    "userType": userType,
    "isActive": isActive,
    "createdOn": createdOn,
    "lastLoginOn": lastLoginOn,
    "profileImage": profileImage,
  };
}