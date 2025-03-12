
import 'dart:convert';

LoanApplicationDetailsRespons loanApplicationDetailsResponsFromJson(String str) => LoanApplicationDetailsRespons.fromJson(json.decode(str));

String loanApplicationDetailsResponsToJson(LoanApplicationDetailsRespons data) => json.encode(data.toJson());

class LoanApplicationDetailsRespons {
    String message;
    Data? data;

    LoanApplicationDetailsRespons({
        required this.message,
         this.data,
    });

    factory LoanApplicationDetailsRespons.fromJson(Map<String, dynamic> json) => LoanApplicationDetailsRespons(
        message: json["message"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null, // Check for null
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? id;
    String? userId;
    LoanDetails? loanDetails;
    String? progressStatus;
    String? previousJourney;
    String? applicationStatus;
    int? v;
    EmployeeDetails? employeeDetails;
    bool? isEmploymentDetailsSaved;
    bool? isDocumentUploaded;
    bool? isDisbursalDetailsSaved;
    bool? isLoanCalculated;
    bool? isBankStatementUploaded;
    DisbursalBankDetails? disbursalBankDetails;
    DateTime? updatedAt;

    Data({
         this.id,
         this.userId,
        this.loanDetails,
         this.progressStatus,
         this.previousJourney,
         this.applicationStatus,
         this.v,
        this.employeeDetails,
         this.isEmploymentDetailsSaved,
         this.isDocumentUploaded,
         this.isDisbursalDetailsSaved,
         this.isLoanCalculated,
        this.disbursalBankDetails,
        this.isBankStatementUploaded,
         this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        userId: json["userId"],
        loanDetails: json["loanDetails"] != null ? LoanDetails.fromJson(json["loanDetails"]) : null,
        progressStatus: json["progressStatus"],
        previousJourney: json["previousJourney"],
        applicationStatus: json["applicationStatus"],
        v: json["__v"],
        employeeDetails: json["employeeDetails"] != null ? EmployeeDetails.fromJson(json["employeeDetails"]) : null,
        isEmploymentDetailsSaved: json["isEmploymentDetailsSaved"],
        isDocumentUploaded: json["isDocumentUploaded"],
        isDisbursalDetailsSaved: json["isDisbursalDetailsSaved"],
        isBankStatementUploaded: json["isBankStatementUploaded"],
        isLoanCalculated: json["isLoanCalculated"],
        disbursalBankDetails: json["disbursalBankDetails"] != null ? DisbursalBankDetails.fromJson(json["disbursalBankDetails"]) : null,
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "loanDetails": loanDetails?.toJson(), 
        "progressStatus": progressStatus,
        "previousJourney": previousJourney,
        "applicationStatus": applicationStatus,
        "__v": v,
        "employeeDetails": employeeDetails?.toJson(),
        "isEmploymentDetailsSaved": isEmploymentDetailsSaved,
        "isDocumentUploaded": isDocumentUploaded,
        "isDisbursalDetailsSaved": isDisbursalDetailsSaved,
        "isLoanCalculated": isLoanCalculated,
        "isBankStatementUploaded":isBankStatementUploaded,
        "disbursalBankDetails": disbursalBankDetails?.toJson(), 
        "updatedAt": updatedAt!.toIso8601String(),
    };
}

class DisbursalBankDetails {
    String? bankName;
    String? accountNumber;
    String? ifscCode;
    String? accountType;
    String? branchName;
    String? beneficiaryName;
    String? id;

    DisbursalBankDetails({
         this.bankName,
         this.accountNumber,
         this.ifscCode,
         this.accountType,
         this.branchName,
         this.beneficiaryName,
         this.id,
    });

    factory DisbursalBankDetails.fromJson(Map<String, dynamic> json) => DisbursalBankDetails(
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
        ifscCode: json["ifscCode"],
        accountType: json["accountType"],
        branchName: json["branchName"],
        beneficiaryName: json["beneficiaryName"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "accountNumber": accountNumber,
        "ifscCode": ifscCode,
        "accountType": accountType,
        "branchName": branchName,
        "beneficiaryName": beneficiaryName,
        "_id": id,
    };
}

class EmployeeDetails {
    String? workFrom;
    String? officeEmail;
    String? companyName;
    String? companyType;
    String? designation;
    String? officeAddrress;
    String? landmark;
    String? city;
    String? state;
    String? pincode;
    String? employedSince;
    String? id;

    EmployeeDetails({
         this.workFrom,
         this.officeEmail,
         this.companyName,
         this.companyType,
         this.designation,
         this.officeAddrress,
         this.landmark,
         this.city,
         this.state,
         this.pincode,
         this.employedSince,
         this.id,
    });

    factory EmployeeDetails.fromJson(Map<String, dynamic> json) => EmployeeDetails(
        workFrom: json["workFrom"],
        officeEmail: json["officeEmail"],
        companyName: json["companyName"],
        companyType: json["companyType"],
        designation: json["designation"],
        officeAddrress: json["officeAddrress"],
        landmark: json["landmark"],
        city: json["city"],
        state: json["state"],
        pincode: json["pincode"],
        employedSince: json["employedSince"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "workFrom": workFrom,
        "officeEmail": officeEmail,
        "companyName": companyName,
        "companyType": companyType,
        "designation": designation,
        "officeAddrress": officeAddrress,
        "landmark": landmark,
        "city": city,
        "state": state,
        "pincode": pincode,
        "employedSince": employedSince,
        "_id": id,
    };
}

class LoanDetails {
    int? principal;
    int? totalPayble;
    double? roi;
    int? tenure;
    String? loanPurpose;
    String? id;

    LoanDetails({
         this.principal,
         this.totalPayble,
         this.roi,
         this.tenure,
         this.loanPurpose,
         this.id,
    });

    factory LoanDetails.fromJson(Map<String, dynamic> json) => LoanDetails(
        principal: json["principal"],
        totalPayble: json["totalPayble"],
        roi: (json["roi"] != null) ? json["roi"].toDouble() : 0.0,
        tenure: json["tenure"],
        loanPurpose: json["loanPurpose"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "principal": principal,
        "totalPayble": totalPayble,
        "roi": roi,
        "tenure": tenure,
        "loanPurpose": loanPurpose,
        "_id": id,
    };
}