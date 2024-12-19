// To parse this JSON data, do
//
//     final verifyBankDetailsRequest = verifyBankDetailsRequestFromJson(jsonString);

import 'dart:convert';

VerifyBankDetailsRequest verifyBankDetailsRequestFromJson(String str) => VerifyBankDetailsRequest.fromJson(json.decode(str));

String verifyBankDetailsRequestToJson(VerifyBankDetailsRequest data) => json.encode(data.toJson());

class VerifyBankDetailsRequest {
    String ifsc;
    String accNo;
    String benificiaryName;

    VerifyBankDetailsRequest({
        required this.ifsc,
        required this.accNo,
        required this.benificiaryName,
    });

    factory VerifyBankDetailsRequest.fromJson(Map<String, dynamic> json) => VerifyBankDetailsRequest(
        ifsc: json["ifsc"],
        accNo: json["accNo"],
        benificiaryName: json["benificiaryName"],
    );

    Map<String, dynamic> toJson() => {
        "ifsc": ifsc,
        "accNo": accNo,
        "benificiaryName": benificiaryName,
    };
}
