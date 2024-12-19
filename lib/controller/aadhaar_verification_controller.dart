// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/model/request_model/aadhaar_verification_request.dart';
import 'package:app_here/model/response_model/aadhaar_verification_response.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../network/api/api_clients.dart';
import '../network/end_points.dart';
import 'aadhaar_otp_controller.dart';

class AadhaarVerificationController extends GetxController {
  late TextEditingController aadhaarController = TextEditingController();
 bool isLoading=false;
  String shareCode = "";
  String transactionId = "";
  String codeVerifier = "";
  String fwdp = "";
  // String?aadhaarCode;
  late ApiClient apiClient;

 @override
  void onInit() {
    apiClient = ApiClient();
    super.onInit();
  }

  Future<void> verifyAadhaar() async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'MTE2MzU3MjY6eFh2OTZlNGdoOW9OdHlxbXRLcmw1NFdTalFXOHVjQkQ=',
    };
 isLoading = true;
 update();
    try {
      var data = AadhaarVerificationRequest(uniqueId: "1012", uid: aadhaarController.text).toJson();;
       var response = await apiClient.postRequest(
          endPoint: EndPoints.aadhaarApiUrl, body: data, headers: headers);
          var aadhaarDataResponse = jsonDecode(response.body);
          print("endpoint =====${EndPoints.aadhaarApiUrl}");
isLoading = false;
update();
      if (response.statusCode == 200) {
        var aadhaarResponse = AadhaarVerificationResponse.fromJson(aadhaarDataResponse);
        final aadhaarData= jsonDecode(response.body);
        print(" this is my response ${response.body}");
        final model = aadhaarResponse.model;
        transactionId = model.transactionId ;
        codeVerifier = model.codeVerifier;
        fwdp = model.fwdp;
        Get.put(AadhaarOtpVerificationController()).setAadhaarNumber(aadhaarController.text.trim());
        Get.put(AadhaarOtpVerificationController()).setAadhaarDetails(
          transactionId.toString().trim(),
          codeVerifier.toString().trim(),
          fwdp.toString().trim());
       
        Get.snackbar(
            backgroundColor: AppColors.black,
            colorText: AppColors.green,
            'Success',
            'Otp send Successfully');
            print("aadharargu${aadhaarController.text}");
        Get.toNamed(
          MyAppRoutes.aadhaarOtpVerification,
          // arguments: aadhaarController.text.toString()
          // {
          //   'transactionId': transactionId,
          //   'codeVerifier': codeVerifier,
          //   'fwdp': fwdp,
          //   // 'aadhaarNumber': aadhaarController.text,
          // },
        );
      } else {
        // Handle error response
        final errorData = jsonDecode(response.body);
        Get.snackbar(
            backgroundColor: AppColors.logoRedColor,
            colorText: Colors.white,
            'Error',
            errorData['message'] ?? 'Enter valid Aadhaar number');
      }
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar(
         backgroundColor: AppColors.logoRedColor,
            colorText: Colors.white,
        'Error', 'Failed to verify Aadhaar: $e');
    }
  }
}
