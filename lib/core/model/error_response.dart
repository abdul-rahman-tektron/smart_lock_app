import 'dart:convert';
// To parse this JSON data, do
//
//     final errorResponse = errorResponseFromJson(jsonString);

ErrorResponse errorResponseFromJson(String str) => ErrorResponse.fromJson(json.decode(str));

String errorResponseToJson(ErrorResponse data) => json.encode(data.toJson());

class ErrorResponse {
  bool? success;
  String? message;
  dynamic data;

  ErrorResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}


// To parse this JSON data, do
//
//     final errorListResponse = errorListResponseFromJson(jsonString);

ErrorListResponse errorListResponseFromJson(String str) => ErrorListResponse.fromJson(json.decode(str));

String errorListResponseToJson(ErrorListResponse data) => json.encode(data.toJson());

class ErrorListResponse {
  bool? status;
  String? message;
  List<dynamic>? result;

  ErrorListResponse({
    this.status,
    this.message,
    this.result,
  });

  factory ErrorListResponse.fromJson(Map<String, dynamic> json) => ErrorListResponse(
    status: json["Status"],
    message: json["Message"],
    result: json["Result"] == null ? [] : List<dynamic>.from(json["Result"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Result": result == null ? [] : List<dynamic>.from(result!.map((x) => x)),
  };
}
