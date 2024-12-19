import 'dart:convert';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../constants/app_colors.dart';

class EmploymentVerificationController extends GetxController {
  // Define your controllers and error flags
  TextEditingController employerNameController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController officeAddressController = TextEditingController();
  TextEditingController employerPinCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? employerNameError;
  String? designationError;
  String? officeAddressError;
  String? pinCodeError;
  String? emailError;
  String? customerLeadId;
  bool isValid = false; 
  void setCustomerLeadId(String id) {
    customerLeadId = id;
    update(); 
  }

  bool isEmailValid(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

  void validateFields() {
    // Reset errors
    employerNameError = null;
    designationError = null;
    officeAddressError = null;
    pinCodeError = null;
    emailError = null;

    // Validate each field
    if (employerNameController.text.isEmpty) {
      employerNameError = "Employer Name is required.";
    }
    if (designationController.text.isEmpty) {
      designationError = "Designation is required.";
    }
    if (officeAddressController.text.isEmpty) {
      officeAddressError = "Office Address is required.";
    }
    if (!isEmailValid(emailController.text)) {
      emailError = 'Enter a valid email address.';
    } else {
      emailError = null;
    }
    if (employerPinCodeController.text.isEmpty) {
      pinCodeError = "Pin Code is required.";
    } else {
      if (employerPinCodeController.text.length < 6) {
        pinCodeError = "6 digit is required";
      }
    }

    // Check if all fields are valid
    isValid = employerNameError == null &&
        designationError == null &&
        officeAddressError == null &&
        emailError == null &&
        pinCodeError == null;
    update();
  }

  Future<void> submitEmploymentDetails() async {
    const String url ='https://api.salary4sure.com/sla-customer-add-employment';
    final Map<String, dynamic> requestBody = {
      "customer_lead_id": customerLeadId.toString().trim(),
      "employer_name": employerNameController.text.toString().trim(),
      "designation": designationController.text.toString().trim(),
      "office_address": officeAddressController.text.toString().trim(),
      "office_email": emailController.text.toString().trim(),
      "pincode" : employerPinCodeController.text.toString().trim()
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
          
        },
        body: json.encode(requestBody),
      );
      if (response.statusCode == 200) {
        Get.snackbar(
            backgroundColor: AppColors.black,
            colorText: AppColors.green,
            'Success',
            'Employment details submitted successfully.');
        Get.toNamed(MyAppRoutes.bankDetailsVerificationScreen);
      } else {
        Get.snackbar(
            backgroundColor: AppColors.logoRedColor,
            colorText: Colors.white,
            'Error',
            'Failed to submit employment details');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
}
