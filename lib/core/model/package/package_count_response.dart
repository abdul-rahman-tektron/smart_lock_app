// To parse this JSON data, do
//
//     final packageCountResponse = packageCountResponseFromJson(jsonString);

import 'dart:convert';

PackageCountResponse packageCountResponseFromJson(String str) => PackageCountResponse.fromJson(json.decode(str));

String packageCountResponseToJson(PackageCountResponse data) => json.encode(data.toJson());

class PackageCountResponse {
  bool? success;
  String? message;
  PackageCountData? data;

  PackageCountResponse({
    this.success,
    this.message,
    this.data,
  });

  factory PackageCountResponse.fromJson(Map<String, dynamic> json) => PackageCountResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : PackageCountData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class PackageCountData {
  int? activeCount;
  int? overdueCount;
  int? completedCount;
  int? totalCount;

  PackageCountData({
    this.activeCount,
    this.overdueCount,
    this.completedCount,
    this.totalCount,
  });

  factory PackageCountData.fromJson(Map<String, dynamic> json) => PackageCountData(
    activeCount: json["activeCount"],
    overdueCount: json["overdueCount"],
    completedCount: json["completedCount"],
    totalCount: json["totalCount"],
  );

  Map<String, dynamic> toJson() => {
    "activeCount": activeCount,
    "overdueCount": overdueCount,
    "completedCount": completedCount,
    "totalCount": totalCount,
  };
}
