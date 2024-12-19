import 'dart:async';
import 'dart:convert';
import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/controller/aadhaar_otp_controller.dart';
import 'package:app_here/controller/bank_details_controller.dart';
import 'package:app_here/controller/employment_verification_controller.dart';
import 'package:app_here/controller/pan_kyc_verification_controller.dart';
import 'package:app_here/controller/upload_bank_statement_controller.dart';
import 'package:app_here/controller/upload_salary_slip_controller.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
class LoginOtpController extends GetxController {
  Timer? timer;
  int remainingTime = 600;
  bool isTimerExpired = false;
   var userData = {};
  var otp = '';
  String? customerLeadId;
  String message = "I need help";
// String mobileNumber = "7505289024";
//  final String? phoneNumber = Get.arguments;
 String? phoneNumber ;
  final List<TextEditingController> otpControllers = List.generate(4, (index) => TextEditingController());

  @override
  void onInit() {
    super.onInit();
    // Get.put(PanKycVerificationController());
    phoneNumber = Get.arguments;
    startTimer();
  }

// this method for show the timer on otp verification screen
  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        isTimerExpired = true;
        timer.cancel();
      }
      update();
    });
  }

  
////Whatsapp method
  whatsApp() async {
    const phoneNumber = '917505289024';
    const message = 'We want to get more details about the Loan';
    final url = 'https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url'); // Log the error
      // Redirect to WhatsApp installation page based on the platform
      if (Theme.of(Get.context!).platform == TargetPlatform.android) {
        // For Android
        const playStoreUrl = 'https://play.google.com/store/apps/details?id=com.whatsapp';
        await launch(playStoreUrl);
      } else if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
        // For iOS
        const appStoreUrl = 'https://apps.apple.com/app/whatsapp-messenger/id310633997';
        await launch(appStoreUrl);
      } else {
        // Optionally handle other platforms or show a message
        // Get.snackbar('Error', 'WhatsApp is not installed and cannot be redirected for installation.');
        Get.snackbar('Error', 'WhatsApp is not installed and cannot be redirected for installation.');
      }
    }

  }

Future<void> verifyMobileOtp(String mobile, String otp) async {
  const String url = 'https://api.salary4sure.com/sla-verify-customer-mobile';
  try {
    // Join the OTP from the text controllers
    String otp = otpControllers.map((controller) => controller.text).join('').trim();
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
      },
      body: jsonEncode({
        'mobile': phoneNumber,
        'otp': otp,
      }),
    );

    print('Request URL: $url');
    print('Request Body: ${jsonEncode({'mobile': phoneNumber, 'otp': otp})}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      // Handle successful response
      var responseData = jsonDecode(response.body);
      print("method called");
      // Check if the API status is 200
      if (responseData['ApiStatus'] == 200) {
        // Extract the customer lead ID from the response
        String customerLeadId = responseData['Data']['customer_lead_id'];
        Get.put(PanKycVerificationController()).setCustomerLeadId(customerLeadId.toString().trim());
        Get.put(EmploymentVerificationController()).setCustomerLeadId(customerLeadId.toString().trim());
        Get.put(BankDetailsController()).setCustomerLeadId(customerLeadId.toString().trim());
        Get.put(AadhaarOtpVerificationController()).setCustomerLeadId(customerLeadId.toString().trim());
        Get.put(UploadBankStatementController()).setCustomerLeadId(customerLeadId.toString().trim());
        Get.put(UploadSalarySlipController()).setCustomerLeadId(customerLeadId.toString().trim());
        print('Customer Lead ID: $customerLeadId'); // You can use the lead ID as needed

        Get.snackbar(
          backgroundColor: AppColors.black,
          colorText: AppColors.green,
          'Success', 'OTP verified successfully!');
        
        Get.toNamed(MyAppRoutes.dashboardScreen);
        // Get.toNamed(MyAppRoutes.uploadBankStatementScreen);
      } else {

        // Handle case where API status is not 200
        Get.snackbar(
          backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
          'Error', responseData['Message'] ?? 'Failed to verify OTP');
      }
    } else {
      // Handle error response
      var errorData = jsonDecode(response.body);
      Get.snackbar(
        backgroundColor: AppColors.logoRedColor,
        colorText: Colors.white,
        'Error', errorData['Message'] ?? 'Failed to verify OTP');
    }
  } catch (e) {
    print('Exception occurred: $e');
  }
}


Future<void> resendOtp(String mobile) async {
  const String url = 'https://api.salary4sure.com/sla-resend-otp';
  try {
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
      },
      body: jsonEncode({'mobile': mobile}),
    );

    print('Request URL: $url');
    print('Request Body: ${jsonEncode({'mobile': mobile})}');
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      Get.snackbar(
        backgroundColor: AppColors.black,
        colorText: AppColors.green,
        'Success', 'OTP has been resent successfully!');
      resetOtpFields();
    } else {

      var errorData = jsonDecode(response.body);
      Get.snackbar(
        backgroundColor: AppColors.logoRedColor,
        colorText: Colors.white,
        'Error', errorData['Message'] ?? 'Failed to resend OTP');
    }
  } catch (e) {
    print('Exception occurred: $e');
    Get.snackbar(
      backgroundColor: AppColors.logoRedColor,
      colorText: Colors.white,
      'Error', 'An error occurred while resending OTP');
  }
}

void resetOtpFields() {
  otpControllers.forEach((controller) => controller.clear());
  remainingTime = 30; 
  isTimerExpired = false; 
  startTimer(); 
}

}
