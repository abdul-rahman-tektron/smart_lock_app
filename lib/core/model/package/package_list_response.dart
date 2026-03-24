// To parse this JSON data, do
//
//     final packageListResponse = packageListResponseFromJson(jsonString);

import 'dart:convert';

PackageListResponse packageListResponseFromJson(String str) => PackageListResponse.fromJson(json.decode(str));

String packageListResponseToJson(PackageListResponse data) => json.encode(data.toJson());

class PackageListResponse {
  bool? success;
  String? message;
  PackageListData? data;

  PackageListResponse({
    this.success,
    this.message,
    this.data,
  });

  factory PackageListResponse.fromJson(Map<String, dynamic> json) => PackageListResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : PackageListData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class PackageListData {
  int? pageNumber;
  int? pageSize;
  int? totalRecords;
  List<PackageListDataItem>? items;

  PackageListData({
    this.pageNumber,
    this.pageSize,
    this.totalRecords,
    this.items,
  });

  factory PackageListData.fromJson(Map<String, dynamic> json) => PackageListData(
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    totalRecords: json["totalRecords"],
    items: json["items"] == null ? [] : List<PackageListDataItem>.from(json["items"]!.map((x) => PackageListDataItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "totalRecords": totalRecords,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class PackageListDataItem {
  int? lockerDetailId;
  int? deviceId;
  int? lockerSizeId;
  int? receiverId;
  int? deliveryAgentId;
  DateTime? createdOn;
  bool? lockerIsActive;
  int? pickupCodeId;
  int? pickupDeviceId;
  String? otpCode;
  DateTime? entryCreatedOn;
  dynamic verifiedOn;
  dynamic totalElapsedMinutes;
  dynamic isPaymentTrue;
  bool? isVerified;
  bool? pickupIsActive;
  int? overdueAfterHours;
  int? graceMinutes;
  int? allowedMinutes;
  int? statusId;
  String? statusName;
  int? totalRecords;

  PackageListDataItem({
    this.lockerDetailId,
    this.deviceId,
    this.lockerSizeId,
    this.receiverId,
    this.deliveryAgentId,
    this.createdOn,
    this.lockerIsActive,
    this.pickupCodeId,
    this.pickupDeviceId,
    this.otpCode,
    this.entryCreatedOn,
    this.verifiedOn,
    this.totalElapsedMinutes,
    this.isPaymentTrue,
    this.isVerified,
    this.pickupIsActive,
    this.overdueAfterHours,
    this.graceMinutes,
    this.allowedMinutes,
    this.statusId,
    this.statusName,
    this.totalRecords,
  });

  factory PackageListDataItem.fromJson(Map<String, dynamic> json) => PackageListDataItem(
    lockerDetailId: json["lockerDetailId"],
    deviceId: json["deviceId"],
    lockerSizeId: json["lockerSizeId"],
    receiverId: json["receiverId"],
    deliveryAgentId: json["deliveryAgentId"],
    createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
    lockerIsActive: json["lockerIsActive"],
    pickupCodeId: json["pickupCodeId"],
    pickupDeviceId: json["pickupDeviceId"],
    otpCode: json["otpCode"],
    entryCreatedOn: json["entryCreatedOn"] == null ? null : DateTime.parse(json["entryCreatedOn"]),
    verifiedOn: json["verifiedOn"],
    totalElapsedMinutes: json["totalElapsedMinutes"],
    isPaymentTrue: json["isPaymentTrue"],
    isVerified: json["isVerified"],
    pickupIsActive: json["pickupIsActive"],
    overdueAfterHours: json["overdueAfterHours"],
    graceMinutes: json["graceMinutes"],
    allowedMinutes: json["allowedMinutes"],
    statusId: json["statusId"],
    statusName: json["statusName"],
    totalRecords: json["totalRecords"],
  );

  Map<String, dynamic> toJson() => {
    "lockerDetailId": lockerDetailId,
    "deviceId": deviceId,
    "lockerSizeId": lockerSizeId,
    "receiverId": receiverId,
    "deliveryAgentId": deliveryAgentId,
    "createdOn": createdOn?.toIso8601String(),
    "lockerIsActive": lockerIsActive,
    "pickupCodeId": pickupCodeId,
    "pickupDeviceId": pickupDeviceId,
    "otpCode": otpCode,
    "entryCreatedOn": entryCreatedOn?.toIso8601String(),
    "verifiedOn": verifiedOn,
    "totalElapsedMinutes": totalElapsedMinutes,
    "isPaymentTrue": isPaymentTrue,
    "isVerified": isVerified,
    "pickupIsActive": pickupIsActive,
    "overdueAfterHours": overdueAfterHours,
    "graceMinutes": graceMinutes,
    "allowedMinutes": allowedMinutes,
    "statusId": statusId,
    "statusName": statusName,
    "totalRecords": totalRecords,
  };
}
