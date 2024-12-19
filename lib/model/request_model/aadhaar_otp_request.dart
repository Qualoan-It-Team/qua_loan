// To parse this JSON data, do
//
//     final aadhaarSubmitOtpRequest = aadhaarSubmitOtpRequestFromJson(jsonString);

import 'dart:convert';

AadhaarSubmitOtpRequest aadhaarSubmitOtpRequestFromJson(String str) => AadhaarSubmitOtpRequest.fromJson(json.decode(str));

String aadhaarSubmitOtpRequestToJson(AadhaarSubmitOtpRequest data) => json.encode(data.toJson());

class AadhaarSubmitOtpRequest {
    String shareCode;
    String otp;
    String transactionId;
    String codeVerifier;
    String fwdp;
    bool validateXml;

    AadhaarSubmitOtpRequest({
        required this.shareCode,
        required this.otp,
        required this.transactionId,
        required this.codeVerifier,
        required this.fwdp,
        required this.validateXml,
    });

    factory AadhaarSubmitOtpRequest.fromJson(Map<String, dynamic> json) => AadhaarSubmitOtpRequest(
        shareCode: json["shareCode"],
        otp: json["otp"],
        transactionId: json["transactionId"],
        codeVerifier: json["codeVerifier"],
        fwdp: json["fwdp"],
        validateXml: json["validateXml"],
    );

    Map<String, dynamic> toJson() => {
        "shareCode": shareCode,
        "otp": otp,
        "transactionId": transactionId,
        "codeVerifier": codeVerifier,
        "fwdp": fwdp,
        "validateXml": validateXml,
    };
}
