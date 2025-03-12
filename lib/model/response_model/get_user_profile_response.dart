// To parse this JSON data, do
//
//     final getUserProfileResponse = getUserProfileResponseFromJson(jsonString);

import 'dart:convert';

GetUserProfileResponse getUserProfileResponseFromJson(String str) => GetUserProfileResponse.fromJson(json.decode(str));

String getUserProfileResponseToJson(GetUserProfileResponse data) => json.encode(data.toJson());

class GetUserProfileResponse {
    bool success;
    Data data;

    GetUserProfileResponse({
        required this.success,
        required this.data,
    });

    factory GetUserProfileResponse.fromJson(Map<String, dynamic> json) => GetUserProfileResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
    };
}

class Data {
    String? profileImage;
    String name;

    Data({
         this.profileImage,
        required this.name,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        profileImage: json["profileImage"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "profileImage": profileImage,
        "name": name,
    };
}
