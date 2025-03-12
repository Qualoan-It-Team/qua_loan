// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/controller/login_controller/sign_in_aadhaar_controller.dart';
import 'package:qualoan/model/request_model/aadhaar_signin_otp_request.dart';
import 'package:qualoan/model/request_model/mobile_otp_request.dart';
import 'package:qualoan/model/response_model/aadhaar_signin_otp_response.dart';
import 'package:qualoan/model/response_model/mobile_otp_response.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:qualoan/utils/shared_pref.dart';
import 'package:qualoan/view/dashboard/dashboard_screen.dart';
import '../../constants/app_colors.dart';
import '../../network/api/api_clients.dart';

class AadhaarSignInOtpController extends GetxController {
  final SharedPrefs sharedPreferencesService = SharedPrefs();
  List<TextEditingController> aadhaarOtpControllersList = List.generate(6, (index) => TextEditingController());
  late SignInWithAadhaarController aadhaarCodeController;
  Timer? timer;
  bool? isRegister;
   bool isTimerExpired = false;
  bool isLoading = false;
  late ApiClient apiClient;
  String fwdpId = AppStrings.emptyString;
  String transactionId = AppStrings.emptyString;
  String codeVerifierId = AppStrings.emptyString;
  String reponseMessage = AppStrings.emptyString;
  String aadhaarNumber = AppStrings.emptyString;
  var otp = AppStrings.emptyString;
  int remainingTime = 60;
  String mobileNumber = AppStrings.emptyString;

  @override
  void onInit() {
    super.onInit();
    apiClient = ApiClient();
    aadhaarCodeController = Get.put(SignInWithAadhaarController());
    aadhaarNumber = aadhaarCodeController.aadhaarController.text.toString();
    update();
    startTimer();
  }

///otp extract from the list 
String getOtpFromControllers() {
  String otp = '';
  for (var controller in aadhaarOtpControllersList) {
    otp += controller.text;
  }
  return otp;
}
///clear otp
 void clearOtpFields() {
    for (var controller in aadhaarOtpControllersList) {
      controller.clear();
    }
  }

  //timer method
void startTimer() {
  isTimerExpired = false;
    remainingTime = 60; 
    update();
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

  //this method for get register user value
  void userRegisterValue(bool isRegisterOrNot,String message) {
    isRegister = isRegisterOrNot;
    reponseMessage=message;
  }

//this method for get aadhaar number
  void setAadhaarNumber(String number) {
    aadhaarNumber = number;
  }
  void setMobileNumber(String mobNumber) {
    mobileNumber = mobNumber;
  }
 
//this method for get aadhaar details
  void setAadhaarDetails(String verifier, transaction, fwdp,) {
    codeVerifierId = verifier;
    transactionId = transaction;
    fwdpId = fwdp;
    update();
  }

// this method for submit aadhaar otp
  Future<void> verifyAadhaarOtp() async {
    isLoading = true;
    update();
    try {
      var data = AadhaarSignInOtpRequest(
        otp: getOtpFromControllers(),
        transactionId: codeVerifierId.toString().trim(),
        codeVerifier: transactionId.toString().trim(),
        fwdp: fwdpId.toString().trim(),
        ).toJson();
      var response = await apiClient.postRequestWithoutToken(
          endPoint: EndPoints.localHostAadhaarOtp,
          body: data);
      isLoading = false;
      update();
     var aadhaarDataResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var aadhaarOtpResponse =   AadhaarSignOtpResponse.fromJson(aadhaarDataResponse);
         showCustomSnackbar(AppStrings.successText,AppStrings.otpVerifySuccessfully,backgroundColor:AppColors.black,textColor: AppColors.green );
        Get.toNamed(MyAppRoutes.dashboardScreen);
        String token = aadhaarOtpResponse.token.toString(); 
        print("Token=========>$token");
      await sharedPreferencesService.saveToken(token);
      } else {
        final errorData = jsonDecode(response.body);
      showCustomSnackbar(AppStrings.error,errorData['message'] ?? AppStrings.failToVerifytOtp,backgroundColor:AppColors.logoRedColor,textColor: AppColors.white );
      }
    } catch (e) {
      isLoading = false;
      update();
      // print("error............$e");
      showCustomSnackbar(AppStrings.error,'${AppStrings.failedToSubmitOtp} $e',backgroundColor:AppColors.logoRedColor,textColor: AppColors.white );
    }
  }

//this method for verify otp 
    Future<void> verifyMobileOtp() async {
    try {
      isLoading = true;
      update();
      var data = MobileOtpRequest(mobile: mobileNumber, otp: getOtpFromControllers(),isAlreadyRegisterdUser:true).toJson();
      final response = await apiClient.postRequestWithoutToken(endPoint: EndPoints.localHostMobileOtp,body: data,);
    isLoading = false;
    update();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var mobileOtpResponse = MobileOtpResponse.fromJson(responseData);
        String? token = mobileOtpResponse.token; 
        await sharedPreferencesService.saveToken(token!);
       print("Toke''''''''''$token");
        clearOtpFields();
        Get.snackbar(
          backgroundColor: AppColors.black,
          colorText: AppColors.green,
          AppStrings.successText, AppStrings.otpVerifySuccessfully);
          Get.to(DashboardScreen());
      Get.find<DashboardScreenController>().onItemTapped(0);
      } else {
        var errorData = jsonDecode(response.body);
        showCustomSnackbar(AppStrings.error, errorData['message'] ?? AppStrings.failToVerifytOtp,backgroundColor:AppColors.logoRedColor,textColor: AppColors.white);
      
      }
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  //this method for resend otp
 Future<void> reSendOtp() async {
    SignInWithAadhaarController resendOtpController = Get.find<SignInWithAadhaarController>();
        await resendOtpController.getAadhaarOtpMethod();
        startTimer();
        update(); 
    
    }
    

  //reset otp fields 
  void resetOtpFields() {
  remainingTime = 30; 
  isTimerExpired = false; 
  startTimer(); 
}
@override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
