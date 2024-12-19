// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:app_here/controller/aadhaar_verification_controller.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../network/api/api_clients.dart';


class AadhaarOtpVerificationController extends GetxController {
  final TextEditingController aadhaarOtpController = TextEditingController();
  bool passwordVisible = false;
  // String shareCode = "";
  String transactionId = "";
  String codeVerifierId = "";
  String fwdpId = "";
  bool isLoading = false;
  late ApiClient apiClient;
  String aadhaarNumber = '';
  String? customerLeadId;
  late AadhaarVerificationController aadhaarCodeController;
  @override
  void onInit() {
    super.onInit();
    print("On init call");
    apiClient = ApiClient();
    aadhaarCodeController = Get.put(AadhaarVerificationController());
    aadhaarNumber = aadhaarCodeController.aadhaarController.text.toString();
    // aadhaarNumber=Get.arguments;
    // transactionId = Get.arguments;
    // final arguments = Get.arguments;

    // if (arguments is Map<String, dynamic>) {
    //   transactionId = arguments['transactionId'] ?? "";
    //   codeVerifierId = arguments['codeVerifier'] ?? "";
    //   fwdpId = arguments['fwdp'] ?? "";
    //   // String aadhaarNumber = arguments['aadhaarNumber'] ?? "";
    //   // print("Aadhaar Number: $aadhaarNumber");
    //   print("Lead id: $customerLeadId");
    //   print("code verifier$codeVerifierId");
    //   print("fwdp$fwdpId");
    // } else {
    //   print("No arguments received");
    // }
    passwordVisible = true;
    update();
  }

  void setCustomerLeadId(String id) {
    customerLeadId = id;
    update(); // Notify listeners about the change
  }

  void setAadhaarNumber(String number) {
    aadhaarNumber = number;
  }

  void setAadhaarDetails(String verifier, transaction, fwdp) {
    // aadhaarNumber= aNumber;
    codeVerifierId = verifier;
    transactionId = transaction;
    fwdpId = fwdp;

    update(); // Notify listeners about the change
  }

  Future<void> submitOtp() async {
    const String url = "https://svc.digitap.ai/ent/v3/kyc/submit-otp";
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization':
          'MTE2MzU3MjY6eFh2OTZlNGdoOW9OdHlxbXRLcmw1NFdTalFXOHVjQkQ=',
    };
    // String aadharOtp = aadhaarOtpController.text.trim();
    isLoading = true;
    update();
    try {
      print("Transaction ID 000: $codeVerifierId");
      print("Code Verifier ID: $transactionId");
      print("FWDP ppp: $fwdpId");
      print("Aadhaar number:$aadhaarNumber");
      print("Lead Id$customerLeadId");
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({
          "shareCode": "1234",
          "otp":
          // "182343",
           aadhaarOtpController.text.toString().trim(),
          "transactionId": codeVerifierId.toString().trim(),
          // "AZFu2ZHpqlNNpjEXAqKDfpXO3EfxQFX2jg4FH7JLcaPk131iT3jzWWDQzakEg3tI4BMRY3lM4i0OfkCwY7M0G9tqEU11I02WpcJvgS18HzYUyzHPbqg4SLL8B4HXGbzO",
          
          "codeVerifier": transactionId.toString().trim(),
          // "984001725396706845",
         
          "fwdp":
          //  "KAz28t0ZfzQaroPu9d1juYCvYoTz7ukQMI6whJav3HW_pQmimdr1zJ8X0Zz94-K1hM2NhD64KRXkLHVvrfR2gHVOkVPP7j__ruwsCjI9wBmXn6fb9AcXYE-zcIh5p_GXLxt9RPHFGJhnlboJ6UNym-hWRuVOAUWZI_h74sySjDu76R5NVSA32LywGEeR2dfO9SyHrGMwaApLkQtX7HyGJi8K_AcUxJa3p7mE-Lz32Yk7LZVo3jK6TUvUWG1KOvbhO76V23k7w7xjA8YTkXOhA4l68pNCAlDpWEmsOTYVMkPGyTD5nxVtwm-O1oo_lVzpwXCWUodpJMxRLr1JeLnXqsx5BVqZdXzIrFg-drgFW9OVyiff69QXntsZb81ohB4lxFbOvjGWUjgjnUpJFEmthvQ0FQGOGk5msWrI6xAjtGYyxIwNjMcxuidwZDIPuMqSYCYonKdObE5TZsdvb7WgwOLFF7FQOqA",
          fwdpId.toString().trim(),
          "validateXml": true
        }),
      );

      // var data =
      //  AadhaarSubmitOtpRequest(
      //         shareCode: "1234",
      //         otp: otp,
      //         transactionId: transactionId,
      //         codeVerifier: codeVerifierId,
      //         fwdp: fwdpId,
      //         validateXml: true)
      //     .toJson();
      // var response = await apiClient.postRequest(
      //     endPoint: EndPoints.aadhaarSubmitOtpUrl,
      //     body: data,
      //     headers: headers);
      var aadhaarDataResponse = jsonDecode(response.body);
      print("endpoint =====$url");
      print("Status code${response.statusCode}");
      print("Addhaar otp ${aadhaarOtpController.text.toString().trim()}");
      isLoading = false;
      update();
      if (response.statusCode == 200) {
        print("Response==========${response.body}");
        Get.snackbar(
            backgroundColor: AppColors.black,
            colorText: AppColors.green,
            'Success',
            'OTP verified successfully!');
        await updateAadhaarStatus();
        // Get.toNamed(MyAppRoutes.loanConfirmation);
        Get.toNamed(MyAppRoutes.employmentVerificationScreen);
        // Navigate to the next screen or perform any other actions
      } else {
        // Handle error response
        final errorData = jsonDecode(response.body);
        Get.snackbar(
            backgroundColor: AppColors.logoRedColor,
            colorText: Colors.white,
            'Error',
            errorData['message'] ?? 'Failed to verify OTP ');
      }
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar(
          backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
          'Error',
          'Failed to submit OTP: $e');
    }
  }

  Future<void> updateAadhaarStatus() async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
      'auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
    };

    var data = {
      // "customer_lead_id": "1", // Replace with actual customer lead ID
      "customer_lead_id":
          customerLeadId.toString(), // Replace with actual customer lead ID
      "aadhaar_no":
          aadhaarNumber.toString(), // Replace with actual Aadhaar number
      "aadhaar_status": 1
    };

    try {
      var response = await http.post(
        Uri.parse('https://api.salary4sure.com/sla-customer-update-aadhaar'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print("Aadhaar status updated successfully: ${response.body}");
        Get.snackbar(
            backgroundColor: AppColors.black,
            colorText: AppColors.green,
            'Success',
            'Aadhaar status updated successfully!');
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
            backgroundColor: AppColors.logoRedColor,
            colorText: Colors.white,
            'Error',
            errorData['message'] ?? 'Failed to update Aadhaar status');
      }
    } catch (e) {
      Get.snackbar(
          backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
          'Error',
          'Failed to update Aadhaar status: $e');
    }
  }
}
