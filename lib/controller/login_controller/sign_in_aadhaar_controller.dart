// ignore_for_file: unused_local_variable, deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/model/response_model/aadhaar_signin_response.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../network/api/api_clients.dart';
import 'aadhaar_signin_otp_controller.dart';

class SignInWithAadhaarController extends GetxController {
  late TextEditingController aadhaarController = TextEditingController();
  String transactionId = AppStrings.emptyString;
  String codeVerifier = AppStrings.emptyString;
  String fwdp = AppStrings.emptyString;
  String responseMessage = AppStrings.emptyString;
  String registerMobileNumer = AppStrings.emptyString;
  bool? isUserAlreadyRegistered;
  var isTermsAccepted = true;
  late ApiClient apiClient;
  String errorMessage = AppStrings.emptyString;
  bool isAadhaarValid = true;
  bool isLoading = false;

  SignInWithAadhaarController() {
    aadhaarController.addListener(validateAadhaarNumber);
  }
  @override
  void onInit() {
    apiClient = ApiClient();
    super.onInit();
  }

  //open webpage method
  Future<void> openWebPage(String url) async {
    if (await launch(url)) {
      await launch(url);
    } else {
      throw '${AppStrings.couldNotLaunch} $url';
    }
  }

  void toggleTerms() {
    isTermsAccepted = !isTermsAccepted;
    update();
  }

  //aadhar validation method
  void validateAadhaarNumber() {
    errorMessage = '';
    String aadhaarNumber = aadhaarController.text;
    isAadhaarValid = true;
    if (aadhaarNumber.isEmpty) {
      errorMessage = AppStrings.aadhaarNumberRequired;
      isAadhaarValid = false;
    } else if (aadhaarNumber.length != 12) {
      errorMessage = AppStrings.aadhaarNumber12DigitText;
      isAadhaarValid = false;
    }
    update();
  }

//method for submit application
  Future<void> submitForm() async {
    validateAadhaarNumber();
    if (isAadhaarValid) {
      await getAadhaarOtpMethod();
    }
  }

  ///get Aadhaar otp method
  Future<void> getAadhaarOtpMethod() async {
    isLoading = true;
    update();
    try {
      var response = await apiClient.getRequest(
          endPoint: '${EndPoints.localAadhaarUrl}${aadhaarController.text}');
      isLoading = false;
      update();
      if (response.statusCode == 200) {
        var aadhaarDataResponse = jsonDecode(response.body);
        var aadhaarResponseModel =
            AadhaarSignResponse.fromJson(aadhaarDataResponse);
        if (aadhaarDataResponse['success']) {
          Get.toNamed(MyAppRoutes.aadhaarSignInOtpScreen);
          isUserAlreadyRegistered = aadhaarResponseModel.isAlreadyRegisterdUser;
          transactionId = aadhaarResponseModel.transactionId ?? '';
          codeVerifier = aadhaarResponseModel.codeVerifier ?? '';
          fwdp = aadhaarResponseModel.fwdp ?? '';
          responseMessage = aadhaarResponseModel.message ?? "";
          registerMobileNumer = aadhaarResponseModel.mobileNumber ?? '';
          Get.put(AadhaarSignInOtpController()).userRegisterValue(
              isUserAlreadyRegistered!, responseMessage.toString().trim());
          Get.put(AadhaarSignInOtpController())
              .setMobileNumber(registerMobileNumer.toString().trim());
          Get.put(AadhaarSignInOtpController())
              .setAadhaarNumber(aadhaarController.text.trim());
          Get.put(AadhaarSignInOtpController()).setAadhaarDetails(
              transactionId.toString().trim(),
              codeVerifier.toString().trim(),
              fwdp.toString().trim());
              showCustomSnackbar(AppStrings.successText, responseMessage,backgroundColor: AppColors.black,textColor: Colors.green);
        } else {
          final errorData = AadhaarSignResponse.fromJson(aadhaarDataResponse);
          String errorMessage = errorData.message ?? AppStrings.errorOccured;
          showCustomSnackbar(AppStrings.error, errorMessage,backgroundColor: AppColors.logoRedColor,textColor: Colors.white);
        }
      } else {
       showCustomSnackbar(AppStrings.error, '${AppStrings.invalidAadhaar} ${response.statusCode}',backgroundColor: AppColors.logoRedColor,textColor: Colors.white);
      }
    } catch (e) {
      isLoading = false;
      update();
      showCustomSnackbar(AppStrings.error, '${AppStrings.errorOccured} $e',backgroundColor: AppColors.logoRedColor,textColor: Colors.white);
    }
  }
}
