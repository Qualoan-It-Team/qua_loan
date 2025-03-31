import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/controller/loan_application/loan_application_controller.dart';
import 'package:qualoan/controller/loan_application/view_profile_controller.dart';
import 'package:qualoan/model/response_model/loan_application_details_response.dart';
import 'package:qualoan/network/api/api_clients.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoanCalculatorController extends GetxController {
  bool isLoading = false;
  bool isUpdated = false;
  List<String> loanPurposeList = <String>[
    "TRAVEL",
    "MEDICAL",
    "ACADEMICS",
    "OBLIGATIONS",
    "OTHERS",
  ];
  var loanPurposeError;
  String? selectedLoanPurposeType;
  double totalAmount = 5040.00;
  int initialLoanAmount = 5;
  String? loanAmountError;
  String? remarksError;
  String? salaryAmount;
  int initialLoanTenure = 1;
  String? loanTenureError;
  double interestRate = 0.8;
  String? interestRateError;
  double maxLoanAmount = 0.0;
  int value1 = 10;
  TextEditingController loanAmountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController loanTenureController = TextEditingController();
  TextEditingController interestRateController = TextEditingController();
  late ApiClient apiClient;
  LoanApplicationDetailsRespons? loanApplicationResponse;

  @override
  void onInit() {
    super.onInit();
    resetError();
    apiClient = ApiClient();
    loanAmountController.text = (initialLoanAmount * 1000).toString();
    loanTenureController.text = initialLoanTenure.toString();
    interestRateController.text = interestRate.toStringAsFixed(1);
    loanAmountController.addListener(() {
      String input = loanAmountController.text;
      loanAmountError=null;
      if (input.isNotEmpty) {
        int enteredValue = int.tryParse(input) ?? 0;
        if (enteredValue > maxLoanAmount) {
          loanAmountError = "You can fill only up to 40% of your salary.";
        } else if (enteredValue < 5000 || enteredValue > 100000) {
          loanAmountError = AppStrings.loanAmountLimit;
          initialLoanAmount = (enteredValue ~/ 1000).clamp(5, 100);
          update();
        } else {
          loanAmountError = null;
          initialLoanAmount = (enteredValue ~/ 1000).clamp(5, 100);
          update();
        }
      } else {
        loanAmountError = null;
        initialLoanAmount = 5;
        update();
      }
      calculateTotalAmount();
      update();
    });

    loanTenureController.addListener(() {
      String input = loanTenureController.text;
      if (input.isNotEmpty) {
        int enteredValue = int.tryParse(input) ?? 0;
        if (enteredValue < 1 || enteredValue > 90) {
          loanTenureError = AppStrings.loanTenureLimit;
          initialLoanTenure = enteredValue.clamp(1, 90);
          update();
        } else {
          loanTenureError = null;
          initialLoanTenure = enteredValue.clamp(1, 90);
          update();
        }
      } else {
        loanTenureError = null;
        initialLoanTenure = 1;
        update();
      }
      calculateTotalAmount();
      update();
    });

    interestRateController.addListener(() {
      String input = interestRateController.text;
      if (input.isNotEmpty) {
        double enteredValue = double.tryParse(input) ?? 0.0;
        if (enteredValue < 0.8 || enteredValue > 2.75) {
          interestRateError = AppStrings.interestRateLimit;
          interestRate = enteredValue.clamp(0.8, 2.75);
          update();
        } else {
          interestRateError = null;
          interestRate = enteredValue;
          update();
        }
      } else {
        interestRateError = null;
      }
      calculateTotalAmount();
      update();
    });
  }

  void resetError() {
    loanPurposeError = null;
    remarksError = null;
    loanAmountError=null;
    update();
  }

  //validation for loan purpose dropdown
  void validateFields() {
    loanAmountError=null;
    loanPurposeError = null;
    remarksError = null;
    update();
    if (selectedLoanPurposeType == null) {
      loanPurposeError = "Select loan purpose";
    } else if (selectedLoanPurposeType == "OTHERS") {
      if (remarksController.text.isEmpty ||
          remarksController.text.length > 30) {
        remarksError = "Characters should be between 1 to 30";
      } else {
        remarksError = null;
      }
    }
    if (initialLoanAmount * 1000 > maxLoanAmount) {
    loanAmountError = "You can fill only up to 40% of your salary.";
    update();
  }
    update();
  }

  void calculateTotalAmount() {
    int loanAmount = initialLoanAmount * 1000;
    int loanTenureDays = initialLoanTenure * 1;
    double interestRateDecimal = interestRate / 100;
    int timeInYears = loanTenureDays;
    totalAmount = loanAmount + (loanAmount * interestRateDecimal * timeInYears);
    update();
  }

  //token method
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

