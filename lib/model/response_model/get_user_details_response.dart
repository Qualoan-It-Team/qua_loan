

// import 'dart:convert';

// GetProfileDetailsResponse getProfileDetailsResponseFromJson(String str) => GetProfileDetailsResponse.fromJson(json.decode(str));

// String getProfileDetailsResponseToJson(GetProfileDetailsResponse data) => json.encode(data.toJson());

// class GetProfileDetailsResponse {
//     bool success;
//     Data data;

//     GetProfileDetailsResponse({
//         required this.success,
//         required this.data,
//     });

//     factory GetProfileDetailsResponse.fromJson(Map<String, dynamic> json) => GetProfileDetailsResponse(
//         success: json["success"],
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "success": success,
//         "data": data,
//     };
// }

// class Data {
//     String mobile;
//     String? pan;
//     String aadhaarNumber;
//     PersonalDetails personalDetails;
//     // Residence? residence;
//     // IncomeDetails? incomeDetails;
//     String? profileImage;

//     Data({
//         required this.mobile,
//          this.pan,
//         required this.aadhaarNumber,
//         required this.personalDetails,
//         //  this.residence,
//         //  this.incomeDetails,
//          this.profileImage,
//     });

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         mobile: json["mobile"],
//         pan: json["PAN"],
//         aadhaarNumber: json["aadhaarNumber"],
//         personalDetails: PersonalDetails.fromJson(json["personalDetails"]),
//         // residence: Residence.fromJson(json["residence"]),
//         // incomeDetails: IncomeDetails.fromJson(json["incomeDetails"]),
//         profileImage: json["profileImage"],
//     );

//     Map<String, dynamic> toJson() => {
//         "mobile": mobile,
//         "PAN": pan,
//         "aadhaarNumber": aadhaarNumber,
//         "personalDetails": personalDetails.toJson(),
//         // "residence": residence,
//         // "incomeDetails": incomeDetails,
//         "profileImage": profileImage,
//     };
// }

// // class IncomeDetails {
// //     String employementType;
// //     int monthlyIncome;
// //     dynamic obligations;
// //     DateTime nextSalaryDate;
// //     String incomeMode;
// //     String id;

// //     IncomeDetails({
// //         required this.employementType,
// //         required this.monthlyIncome,
// //         required this.obligations,
// //         required this.nextSalaryDate,
// //         required this.incomeMode,
// //         required this.id,
// //     });

//     // factory IncomeDetails.fromJson(Map<String, dynamic> json) => IncomeDetails(
//     //     employementType: json["employementType"],
//     //     monthlyIncome: json["monthlyIncome"],
//     //     obligations: json["obligations"],
//     //     nextSalaryDate: DateTime.parse(json["nextSalaryDate"]),
//     //     incomeMode: json["incomeMode"],
//     //     id: json["_id"],
//     // );

//     // Map<String, dynamic> toJson() => {
//     //     "employementType": employementType,
//     //     "monthlyIncome": monthlyIncome,
//     //     "obligations": obligations,
//     //     "nextSalaryDate": nextSalaryDate.toIso8601String(),
//     //     "incomeMode": incomeMode,
//     //     "_id": id,
//     // };
// // }

// class PersonalDetails {
//     String fullName;
//     String gender;
//     String dob;
//     String? personalEmail;
//     String? spouseName;
//     String? maritalStatus;
//     String id;

//     PersonalDetails({
//         required this.fullName,
//         required this.gender,
//         required this.dob,
//          this.personalEmail,
//        this.spouseName,
//        this.maritalStatus,
//         required this.id,
//     });

//     factory PersonalDetails.fromJson(Map<String, dynamic> json) => PersonalDetails(
//         fullName: json["fullName"],
//         gender: json["gender"],
//         dob: json["dob"],
//         personalEmail: json["personalEmail"],
//         spouseName: json["spouseName"],
//         maritalStatus: json["maritalStatus"],
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "fullName": fullName,
//         "gender": gender,
//         "dob": dob,
//         "personalEmail": personalEmail,
//         "spouseName": spouseName,
//         "maritalStatus": maritalStatus,
//         "_id": id,
//     };
// }

// // class Residence {
// //     String? address;
// //     String? landmark;
// //     String? city;
// //     String? state;
// //     String? pincode;
// //     String? residenceType;
// //     String? id;

// //     Residence({
// //          this.address,
// //          this.landmark,
// //          this.city,
// //          this.state,
// //          this.pincode,
// //          this.residenceType,
// //          this.id,
// //     });

