// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/registration_form_controller.dart';
import 'package:qualoan/model/response_model/pay_now_response_model.dart';
import 'package:qualoan/model/response_model/show_loan_details.response.dart';
import 'package:qualoan/network/api/api_clients.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../reusable_widgets/custom_snackbar.dart';
import 'package:http/http.dart'as http;

class ShowLoanDetailsController extends GetxController {

  String? dateTimevalue;
  bool isLoading = false;
  bool isLoanApply = false;
  late ApiClient apiClient;
  String?orderId;
  ShowLoanDetailsResponse? showLoanDetailsResponse;
  PayNowRespons? payNowResponse;

  @override
  void onInit() {
    apiClient = ApiClient();
    showLoanDetails();
    super.onInit();
  }
String formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  Future<void> showLoanDetails() async {
    try {
  isLoading=true;
  update();
    // TARUN TOKEN 3
    // const String token= "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YWRjNWU5NmU3Mzk5YzQyZjJkODA1MCIsImlhdCI6MTczOTg2MjMwNiwiZXhwIjoxNzQyNDU0MzA2fQ.zPedqZuvi9A_fFwLUTVTRxlZHyEG2DNPl4w4zpzB1GE";
    //   const String url ='https://preprod-crm.api.qualoan.com/api/user/loanList';
    //   String? token = await getToken();
    //  final response = await http.get(
    //     Uri.parse(url),
    //     headers: {
    //       'Authorization': 'Bearer $token',
    //     },
    //   );
      var response = await apiClient.getRequestWithToken(
          endPoint: EndPoints.localHostLoanList);
      final showLoanStatusResponse = jsonDecode(response.body);
      isLoading = false;
      update();
      print("loan details response===?${response.body}");
      if (response.statusCode == 200) {
        showLoanDetailsResponse =ShowLoanDetailsResponse.fromJson(showLoanStatusResponse);
        update();
        showCustomSnackbar(AppStrings.successText, AppStrings.loanListGetSuccessfully,
            backgroundColor: AppColors.black, textColor: Colors.green);
      } else {
      }
    } catch (e) {
      isLoading = false;
      update();
      showCustomSnackbar(AppStrings.error, '${AppStrings.errorOccured} $e',
          backgroundColor: AppColors.logoRedColor, textColor: Colors.white);
    }
  }

//get token method
Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
//THIS METHOD FOR PAYNOW API
  Future<void> payNowApiMethod( String loanNumber) async {
    try {
    // // const String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YWRjNWU5NmU3Mzk5YzQyZjJkODA1MCIsImlhdCI6MTczOTg2MjMwNiwiZXhwIjoxNzQyNDU0MzA2fQ.zPedqZuvi9A_fFwLUTVTRxlZHyEG2DNPl4w4zpzB1GE';
        const String url ='https://api.qualoan.com/api/user/payNow';
         String? token = await getToken();
     final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: { "loanNo": loanNumber}        
      );
      final payNowResponseDat = jsonDecode(response.body);
      if (response.statusCode == 200) {
        payNowResponse =PayNowRespons.fromJson(payNowResponseDat);
        orderId =payNowResponse!.orderId;
        update();
    // final paymentUrl = 'https://api.paytring.com/pay/token/$orderId';
    final paymentUrl = '${EndPoints.paytringUrl}$orderId';
    if (await launch(paymentUrl)) {
        await launch(paymentUrl);
    } else {
        showCustomSnackbar(AppStrings.error, "${AppStrings.couldNotLaunch} $paymentUrl",
            backgroundColor: AppColors.logoRedColor, textColor: Colors.white);
    }
      } else {
        showCustomSnackbar(AppStrings.error, AppStrings.failedPaymentMode,
            backgroundColor: AppColors.logoRedColor, textColor: Colors.white);
      }
    } catch (e) {
      showCustomSnackbar(AppStrings.error, '${AppStrings.errorOccured} $e',
          backgroundColor: AppColors.logoRedColor, textColor: Colors.white);
    }
  }

  @override
  void onReady() {
    fetchDashboardDetails();
    super.onReady();
  }

  // this api call for isLoan Apply condition
  Future<void> fetchDashboardDetails() async {
    RegistrationFormController registrationController = Get.find<RegistrationFormController>();
        await registrationController.fetchDashboardDetails();
    isLoanApply=registrationController.isLoanApplied;
    update(); 
  }
}

// THIS IS URL https://api.paytring.com/pay/token/732509393630791208