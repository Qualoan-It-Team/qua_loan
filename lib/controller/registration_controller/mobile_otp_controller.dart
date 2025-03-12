// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/controller/registration_controller/mobile_no_verification_controller.dart';
import 'package:qualoan/model/request_model/mobile_otp_request.dart';
import 'package:qualoan/model/response_model/mobile_otp_response.dart';
import 'package:qualoan/network/api/api_clients.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/routes/app_routes.dart';
import '../../constants/app_colors.dart';

class MobileOtpController extends GetxController {
  List<TextEditingController> mobileOtpControllersList = List.generate(6, (index) => TextEditingController());
  Timer? timer;
  bool isLoading = false;
  var otp = AppStrings.emptyString;
   int remainingTime = 60;
  bool isTimerExpired = false;
  String mobileNumber = AppStrings.emptyString;
  late ApiClient apiClient;

  @override
  void onInit() {
    super.onInit();
    apiClient=ApiClient();
    startTimer();
  }

///otp extract from the list 
String getOtpFromControllers() {
  String otp = '';
  for (var controller in mobileOtpControllersList) {
    otp += controller.text;
  }
  return otp;
}

///clear otp
 void clearOtpFields() {
    for (var controller in mobileOtpControllersList) {
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

//this method for get mobile number
  void setMobileNumber(String mobNumber) {
    mobileNumber = mobNumber;
  }

//this method for verify mobile otp
 Future<void> verifyMobileOtp() async {
    try {
      isLoading = true;
      update();
      var data = MobileOtpRequest(mobile: mobileNumber, otp: getOtpFromControllers(),isAlreadyRegisterdUser:false).toJson();
      final response = await apiClient.postRequestWithoutToken(endPoint: EndPoints.localHostMobileOtp,body: data,);
    isLoading = false;
    update();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var mobileOtpResponse = MobileOtpResponse.fromJson(responseData);
        clearOtpFields();
        Get.snackbar(
          backgroundColor: AppColors.black,
          colorText: AppColors.green,
          AppStrings.successText, AppStrings.otpVerifySuccessfully);
         Get.toNamed(MyAppRoutes.dashboardScreen);
      Get.find<DashboardScreenController>().onItemTapped(1);
      } else {
        var errorData = jsonDecode(response.body);
        showCustomSnackbar(AppStrings.error, errorData['message'] ?? AppStrings.failToVerifytOtp,backgroundColor:AppColors.logoRedColor,textColor: AppColors.white);
      
      }
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  // send otp method 
  Future<void> reSendMobileOtp() async {
    MobileNumberVerificationController mobileOtpController = Get.find<MobileNumberVerificationController>();
        await mobileOtpController.sendMobileOtp(mobileNumber);
        resetOtpFields();
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
