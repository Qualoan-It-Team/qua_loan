

import 'dart:convert';

AadhaarVerificationResponse aadhaarVerificationResponseFromJson(String str) => AadhaarVerificationResponse.fromJson(json.decode(str));

String aadhaarVerificationResponseToJson(AadhaarVerificationResponse data) => json.encode(data.toJson());

class AadhaarVerificationResponse {
    String code;
    Model model;
    String msg;

    AadhaarVerificationResponse({
        required this.code,
        required this.model,
        required this.msg,
    });

    factory AadhaarVerificationResponse.fromJson(Map<String, dynamic> json) => AadhaarVerificationResponse(
        code: json["code"],
        model: Model.fromJson(json["model"]),
        msg: json["msg"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "model": model.toJson(),
        "msg": msg,
    };
}

class Model {
    String transactionId;
    String fwdp;
    String codeVerifier;
    UidaiResponse uidaiResponse;

    Model({
        required this.transactionId,
        required this.fwdp,
        required this.codeVerifier,
        required this.uidaiResponse,
    });

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        transactionId: json["transactionId"],
        fwdp: json["fwdp"],
        codeVerifier: json["codeVerifier"],
        uidaiResponse: UidaiResponse.fromJson(json["uidaiResponse"]),
    );

    Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "fwdp": fwdp,
        "codeVerifier": codeVerifier,
        "uidaiResponse": uidaiResponse.toJson(),
    };
}

class UidaiResponse {
    String message;
    String sessionActive;
    String status;

    UidaiResponse({
        required this.message,
        required this.sessionActive,
        required this.status,
    });

    factory UidaiResponse.fromJson(Map<String, dynamic> json) => UidaiResponse(
        message: json["message"],
        sessionActive: json["sessionActive"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "sessionActive": sessionActive,
        "status": status,
    };
}
