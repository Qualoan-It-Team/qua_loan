// To parse this JSON data, do
//
//     final aadhaarSignOtpResponse = aadhaarSignOtpResponseFromJson(jsonString);

import 'dart:convert';

AadhaarSignOtpResponse aadhaarSignOtpResponseFromJson(String str) => AadhaarSignOtpResponse.fromJson(json.decode(str));

String aadhaarSignOtpResponseToJson(AadhaarSignOtpResponse data) => json.encode(data.toJson());

class AadhaarSignOtpResponse {
    bool success;
    String? token;

    AadhaarSignOtpResponse({
        required this.success,
        this.token,
    });

    factory AadhaarSignOtpResponse.fromJson(Map<String, dynamic> json) => AadhaarSignOtpResponse(
        success: json["success"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "token": token,
    };
}
