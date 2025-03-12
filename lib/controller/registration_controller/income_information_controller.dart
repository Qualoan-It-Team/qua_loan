import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/controller/loan_application/view_profile_controller.dart';
import 'package:qualoan/view/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeInformationController extends GetxController {
  List<String> accountTypeOptions = <String>[
    AppStrings.salaried,
    AppStrings.selfEmployee
  ];
  String? selectedMode;
  final TextEditingController nextSalaryController = TextEditingController();
  final TextEditingController workingSinceController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();
  final TextEditingController obligationController = TextEditingController();

  String? selectedEmployeeType;
  String? selectedEmployeeTypeError;
  String? selectedModeError;
  String? dobError;
  String? workingSinceError;
  String? salaryError;
  String? obligationError;
  bool isValid = false;
  bool isLoading = false;
  bool isUpdated = false;

  @override
  void onInit() {
    resetErrors();
    update();
    super.onInit();
  }

void resetErrors() {
    dobError = null;
    obligationError = null;
    workingSinceError=null;
    salaryError = null;
    selectedEmployeeTypeError = null;
    selectedModeError = null;
    update(); 
  }
 bool isMonthlyIncomeValid(String income) {
    final double? monthlyIncome = double.tryParse(income);
    return monthlyIncome != null && monthlyIncome >= 35000;
  }
  void validateFields() {
    dobError = null;
    salaryError = null;
    obligationError = null;
    workingSinceError = null;
    selectedEmployeeTypeError=null;
    selectedModeError=null;
    

    if (nextSalaryController.text.isEmpty) {
      dobError = "Next salary date is required";
    }
    if (workingSinceController.text.isEmpty) {
      workingSinceError = "Working since date is required";
    }
   
    
    if (salaryController.text.isEmpty) {
      salaryError = "Salary is required";
    }
    if (obligationController.text.isEmpty) {
      obligationError = "Obligation is required";
    }
     if (selectedEmployeeType == null) {
      selectedEmployeeTypeError = "Employee type is required";
    }
     if (selectedMode == null) {
      selectedModeError = "Income mode is required";
    }
     if (!isMonthlyIncomeValid(salaryController.text)) {
      salaryError = 'Minimum monthly income Rs 35,000.';
    } else {
      salaryError = null;
    }

    isValid = dobError == null && salaryError == null && workingSinceError==null && obligationError == null && selectedEmployeeTypeError==null && selectedModeError==null;

    update();
  }
//method for token
Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  //income details api
  Future<void> submitIncomeDetails() async {
    const url = 'https://api.qualoan.com/api/user/addIncomeDetails';
    String? token = await getToken();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final body = jsonEncode({
    "employementType":selectedEmployeeType,
    "monthlyIncome": double.tryParse(salaryController.text),
    "obligations": double.tryParse(obligationController.text),
    "nextSalaryDate": nextSalaryController.text,
    "workingSince": workingSinceController.text,
    "incomeMode": selectedMode
    });
    try {
      isLoading=true;
      update();
      final response = await http.patch(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
    isLoading=false;
      update();
      if (response.statusCode == 200) {
                Get.snackbar(
          backgroundColor: AppColors.black,
          colorText: AppColors.green,
          AppStrings.successText,
          "Income details submitted successfully");
      Get.to(()=>DashboardScreen());
      Get.find<DashboardScreenController>().onItemTapped(1);
      
      } else {
        Get.snackbar(AppStrings.error, 'Failed to submit income details',backgroundColor: AppColors.logoRedColor,colorText: AppColors.white);
      }
    } catch (e) {
      isLoading=false;
      update();
      Get.snackbar('Error', 'An error occurred: $e',backgroundColor: AppColors.logoRedColor,colorText: AppColors.white);
    }
  }

  ///method for selected date
  Future<void> selectDate(BuildContext context,{DateTime? firstDate,required String purpose,DateTime? lastDate}) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate ?? DateTime.now(),
      // firstDate: DateTime(1900),
      // firstDate: DateTime.now(),
      lastDate:lastDate?? DateTime.now().add( const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      if (purpose == 'nextSalary') {
      nextSalaryController.text = formattedDate;
    } else if (purpose == 'workingSince') {
      workingSinceController.text = formattedDate;
    }
      validateFields();
    }
  }


  //fetch details
   @override
void onReady() {
  super.onReady();
  fetchIncomeInformation();
  update();
}
  void fetchIncomeInformation() async {
  await Get.find<ViewProfileController>().fetchUserProfile();
  if (Get.find<ViewProfileController>().loanApplicationResponse?.data != null) {
    selectedEmployeeType = Get.find<ViewProfileController>().userProfileResponse!.data.incomeDetails!.employementType.toString();
    salaryController.text = Get.find<ViewProfileController>().userProfileResponse!.data.incomeDetails!.monthlyIncome.toString();
    selectedMode = Get.find<ViewProfileController>().userProfileResponse!.data.incomeDetails!.incomeMode.toString();
    obligationController.text = Get.find<ViewProfileController>().userProfileResponse!.data.incomeDetails!.obligations.toString();
    String? workingSinceDate = Get.find<ViewProfileController>().userProfileResponse!.data.incomeDetails!.workingSince.toString();
    if (workingSinceDate != null) {
        DateTime dateTime = DateTime.parse(workingSinceDate);
        workingSinceController.text = DateFormat('yyyy/MM/dd').format(dateTime);
      } else {
        workingSinceController.text = '';
      }
    String nextSalaryDate = Get.find<ViewProfileController>().userProfileResponse!.data.incomeDetails!.nextSalaryDate.toString();
    DateTime parsedDate;
     try {
      parsedDate = DateTime.parse(nextSalaryDate);
    } catch (e) {
      parsedDate = DateTime.now(); 
    }
    nextSalaryController.text = DateFormat('yyyy/MM/dd').format(parsedDate);
    isUpdated = true;
    update();
  }
  update();
}
}
