// To parse this JSON data, do
//
//     final showLoanDetailsResponse = showLoanDetailsResponseFromJson(jsonString);

import 'dart:convert';

ShowLoanDetailsResponse showLoanDetailsResponseFromJson(String str) => ShowLoanDetailsResponse.fromJson(json.decode(str));

String showLoanDetailsResponseToJson(ShowLoanDetailsResponse data) => json.encode(data.toJson());

class ShowLoanDetailsResponse {
    String message;
    List<LoanList> loanList;

    ShowLoanDetailsResponse({
        required this.message,
        required this.loanList,
    });

    factory ShowLoanDetailsResponse.fromJson(Map<String, dynamic> json) => ShowLoanDetailsResponse(
        message: json["message"],
        loanList: List<LoanList>.from(json["loanList"].map((x) => LoanList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "loanList": List<dynamic>.from(loanList.map((x) => x.toJson())),
    };
}

class LoanList {
    String id;
    String pan;
    String loanNo;
    bool isActive;
    bool isClosed;
    bool isDisbursed;
    int dpd;
    double outstandingAmount;
    double repaymentAmount;
    DateTime repaymentDate;

    LoanList({
        required this.id,
        required this.pan,
        required this.loanNo,
        required this.isActive,
        required this.isClosed,
        required this.isDisbursed,
        required this.dpd,
        required this.outstandingAmount,
        required this.repaymentAmount,
        required this.repaymentDate,
    });

    factory LoanList.fromJson(Map<String, dynamic> json) => LoanList(
        id: json["_id"],
        pan: json["pan"],
        loanNo: json["loanNo"],
        isActive: json["isActive"],
        isClosed: json["isClosed"],
        isDisbursed: json["isDisbursed"],
        dpd: json["dpd"],
        outstandingAmount: _parseDouble(json["outstandingAmount"]),
        repaymentAmount: _parseDouble(json["repaymentAmount"]),
        // outstandingAmount: json["outstandingAmount"],
        // repaymentAmount: json["repaymentAmount"],
        repaymentDate: DateTime.parse(json["repaymentDate"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "pan": pan,
        "loanNo": loanNo,
        "isActive": isActive,
        "isClosed": isClosed,
        "isDisbursed": isDisbursed,
        "dpd": dpd,
        "outstandingAmount": outstandingAmount,
        "repaymentAmount": repaymentAmount,
        "repaymentDate": repaymentDate.toIso8601String(),
    };
    static double _parseDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return 0.0; // or handle the error as needed
    }
  }
}
