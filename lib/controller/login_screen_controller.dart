// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginScreenController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  String errorMessage = '';
  bool isPhoneValid = true;
  bool isLoading=false;
  var isTermsAccepted = true;
  var maskFormatter = MaskTextInputFormatter(mask: '(###) ###-####',filter: {"#": RegExp(r'[0-9]')},type: MaskAutoCompletionType.lazy);
      
  LoginScreenController() {
    phoneController.addListener(validatePhoneNumber);
  }

  //open web page
  Future<void> openWebPage(String url) async {
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void validatePhoneNumber() {
    String phoneNumber = phoneController.text;
    errorMessage = '';
    isPhoneValid = true;
    if (phoneNumber.isEmpty) {
      errorMessage = 'Mobile number is required';
      isPhoneValid = false;
    } else if (phoneNumber.length != 10) {
      // Check for exact length
      errorMessage = 'Mobile number must be exactly 10 digits';
      isPhoneValid = false;
    }
    update();
  }

  void toggleTerms() {
    isTermsAccepted = !isTermsAccepted;
    update();
  }

  Future<void> submitForm() async {
    validatePhoneNumber();
    String phoneNumber = phoneController.text.trim();
    if (isPhoneValid) {
      await sendOtp(phoneNumber);
      Get.toNamed(MyAppRoutes.loginOtpScreen, arguments: phoneController.text);
    }
  }

  Future<void> sendOtp(String mobile) async {
    const String url = 'https://api.salary4sure.com/sla-user-verification';
    isLoading = true;
    update();
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
        },
        body: jsonEncode({'mobile': mobile}),
      );
     isLoading=false;
     update();
      if (response.statusCode == 200) {
        // Handle successful response
        var responseData = jsonDecode(response.body);
        Get.snackbar(
            backgroundColor: AppColors.black,
            colorText: AppColors.green,
            "Success",
            "OTP sent successfully");
      } else {
        // Handle error response
        var errorData = jsonDecode(response.body);
        Get.snackbar(
            backgroundColor: AppColors.logoRedColor,
            
            colorText: Colors.white,
            'Error', "OTP failed");
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