// apply loan api method
  Future<void> applyForLoan() async {
    isLoading = true;
    update();
    isUpdated = false;
    update();
    String url = EndPoints.localHostApplyLoan;
    String? token = await getToken();
    //40% salary
    // final int principal = (double.tryParse(salaryAmount!) ?? 0.0 * 0.4).round();
    final int principal = initialLoanAmount * 1000;
    final double totalPayable = totalAmount;
    final int tenureMonth = initialLoanTenure;
    final double interestPerMonth = interestRate;

    final Map<String, dynamic> body = {
      'principal': principal,
      'totalPayble': totalPayable,
      'roi': interestPerMonth,
      'tenure': tenureMonth,
      'loanPurpose': selectedLoanPurposeType == "OTHERS"
          ? remarksController.text
          : selectedLoanPurposeType,
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );
      isLoading = false;
      update();
      if (response.statusCode == 200) {
        Get.toNamed(MyAppRoutes.dashboardScreen);
        Get.find<DashboardScreenController>().onItemTapped(1);
        Get.snackbar(
          AppStrings.successText,
          AppStrings.submitLoanAppSuccess,
          backgroundColor: AppColors.black,
          colorText: AppColors.green,
        );
      } else {
        Get.snackbar(
          AppStrings.error,
          '${AppStrings.failedToSubmitLoanApp} ${response.body}',
          backgroundColor: AppColors.logoRedColor,
          colorText: AppColors.white,
        );
      }
    } catch (e) {
      isLoading = false;
      update();
      Get.snackbar(AppStrings.error, '${AppStrings.errorOccured} $e');
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchLoanAmount();
    // validateFields();
    fetchLoanApplicationDetails();
  }

  void fetchLoanApplicationDetails() async {
    await Get.find<LoanApplicationController>().fetchLoanApplicationDetails();
    if (Get.find<LoanApplicationController>().loanApplicationResponse?.data != null) {
      initialLoanAmount = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.loanDetails! .principal! ~/ 1000;
      loanAmountController.text = (initialLoanAmount * 1000).toString();
      initialLoanTenure = Get.find<LoanApplicationController>() .loanApplicationResponse!.data!.loanDetails!.tenure!;
      loanTenureController.text = initialLoanTenure.toString();
      interestRate = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.loanDetails!.roi!;
      interestRateController.text = interestRate.toStringAsFixed(1);
      String apiLoanPurpose = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.loanDetails!.loanPurpose ?? "";
    if (loanPurposeList.contains(apiLoanPurpose)) {
      selectedLoanPurposeType = apiLoanPurpose;
    } else {
      remarksController.text = apiLoanPurpose;
      selectedLoanPurposeType = "OTHERS";
    }
      isUpdated = true;
      update();
      calculateTotalAmount();
    }
    update();
  }

//loan amount autofill from salary 40%
  void fetchLoanAmount() async {
    ViewProfileController profileResponse = Get.put(ViewProfileController());
    await profileResponse.fetchUserProfile();
    salaryAmount = profileResponse.userProfileResponse!.data.incomeDetails!.monthlyIncome.toString();
    double salary = double.tryParse(salaryAmount!) ?? 0.0;
    maxLoanAmount = salary * 0.4;
    // validateFields();
    update();
  }
}
