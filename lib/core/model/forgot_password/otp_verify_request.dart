// To parse this JSON data, do
//
//     final otpVerifyRequest = otpVerifyRequestFromJson(jsonString);

import 'dart:convert';

OtpVerifyRequest otpVerifyRequestFromJson(String str) => OtpVerifyRequest.fromJson(json.decode(str));

String otpVerifyRequestToJson(OtpVerifyRequest data) => json.encode(data.toJson());

class OtpVerifyRequest {
  String? email;
  String? otp;

  OtpVerifyRequest({
    this.email,
    this.otp,
  });

  factory OtpVerifyRequest.fromJson(Map<String, dynamic> json) => OtpVerifyRequest(
    email: json["email"],
    otp: json["otp"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "otp": otp,
  };
}
