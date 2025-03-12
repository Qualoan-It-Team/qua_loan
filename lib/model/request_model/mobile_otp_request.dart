// To parse this JSON data, do
//
//     final mobileOtpRequest = mobileOtpRequestFromJson(jsonString);

import 'dart:convert';

MobileOtpRequest mobileOtpRequestFromJson(String str) => MobileOtpRequest.fromJson(json.decode(str));

String mobileOtpRequestToJson(MobileOtpRequest data) => json.encode(data.toJson());

class MobileOtpRequest {
    String mobile;
    String otp;
    bool?isAlreadyRegisterdUser;

    MobileOtpRequest({
        required this.mobile,
        required this.otp,
        this.isAlreadyRegisterdUser
    });

    factory MobileOtpRequest.fromJson(Map<String, dynamic> json) => MobileOtpRequest(
        mobile: json["mobile"],
        otp: json["otp"],
        isAlreadyRegisterdUser: json["isAlreadyRegisterdUser"],
    );

    Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "otp": otp,
        "isAlreadyRegisterdUser": isAlreadyRegisterdUser,
    };
}
