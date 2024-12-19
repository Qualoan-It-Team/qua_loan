import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints{
EndPoints._();

  // static final String baseUrl = "${dotenv.env["BASE_URL"]}";
  static final String panBaseUrl = "${dotenv.env["PAN_BASE_URL"]}";
  static final String pincodeBaseUrl = "${dotenv.env["PINCODE_BASE_URL"]}";


  //end points 
  
  static final String panApiUrl = "${panBaseUrl}validation/kyc/v1/pan_details";
  static final String aadhaarApiUrl = "${panBaseUrl}ent/v3/kyc/intiate-kyc-auto";
  static final String aadhaarSubmitOtpUrl = "${panBaseUrl}ent/v3/kyc/submit-otp";
  static final String verifyBankDetailsUrl = "${panBaseUrl}penny-drop/v2/check-valid";
  //pincod url 
  static String pincodeApiUrl(String pincode) {
    return "${panBaseUrl}pincode/$pincode";
  }
  // static final String pincodeApiUrl = "${panBaseUrl}pincode/$pincode";

}