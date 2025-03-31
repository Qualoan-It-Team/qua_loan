import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/controller/loan_application/loan_application_controller.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/reusable_widgets/custom_success_dialog.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../network/end_points.dart';

class BankDetailsController extends GetxController {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController confirmNumberController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  final TextEditingController accountHolderNameController =TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();
  final TextEditingController bankNameController = TextEditingController();
  String? selecteAccountType;
  List<String> accountTypeOptions = <String>['SAVINGS','OVERDRAFT'];
  String? bankNameError;
  String? accountType;
  String? accountNumberError;
  String? confirmAccountNumberError;
  String? accountHolderNameError;
  String? branchNameError;
  String? ifscCodeError;
  var accountTypeError;
  bool isLoading = false;
  bool isValid = false;
  bool isUpdated = false;

  void validateFields() {
    bankNameError = null;
    accountNumberError = null;
    accountHolderNameError = null;
    branchNameError = null;
    ifscCodeError = null;
    accountTypeError = null;
    confirmAccountNumberError = null;

    if (bankNameController.text.isEmpty) {
      bankNameError = "Bank name required";
    } else {
      bankNameError = null;
    }
    if (!isValidAccountNumber(accountNumberController.text)) {
      if (accountNumberController.text.isEmpty) {
        accountNumberError = 'Bank A/C number required';
      } else {
        accountNumberError = "Enter valid account number";
      }
    }
    if (accountHolderNameController.text.isEmpty) {
      accountHolderNameError = "Account holder name required";
    } else {
      accountHolderNameError = null;
    }

    if (branchNameController.text.isEmpty) {
      branchNameError = "Branch name required";
    } else {
      branchNameError = null;
    }
    if (confirmNumberController.text.isEmpty) {
      confirmAccountNumberError = 'Confirm Bank A/C number required';
    } else if (confirmNumberController.text != accountNumberController.text) {
      confirmAccountNumberError = 'Account numbers do not match';
    }
    if (ifscCodeController.text.isEmpty) {
      ifscCodeError = "IFSC code required";
    } else if (ifscCodeController.text.toLowerCase().length <= 10) {
      ifscCodeError = "Ifsc code lenght should be 11";
    } else {
      ifscCodeError = null;
    }
    

    if (selecteAccountType == null) {
      accountTypeError = " Account type required";
    } else {
      accountTypeError = null;
    }
    isValid = accountHolderNameError == null &&
        accountNumberError == null &&
        confirmAccountNumberError == null &&
        branchNameError == null &&
        bankNameError == null &&
        accountTypeError == null;

    update();
  }

  bool isValidAccountNumber(String accountNumber) {
    final RegExp accountNumberRegExp = RegExp(r'^\d{10,20}$');
    return accountNumberRegExp.hasMatch(accountNumber);
  }
//token
Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
//fetch branch and bank name api method
  void fetchBankDetails(String ifscCode) async {
    isLoading = true;
    update();
    try {
      String ifscCode = ifscCodeController.text;
      final response =
          await http.get(Uri.parse('https://ifsc.razorpay.com/$ifscCode'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data.isNotEmpty) {
          bankNameController.text = data['BANK'];
          branchNameController.text = data['BRANCH'];
          branchNameError=null;
          bankNameError=null;
          update();
        } else {
          Get.snackbar(
            'Error',
            'Invalid IFSC code. Please check and try again.',
            backgroundColor: AppColors.logoRedColor,
            colorText: Colors.white,
          );
        }
      } 
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while fetching bank details: $e',
        backgroundColor: AppColors.logoRedColor,
        colorText: Colors.white,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> submitBankDetails() async {
     if (bankNameController.text.isEmpty || branchNameController.text.isEmpty) {
    Get.snackbar(
      'Error',
      'Please fetch valid bank details before submitting.',
      backgroundColor: AppColors.logoRedColor,
      colorText: Colors.white,
    );
    return;
  }

    String url = EndPoints.localHostDisbursalBankDetails;
    String? token = await getToken();

    final Map<String, dynamic> requestBody = {
      "bankName": bankNameController.text.trim(),
      "branchName": branchNameController.text.trim(),
      "accountNumber": accountNumberController.text.trim(),
      "confirmAccountNumber": accountNumberController.text.trim(),
      "ifscCode": ifscCodeController.text.trim(),
      "accountType": selecteAccountType,
      "beneficiaryName": accountHolderNameController.text,
    };
    isLoading = true;
    update();
    try {

      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );
      isLoading = false;
    update();
      if (response.statusCode == 200) {
         Future.delayed(Duration.zero, () {
      CustomSuccessDialog.showDialog(
        title: 'Thank You',
        icon: Icons.check,
        iconColor: AppColors.green,
        titleColor: Colors.green,
        buttonText: 'OK',
        content: "Your Loan Application has been submitted Successfully",
        contentColor: AppColors.black,
        onButtonPressed: () {
          Get.back(); 
        },
      );
    });
        Get.toNamed(MyAppRoutes.dashboardScreen);
      Get.find<DashboardScreenController>().onItemTapped(2);
        showCustomSnackbar(AppStrings.successText, "Bank details submitted successfully",backgroundColor: AppColors.black,textColor: AppColors.green);
      } else {
        Get.snackbar(
          AppStrings.error,
          'Failed to submit bank details: ${response.body}',
          backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading = false;
    update();
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: AppColors.logoRedColor,
        colorText: Colors.white,
      );
    }
  }

  //fetch the data 
  @override
void onReady() {
  super.onReady();
  fetchLoanApplicationDetails();
}
  void fetchLoanApplicationDetails() async {
  await Get.find<LoanApplicationController>().fetchLoanApplicationDetails();
  if (Get.find<LoanApplicationController>().loanApplicationResponse?.data != null) {
    accountHolderNameController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.disbursalBankDetails!.beneficiaryName.toString();
    accountNumberController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.disbursalBankDetails!.accountNumber.toString();
    ifscCodeController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.disbursalBankDetails!.ifscCode.toString();
    bankNameController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.disbursalBankDetails!.bankName.toString();
    branchNameController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.disbursalBankDetails!.branchName.toString();
    selecteAccountType = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.disbursalBankDetails!.accountType;
    isUpdated = true;
    update();
  }
  update();
}
}
