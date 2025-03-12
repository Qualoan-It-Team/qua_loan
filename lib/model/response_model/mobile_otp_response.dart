// To parse this JSON data, do
//
//     final mobileOtpResponse = mobileOtpResponseFromJson(jsonString);

import 'dart:convert';

MobileOtpResponse mobileOtpResponseFromJson(String str) => MobileOtpResponse.fromJson(json.decode(str));

String mobileOtpResponseToJson(MobileOtpResponse data) => json.encode(data.toJson());

class MobileOtpResponse {
    bool success;
    String message;
    String? token;

    MobileOtpResponse({
        required this.success,
        required this.message,
        this.token
    });

    factory MobileOtpResponse.fromJson(Map<String, dynamic> json) => MobileOtpResponse(
        success: json["success"],
        message: json["message"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token,
    };
}
