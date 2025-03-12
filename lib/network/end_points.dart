import 'package:flutter_dotenv/flutter_dotenv.dart';

class EndPoints{
EndPoints._();

  static final String digitapBaseUrl = "${dotenv.env["DIGITAP_BASE_URL"]}";
  static final String crmBaseUrl = "${dotenv.env["LOCAL_BASE_URL"]}";




  // qua loan app apis 
  static final  String localAadhaarUrl = "${crmBaseUrl}aadhaar-login/";
  static final  String localHostAadhaarOtp = "${crmBaseUrl}submit-aadhaar-otp";
   static final  String localHostGetMobileOtpUrl = "${crmBaseUrl}mobile/get-otp/";
  static final  String localHostMobileOtp = "${crmBaseUrl}mobile/verify-otp";
  static final  String localHostGetLoanApplicationDetailsUrl = "${crmBaseUrl}getApplicationDetails";
  static final  String localHostGetUserProfileUrl = "${crmBaseUrl}getProfile";
  static final  String localHostGetJourney = "${crmBaseUrl}getJourney";
  static final  String localHostLoanList= "${crmBaseUrl}loanList";
  static final  String localHostLogout= "${crmBaseUrl}logout";
  static final  String localHostLoanPaynow= "${crmBaseUrl}payNow";
  static final  String localHostDisbursalBankDetails= "${crmBaseUrl}disbursalBankDetails";
  static final  String localHostAddEmploymentInfo= "${crmBaseUrl}addEmploymentInfo";
  static final  String localHostApplyLoan= "${crmBaseUrl}applyLoan";
  static final  String localHostUploadDocuments= "${crmBaseUrl}uploadDocuments";
  static final  String localHostGetProfileDetails= "${crmBaseUrl}getProfileDetails";
  static final  String localHostGetDocumentList= "${crmBaseUrl}getDocumentList";
  static final  String localHostDocumentPreview= "${crmBaseUrl}documentPreview?docType=";
  static final  String localHostCurrentResidence= "${crmBaseUrl}currentResidence";
  static final  String localHostAddIncomeDetails= "${crmBaseUrl}addIncomeDetails";
  static final  String localHostPersonalInfo= "${crmBaseUrl}personalInfo";
  static final  String localHostGetDashboardDetails= "${crmBaseUrl}getDashboardDetails";
  static final  String localHostVerifyPan= "${crmBaseUrl}verifyPAN/";
  static final  String localHostUploadProfile= "${crmBaseUrl}uploadProfile";
  static final  String localHostFormUrl= "${crmBaseUrl}addFormDetails";
  static const  String paytringUrl= "https://api.paytring.com/pay/token/";
  static const  String ifscCodeApiUrl= "https://ifsc.razorpay.com/";
  static const  String pincodeUrl= "https://api.postalpincode.in/pincode/";

  //some link urls
  static const  String playStoreUrl= "https://play.google.com/store/apps/details?id=com.whatsapp";
  static const  String appStoreUrl= "https://apps.apple.com/app/whatsapp-messenger/id310633997";
  // static const  String playStoreUrl= "https://play.google.com/store/apps/details?id=com.whatsapp";
  // static const  String playStoreUrl= "https://play.google.com/store/apps/details?id=com.whatsapp";
  //pincod url 
  static String pincodeApiUrl(String pincode) {
    return "${digitapBaseUrl}pincode/$pincode";
  }


}