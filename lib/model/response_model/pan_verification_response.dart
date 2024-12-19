// To parse this JSON data, do
//
//     final panValidationResponse = panValidationResponseFromJson(jsonString);

import 'dart:convert';

PanVerificationResponse panValidationResponseFromJson(String str) => PanVerificationResponse.fromJson(json.decode(str));

String panValidationResponseToJson(PanVerificationResponse data) => json.encode(data.toJson());

class PanVerificationResponse {
    int httpResponseCode;
    int resultCode;
    String requestId;
    String clientRefNum;
    Result result;

    PanVerificationResponse({
        required this.httpResponseCode,
        required this.resultCode,
        required this.requestId,
        required this.clientRefNum,
        required this.result,
    });

    factory PanVerificationResponse.fromJson(Map<String, dynamic> json) => PanVerificationResponse(
        httpResponseCode: json["http_response_code"],
        resultCode: json["result_code"],
        requestId: json["request_id"],
        clientRefNum: json["client_ref_num"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "http_response_code": httpResponseCode,
        "result_code": resultCode,
        "request_id": requestId,
        "client_ref_num": clientRefNum,
        "result": result.toJson(),
    };
}

class Result {
    String pan;
    String panType;
    String fullname;
    String firstName;
    String middleName;
    String lastName;
    String gender;
    String aadhaarNumber;
    bool aadhaarLinked;
    String dob;
    Address address;
    String mobile;
    String email;

    Result({
        required this.pan,
        required this.panType,
        required this.fullname,
        required this.firstName,
        required this.middleName,
        required this.lastName,
        required this.gender,
        required this.aadhaarNumber,
        required this.aadhaarLinked,
        required this.dob,
        required this.address,
        required this.mobile,
        required this.email,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        pan: json["pan"],
        panType: json["pan_type"],
        fullname: json["fullname"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        aadhaarNumber: json["aadhaar_number"],
        aadhaarLinked: json["aadhaar_linked"],
        dob: json["dob"],
        address: Address.fromJson(json["address"]),
        mobile: json["mobile"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "pan": pan,
        "pan_type": panType,
        "fullname": fullname,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "gender": gender,
        "aadhaar_number": aadhaarNumber,
        "aadhaar_linked": aadhaarLinked,
        "dob": dob,
        "address": address.toJson(),
        "mobile": mobile,
        "email": email,
    };
}

class Address {
    String buildingName;
    String locality;
    String streetName;
    String pincode;
    String city;
    String state;
    String country;

    Address({
        required this.buildingName,
        required this.locality,
        required this.streetName,
        required this.pincode,
        required this.city,
        required this.state,
        required this.country,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        buildingName: json["building_name"],
        locality: json["locality"],
        streetName: json["street_name"],
        pincode: json["pincode"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
    );

    Map<String, dynamic> toJson() => {
        "building_name": buildingName,
        "locality": locality,
        "street_name": streetName,
        "pincode": pincode,
        "city": city,
        "state": state,
        "country": country,
    };
}
