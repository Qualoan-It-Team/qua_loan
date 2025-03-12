// To parse this JSON data, do
//
//     final aadhaarSubmitOtpRequest = aadhaarSubmitOtpRequestFromJson(jsonString);

import 'dart:convert';

AadhaarSignInOtpRequest aadhaarSubmitOtpRequestFromJson(String str) => AadhaarSignInOtpRequest.fromJson(json.decode(str));

String aadhaarSubmitOtpRequestToJson(AadhaarSignInOtpRequest data) => json.encode(data.toJson());

class AadhaarSignInOtpRequest {
    // String shareCode;
    String otp;
    String transactionId;
    String codeVerifier;
    String fwdp;
    // bool validateXml;

    AadhaarSignInOtpRequest({
        // required this.shareCode,
        required this.otp,
        required this.transactionId,
        required this.codeVerifier,
        required this.fwdp,
        // required this.validateXml,
    });

    factory AadhaarSignInOtpRequest.fromJson(Map<String, dynamic> json) => AadhaarSignInOtpRequest(
        // shareCode: json["shareCode"],
        otp: json["otp"],
        transactionId: json["transactionId"],
        codeVerifier: json["codeVerifier"],
        fwdp: json["fwdp"],
        // validateXml: json["validateXml"],
    );

    Map<String, dynamic> toJson() => {
        // "shareCode": shareCode,
        "otp": otp,
        "transactionId": transactionId,
        "codeVerifier": codeVerifier,
        "fwdp": fwdp,
        // "validateXml": validateXml,
    };
}
