
import 'dart:convert';

LoanStatusResponse loanStatusResponseFromJson(String str) => LoanStatusResponse.fromJson(json.decode(str));

String loanStatusResponseToJson(LoanStatusResponse data) => json.encode(data.toJson());

class LoanStatusResponse {
    String message;
    Journey journey;

    LoanStatusResponse({
        required this.message,
        required this.journey,
    });

    factory LoanStatusResponse.fromJson(Map<String, dynamic> json) => LoanStatusResponse(
        message: json["message"],
        journey: Journey.fromJson(json["journey"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "journey": journey.toJson(),
    };
}

class Journey {
    String loanUnderProcess;
    String sanction;
    String disbursed;
    

    Journey({
        required this.loanUnderProcess,
        required this.sanction,
        required this.disbursed,
      
    });

    factory Journey.fromJson(Map<String, dynamic> json) => Journey(
        loanUnderProcess: json["loanUnderProcess"],
        sanction: json["sanction"],
        disbursed: json["disbursed"],
        
    );

    Map<String, dynamic> toJson() => {
        "loanUnderProcess": loanUnderProcess,
        "sanction": sanction,
        "disbursed": disbursed,
       
        
    };
}
