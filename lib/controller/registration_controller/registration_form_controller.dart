// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/model/response_model/get_user_details_response.dart';
import 'package:qualoan/network/api/api_clients.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationFormController extends GetxController {
  final TextEditingController panController = TextEditingController();
  bool isLoading = false;
  String errorMessage = AppStrings.emptyString;
  var panError;
  String? message;
  String? applicationStatus;
  bool isRegistration = false; 
  bool isLoanApplied = false; 
  // String? registrationStatus ; 
  bool isAadharVerify = false; 
  bool isMobileVerify = false; 
  bool isPanVerify = false; 
  bool isPersonalDetails = false; 
  bool isIncomDetails = false; 
  bool isCurrentResidence = false; 
  bool isProfileImage = false; 
  bool isFormFilled = false; 
  //new values
  bool isLoanCalculated =false;
  bool isEmployInformation =false;
  bool isUploadBankStatements =false;
  bool isShowDocuments =false;
  bool isBankDetails =false;
  GetProfileDetailsResponse?userProfileResponse;
 late ApiClient apiClient;
 


@override
  void onInit() {
    apiClient=ApiClient();
    super.onInit();
  }
  // PAN VALIDATION METHOD
  bool isPanValid(String pan) {
    final RegExp panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    return panRegExp.hasMatch(pan);
  }
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}
  ///validate method
  void validateInputs() {
    // Validate PAN
    if (!isPanValid(panController.text)) {
      panError = AppStrings.validPan;
    } else {
      panError = null;
    }
    update();
  }

//Pan Verify apiMethod
  Future<void> verifyPan() async {
    final String url ='${EndPoints.localHostVerifyPan}${panController.text}';
        // 'https://api.qualoan.com/api/user/verifyPAN/${panController.text}';
        String? token = await getToken();
    isLoading = true;
    update();

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      isLoading = false;
      update();
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        Get.back();
        Get.snackbar(
            backgroundColor: AppColors.black,
            colorText: AppColors.green,
            AppStrings.successText,
            AppStrings.panVerifiedSuccessfully);
            isPanVerify = true;
      } else {
        var errorData = jsonDecode(response.body);
        errorMessage = errorData['message'] ?? AppStrings.failToVerifyPan;
         Get.snackbar(
            backgroundColor: AppColors.logoRedColor,
            colorText: AppColors.white,
            AppStrings.error,
            errorMessage);
      }
    } catch (e) {
      errorMessage = '${AppStrings.errorOccured} $e';
    } finally {
      isLoading = false;
      update();
    }
  }

  //this method for enable disable condition 
  Future<void> fetchDashboardDetails() async {
  String url = EndPoints.localHostGetDashboardDetails;
  String? token = await getToken();
  isLoading = true;
  update();
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    isLoading = false;
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      message = responseData['message'];
      isRegistration = responseData['isRegistering'] is bool ? responseData['isRegistering'] : false;
      isLoanApplied = responseData['isLoanApplied'] is bool ? responseData['isLoanApplied'] : false;
      isPanVerify = responseData['isPanVerify'] is bool ? responseData['isPanVerify'] : false;
      isMobileVerify = responseData['isMobileVerify'] is bool ? responseData['isMobileVerify'] : false;
      isPersonalDetails = responseData['isPersonalDetails'] is bool ? responseData['isPersonalDetails'] : false;
      isIncomDetails = responseData['isIncomeDetails'] is bool ? responseData['isIncomeDetails'] : false;
      isCurrentResidence = responseData['isCurrentResidence'] is bool ? responseData['isCurrentResidence'] : false;
      isProfileImage = responseData['isProfileImage'] is bool ? responseData['isProfileImage'] : false;
      isFormFilled = responseData['isFormFilled'] is bool ? responseData['isFormFilled'] : false;
      isLoanCalculated = responseData['isLoanCalculated'] is bool ? responseData['isLoanCalculated'] : false;
      isEmployInformation = responseData['isEmploymentDetailsSaved'] is bool ? responseData['isEmploymentDetailsSaved'] : false;
      isUploadBankStatements = responseData['isBankStatementUploaded'] is bool ? responseData['isBankStatementUploaded'] : false;
      isShowDocuments = responseData['isDocumentUploaded'] is bool ? responseData['isDocumentUploaded'] : false;
      isBankDetails = responseData['isDisbursalDetailsSaved'] is bool ? responseData['isDisbursalDetailsSaved'] : false;
      applicationStatus = responseData['applicationStatus'] ;

      update();
    } else {
      errorMessage = 'Failed to fetch dashboard details';
       Get.snackbar(
            backgroundColor: AppColors.logoRedColor,
            colorText: AppColors.white,
            AppStrings.error,
            errorMessage);
    }
  } catch (e) {
    errorMessage = '${AppStrings.errorOccured} $e';
     Get.snackbar(
            backgroundColor: AppColors.logoRedColor,
            colorText: AppColors.white,
            AppStrings.error,
            errorMessage);
  } finally {
    isLoading = false;
    update();
  }
}

@override
  void onReady() {
    fetchUserProfile();
    update();
    super.onReady();
  }

//get profile details
Future<void> fetchUserProfile() async {
    try {
       var response = await apiClient.getRequestWithToken(endPoint: EndPoints.localHostGetProfileDetails);
      if (response.statusCode == 200) {
        final Map<String, dynamic> userResponse = json.decode(response.body);
        userProfileResponse = GetProfileDetailsResponse.fromJson(userResponse);
        panController.text=userProfileResponse!.data.pan.toString();
        update();
      } 
    } catch (e) {
      showCustomSnackbar("Exception ", "$e" , backgroundColor: AppColors.logoRedColor,textColor: AppColors.white);
    }
  }
}