// //     factory Residence.fromJson(Map<String, dynamic> json) => Residence(
// //         address: json["address"],
// //         landmark: json["landmark"],
// //         city: json["city"],
// //         state: json["state"],
// //         pincode: json["pincode"],
// //         residenceType: json["residenceType"],
// //         id: json["_id"],
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "address": address,
// //         "landmark": landmark,
// //         "city": city,
// //         "state": state,
// //         "pincode": pincode,
// //         "residenceType": residenceType,
// //         "_id": id,
// //     };
// // }
class GetProfileDetailsResponse {
    bool success;
    Data data;

    GetProfileDetailsResponse({
        required this.success,
        required this.data,
    });

    factory GetProfileDetailsResponse.fromJson(Map<String, dynamic> json) => GetProfileDetailsResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
    };
}

class Data {
    String? mobile;
    String? pan;
    String? aadhaarNumber;
    PersonalDetails? personalDetails;
    Residence? residence; 
    IncomeDetails? incomeDetails;
    String? profileImage;

    Data({
        required this.mobile,
        this.pan,
        required this.aadhaarNumber,
        this.personalDetails,
        this.residence,
        this.incomeDetails,
        this.profileImage,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        mobile: json["mobile"],
        pan: json["PAN"],
        aadhaarNumber: json["aadhaarNumber"],
        personalDetails: PersonalDetails.fromJson(json["personalDetails"]),
        residence: json["residence"] != null ? Residence.fromJson(json["residence"]) : null,
        incomeDetails: json["incomeDetails"] != null ? IncomeDetails.fromJson(json["incomeDetails"]) : null,
        profileImage: json["profileImage"],
    );

    Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "PAN": pan,
        "aadhaarNumber": aadhaarNumber,
        "personalDetails": personalDetails,
        "residence": residence?.toJson(), 
        "incomeDetails": incomeDetails?.toJson(), 
        "profileImage": profileImage,
    };
}

class IncomeDetails {
    String employementType;
    int monthlyIncome;
    dynamic obligations;
    DateTime nextSalaryDate;
    String? workingSince;
    String incomeMode;
    String id;

    IncomeDetails({
        required this.employementType,
        required this.monthlyIncome,
        required this.obligations,
        required this.nextSalaryDate,
        required this.workingSince,
        required this.incomeMode,
        required this.id,
    });

    factory IncomeDetails.fromJson(Map<String, dynamic> json) => IncomeDetails(
        employementType: json["employementType"],
        monthlyIncome: json["monthlyIncome"],
        obligations: json["obligations"],
        nextSalaryDate: DateTime.parse(json["nextSalaryDate"]),
        workingSince: json["workingSince"],
        incomeMode: json["incomeMode"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "employementType": employementType,
        "monthlyIncome": monthlyIncome,
        "obligations": obligations,
        "nextSalaryDate": nextSalaryDate.toIso8601String(),
        "workingSince": workingSince,
        "incomeMode": incomeMode,
        "_id": id,
    };
}

class PersonalDetails {
    String? fullName;
    String? gender;
    String? dob;
    String? personalEmail;
    String? mothersName;
    String? spouseName;
    String? maritalStatus;
    String? fathersName;
    String? id;

    PersonalDetails({
         this.fullName,
         this.gender,
         this.dob,
        this.personalEmail,
        this.spouseName,
        this.maritalStatus,
        this.mothersName,
        this.fathersName,
         this.id,
    });

    factory PersonalDetails.fromJson(Map<String, dynamic> json) => PersonalDetails(
        fullName: json["fullName"],
        gender: json["gender"],
        dob: json["dob"],
        personalEmail: json["personalEmail"],
        spouseName: json["spouseName"],
        maritalStatus: json["maritalStatus"],
        mothersName: json["mothersName"],
        fathersName: json["fathersName"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "gender": gender,
        "dob": dob,
        "personalEmail": personalEmail,
        "spouseName": spouseName,
        "mothersName": mothersName,
        "maritalStatus": maritalStatus,
        "fathersName": fathersName,
        "_id": id,
    };
}

class Residence {
    String? address;
    String? landmark;
    String? city;
    String? state;
    String? pincode;
    String? residenceType;
    String? residingSince;
    String? id;

    Residence({
        this.address,
        this.landmark,
        this.city,
        this.state,
        this.pincode,
        this.residenceType,
        this.id,
        this.residingSince
    });

    factory Residence.fromJson(Map<String, dynamic> json) => Residence(
        address: json["address"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        residenceType: json["residenceType"],
        residingSince: json["residingSince"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "landmark": landmark,
        "city": city,
        "state": state,
        "pincode": pincode,
        "residenceType": residenceType,
        "residingSince": residingSince,
        "_id": id,
    };
}