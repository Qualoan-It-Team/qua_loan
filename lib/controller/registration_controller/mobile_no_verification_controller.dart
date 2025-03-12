// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/mobile_otp_controller.dart';
import 'package:qualoan/network/api/api_clients.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/routes/app_routes.dart';

class MobileNumberVerificationController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController panController = TextEditingController();
  String errorMessage = AppStrings.emptyString;
  bool isPhoneValid = true;
  bool isLoading = false;
  var isTermsAccepted = true;
  var fathersNameError;
  var panError;
  String mobileNumber = AppStrings.emptyString;
  late  ApiClient apiClient;
  MobileNumberVerificationController() {
    phoneController.addListener(validatePhoneNumber);
  }

 @override
  void onInit() {
    apiClient = ApiClient();
    super.onInit();
  }
  void validatePhoneNumber() {
    errorMessage = '';
    isPhoneValid = true;
    if (phoneController.text.isEmpty) {
      errorMessage = AppStrings.mobileNumberRequired;
      isPhoneValid = false;
    } else if (phoneController.text.length != 10) {
      errorMessage = AppStrings.mobileNumber10DigitText;
      isPhoneValid = false;
    }
    update();
  }

   bool isPanValid(String pan) {
    final RegExp panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    return panRegExp.hasMatch(pan);
  }
void validateInputs() {
    fathersNameError=null;
    panError=null;
    if (fathersNameController.text.isEmpty) {
      fathersNameError = AppStrings.fathersNameRequired;
    } else {
      fathersNameError = null;
    }
    if (!isPanValid(panController.text)) {
      panError = AppStrings.validPan;
    } else {
      panError = null;
    }
    update();
  }



  Future<void> submitForm() async {
    validatePhoneNumber();
    validateInputs();
    if (isPhoneValid) {
      mobileNumber = phoneController.text.trim();
      await sendMobileOtp(mobileNumber);
      
    }
  }

//this method for send otp on mobile
  Future<void> sendMobileOtp(String mobile) async {
    isLoading = true;
    update();
    try {
      var requestBody = jsonEncode({
      "pan": panController.text.trim(),
      "fathersName": fathersNameController.text.trim(),
    });
       final response = await apiClient .postRequestWithToken( endPoint: '${EndPoints.localHostGetMobileOtpUrl}$mobile',
       body:  {
      "PAN": panController.text.trim(),
      "fathersName": fathersNameController.text.trim(),
    }
    );
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        Get.put(MobileOtpController()).setMobileNumber(mobileNumber);
        showCustomSnackbar(AppStrings.successText, AppStrings.otpSentSuccessfully,backgroundColor: AppColors.black,textColor: AppColors.green);
        Get.toNamed(MyAppRoutes.mobileOtpVerification);
      } else {
        var errorData = jsonDecode(response.body);
        showCustomSnackbar(AppStrings.error, errorData['message'] ?? AppStrings.otpFailed,backgroundColor: AppColors.logoRedColor,textColor: AppColors.white);
      }
    } catch (e) {
      showCustomSnackbar(AppStrings.error, '${AppStrings.errorOccured} $e',backgroundColor: AppColors.logoRedColor,textColor: AppColors.white);
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
