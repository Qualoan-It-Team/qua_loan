

import 'dart:convert';

AadhaarVerificationRequest aadhaarVerificationRequestFromJson(String str) => AadhaarVerificationRequest.fromJson(json.decode(str));

String aadhaarVerificationRequestToJson(AadhaarVerificationRequest data) => json.encode(data.toJson());

class AadhaarVerificationRequest {
    String uniqueId;
    String uid;

    AadhaarVerificationRequest({
        required this.uniqueId,
        required this.uid,
    });

    factory AadhaarVerificationRequest.fromJson(Map<String, dynamic> json) => AadhaarVerificationRequest(
        uniqueId: json["uniqueId"],
        uid: json["uid"],
    );

    Map<String, dynamic> toJson() => {
        "uniqueId": uniqueId,
        "uid": uid,
    };
}
