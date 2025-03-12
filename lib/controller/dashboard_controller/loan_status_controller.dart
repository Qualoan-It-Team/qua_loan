import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/registration_form_controller.dart';
import 'package:qualoan/model/response_model/loan_status_response.dart';
import 'package:qualoan/network/api/api_clients.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';

class LoanStatusController extends GetxController{

bool isLoading=false;
late ApiClient apiClient;
String? applicationUnderProcess;
String? applicationSenction;
String? applicationDisbursed;
bool?  isLoanApply;
LoanStatusResponse? loanStatusResponse;
 

  @override
  void onInit() {
    apiClient = ApiClient();
    super.onInit();
  }

@override
  void onReady() {
  getLoanStatus();
   apiClient = ApiClient();
   
    super.onReady();
  }



//loan status details method
Future<void> getLoanStatus() async {
    isLoading = true;
    update();
    try {
    var response = await apiClient.getRequestWithToken( endPoint: EndPoints.localHostGetJourney);
    final getJourneyResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        loanStatusResponse = LoanStatusResponse.fromJson(getJourneyResponse);
        applicationUnderProcess =   loanStatusResponse!.journey.loanUnderProcess;
        applicationSenction =   loanStatusResponse!.journey.sanction;
        applicationDisbursed =   loanStatusResponse!.journey.disbursed;
         showCustomSnackbar(AppStrings.successText, AppStrings.loanStatusFetchedSuccessfully,backgroundColor: AppColors.black,textColor: Colors.green);
        } else {
        }
    } catch (e) {
      isLoading = false;
      update();
      showCustomSnackbar(AppStrings.error, '${AppStrings.errorOccured} $e',backgroundColor: AppColors.logoRedColor,textColor: Colors.white);
    }
  }

  ///dashboard details api
   Future<void> fetchDashboardDetails() async {
    RegistrationFormController registrationController = Get.find<RegistrationFormController>();
        await registrationController.fetchDashboardDetails();
    isLoanApply=registrationController.isLoanApplied;
    //
    update(); 
  }
}
  