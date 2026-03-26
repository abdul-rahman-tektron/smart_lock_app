import 'dart:convert';

HelpSupportRequest helpSupportRequestFromJson(String str) =>
    HelpSupportRequest.fromJson(json.decode(str));

String helpSupportRequestToJson(HelpSupportRequest data) =>
    json.encode(data.toJson());

class HelpSupportRequest {
  int? flatId;
  String? complaint;
  String? complaintDate;
  String? status;

  HelpSupportRequest({
    this.flatId,
    this.complaint,
    this.complaintDate,
    this.status,
  });

  factory HelpSupportRequest.fromJson(Map<String, dynamic> json) =>
      HelpSupportRequest(
        flatId: json["flatId"],
        complaint: json["complaint"],
        complaintDate: json["complaintDate"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "flatId": flatId,
    "complaint": complaint,
    "complaintDate": complaintDate,
    "status": status,
  };
}