// To parse this JSON data, do
//
//     final panValidationRequest = panValidationRequestFromJson(jsonString);

import 'dart:convert';

PanVerificationRequest panValidationRequestFromJson(String str) => PanVerificationRequest.fromJson(json.decode(str));

String panValidationRequestToJson(PanVerificationRequest data) => json.encode(data.toJson());

class PanVerificationRequest {
    String clientRefNum;
    String pan;

    PanVerificationRequest({
        required this.clientRefNum,
        required this.pan,
    });

    factory PanVerificationRequest.fromJson(Map<String, dynamic> json) => PanVerificationRequest(
        clientRefNum: json["client_ref_num"],
        pan: json["pan"],
    );

    Map<String, dynamic> toJson() => {
        "client_ref_num": clientRefNum,
        "pan": pan,
    };
}
