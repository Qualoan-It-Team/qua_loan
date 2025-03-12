
import 'dart:convert';

AadhaarSignResponse aadhaarSignResponseFromJson(String str) => AadhaarSignResponse.fromJson(json.decode(str));

String aadhaarSignResponseToJson(AadhaarSignResponse data) => json.encode(data.toJson());

class AadhaarSignResponse {
    bool success;
    String message;
    bool isAlreadyRegisterdUser;
    String? transactionId;
    String?fwdp;
    String? mobileNumber;
    String? codeVerifier;

    AadhaarSignResponse({
        required this.success,
        required this.message,
        required this.isAlreadyRegisterdUser,
         this.transactionId,
         this.fwdp,
         this.mobileNumber,
         this.codeVerifier,
    });

    factory AadhaarSignResponse.fromJson(Map<String, dynamic> json) => AadhaarSignResponse(
        success: json["success"],
        message: json["message"],
        isAlreadyRegisterdUser: json["isAlreadyRegisterdUser"],
        transactionId: json["transactionId"],
        fwdp: json["fwdp"],
        codeVerifier: json["codeVerifier"],
        mobileNumber: json["mobileNumber"],

    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "isAlreadyRegisterdUser": isAlreadyRegisterdUser,
        "transactionId": transactionId,
        "fwdp": fwdp,
        "codeVerifier": codeVerifier,
        "mobileNumber": mobileNumber,
    };
}
