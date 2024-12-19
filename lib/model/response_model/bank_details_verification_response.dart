

import 'dart:convert';

VerifyBankDetailsResponse verifyBankDetailsResponseFromJson(String str) => VerifyBankDetailsResponse.fromJson(json.decode(str));

String verifyBankDetailsResponseToJson(VerifyBankDetailsResponse data) => json.encode(data.toJson());

class VerifyBankDetailsResponse {
    String code;
    Model model;

    VerifyBankDetailsResponse({
        required this.code,
        required this.model,
    });

    factory VerifyBankDetailsResponse.fromJson(Map<String, dynamic> json) => VerifyBankDetailsResponse(
        code: json["code"],
        model: Model.fromJson(json["model"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "model": model.toJson(),
    };
}

class Model {
    String status;
    String clientRefNum;
    String beneficiaryName;
    bool isNameMatch;
    String rrn;
    int matchingScore;
    String paymentMode;
    String transactionId;

    Model({
        required this.status,
        required this.clientRefNum,
        required this.beneficiaryName,
        required this.isNameMatch,
        required this.rrn,
        required this.matchingScore,
        required this.paymentMode,
        required this.transactionId,
    });

    factory Model.fromJson(Map<String, dynamic> json) => Model(
        status: json["status"],
        clientRefNum: json["clientRefNum"],
        beneficiaryName: json["beneficiaryName"],
        isNameMatch: json["isNameMatch"],
        rrn: json["rrn"],
        matchingScore: json["matchingScore"],
        paymentMode: json["paymentMode"],
        transactionId: json["transactionId"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "clientRefNum": clientRefNum,
        "beneficiaryName": beneficiaryName,
        "isNameMatch": isNameMatch,
        "rrn": rrn,
        "matchingScore": matchingScore,
        "paymentMode": paymentMode,
        "transactionId": transactionId,
    };
}
