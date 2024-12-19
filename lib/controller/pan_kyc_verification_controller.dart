// ignore_for_file: prefer_typing_uninitialized_variables, collection_methods_unrelated_type

import 'dart:convert';
import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/model/request_model/pan_verification_request.dart';
import 'package:app_here/model/response_model/pan_verification_response.dart';
import 'package:app_here/network/api/api_clients.dart';
import 'package:app_here/network/end_points.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'pincode_screen_controller.dart';

class PanKycVerificationController extends GetxController {
  List<String> genderOptions = <String>['FEMALE', 'MALE'];
  final TextEditingController panController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController aadharNoController = TextEditingController();
  final TextEditingController monthlyIncomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController loanAmountController = TextEditingController();
  var otp = '';
  String? selectedGender;
  bool isLoading = false;
  var panError;
  var emailError;
  var incomeError;
  var loanError;
  var firstNameError;
  var genderError;
  var dobError;
  bool isVerified = false;
  String? customerLeadId;
  late PinCodeController pinCodeController;
  String?pinCode;
  late ApiClient apiClient;

  void setCustomerLeadId(String id) {
    customerLeadId = id;
    update(); 
  }
 
  @override
  void onInit() {
    apiClient = ApiClient();
    pinCodeController = Get.put(PinCodeController());
    pinCode = pinCodeController.pincode;
    super.onInit();
  }


// Whatsap integration method
  whatsApp() async {
    const phoneNumber = '918800858959';
    const message = 'We want to get more details about the Loan';
    final url =
        'https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (Theme.of(Get.context!).platform == TargetPlatform.android) {
        const playStoreUrl =
            'https://play.google.com/store/apps/details?id=com.whatsapp';
        await launch(playStoreUrl);
      } else if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
        const appStoreUrl =
            'https://apps.apple.com/app/whatsapp-messenger/id310633997';
        await launch(appStoreUrl);
      } else {
        Get.snackbar('Error',
            'WhatsApp is not installed and cannot be redirected for installation.');
      }
    }
  }

  // PAN VALIDATION METHOD
  bool isPanValid(String pan) {
    // PAN card must be 10 characters and follow the format
    final RegExp panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    return panRegExp.hasMatch(pan);
  }

//EMAIL VALIDATION METHOD
  bool isEmailValid(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }

//MONTHLY INCOME VALIDATION
  bool isMonthlyIncomeValid(String income) {
    final double? monthlyIncome = double.tryParse(income);
    return monthlyIncome != null && monthlyIncome >= 35000;
  }

//LOAN VALIDATION
  bool isLoanValid(String loanAmount) {
    final double? loan = double.tryParse(loanAmount);
    return loan != null && loan >= 5000 && loan <= 100000;
  }

  /// here i create this method for validate all fields
  void validateInputs() {
    // Validate PAN
    if (!isPanValid(panController.text)) {
      panError = 'Enter a valid PAN card number.';
    } else {
      panError = null; 
    }
    //first name
    if (firstNameController.text.isEmpty) {
    firstNameError = 'First Name required.';
  } else {
    firstNameError = null; 
  }

//gender 
  if (selectedGender == null || selectedGender!.isEmpty) {
    genderError = 'Gender must be selected.';
  } else {
    genderError = null; 
  }

  if (dobController.text.isEmpty) {
    dobError = 'Date of Birth required.';
  } else {
    dobError = null;
  }
    // Validate Email
    if (!isEmailValid(emailController.text)) {
      emailError = 'Enter a valid email address.';
    } else {
      emailError = null;
    }
    // Validate valid loan
    if (!isLoanValid(loanAmountController.text)) {
      loanError = 'Minimum Rs 5,000 & Maximum Rs 1,00,000.';
    } else {
      loanError = null;
    }
    // Validate Monthly Income
    if (!isMonthlyIncomeValid(monthlyIncomeController.text)) {
      incomeError = 'Minimum monthly income Rs 35,000.';
    } else {
      incomeError = null;
    }
    update();
  }

// date picker method
  Future<void> selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (selectedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
      dobController.text = formattedDate;
      update();
    }
  }

  ///Pan verify API
  Future<void> fetchPanDetails() async {
    const String username = '11635726';
    const String password = 'xXv96e4gh9oNtyqmtKrl54WSjQW8ucBD';
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': basicAuth,
    };
    print("pincode pan ==>$pinCode");
    isLoading = true;
    update();
    try {
      var data =
          PanVerificationRequest(clientRefNum: "1234", pan: panController.text)
              .toJson();
      var response = await apiClient.postRequest(
          endPoint: EndPoints.panApiUrl, body: data, headers: headers);
      var panDataResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var panResponse = PanVerificationResponse.fromJson(panDataResponse);
        print('Response Body: ${response.body}');
        if (panResponse.resultCode == 101) {
          var result = panResponse.result;
          List<String> errorMessages = [];
          if (result.pan.trim() != panController.text.trim()) {
            errorMessages.add("PAN does not match.");
          }
         if (result.fullname.trim().toUpperCase() == firstNameController.text.trim().toUpperCase() ||
            result.firstName.trim().toUpperCase() == firstNameController.text.trim().toUpperCase()) {
          showVerificationSuccessDialog(); 
          isVerified = true; 
        } else {
          errorMessages.add("First name does not match.");
        }
          if (lastNameController.text.isNotEmpty) {
            if (result.lastName.trim().toUpperCase() != lastNameController.text.trim().toUpperCase()) {
            errorMessages.add("Last name does not match.");
          }
          }
          
          if (result.gender.trim().toUpperCase() != selectedGender?.trim().toUpperCase()) {
            errorMessages.add("Gender does not match.");
          }
          if (result.dob.trim() != dobController.text.trim()) {
            errorMessages.add("Date of birth does not match.");
          }
          if (errorMessages.isNotEmpty) {
            String errorMessage = errorMessages.join("\n");
            showVerificationErrorDialog(errorMessage);
          } else {
            showVerificationSuccessDialog();
            isVerified = true;
            update();
            // await submitLoanApplication();
          }
          // Now access the properties of the result object
          //   firstNameController.text = result.firstName;
          //   genderController.text = result.gender;
          //   dobController.text = result.dob ;
          //   aadharNoController.text = result.aadhaarNumber;
          //   lastNameController.text = result.lastName ;
          //   update(); // Notify listeners to rebuild the UI
          // } else {
          //   firstNameController.text = AppStrings.notFound;
          //   lastNameController.text = AppStrings.notFound;
          //   genderController.text = AppStrings.notFound;
          //   dobController.text = AppStrings.notFound;
          //   // aadharNoController.text = AppStrings.notFound;
          //   update();
        }
      } else {
        showVerificationErrorDialog('Error: ${response.statusCode}');
        update();
      }
    } catch (e) {
      Get.snackbar(
         backgroundColor: AppColors.logoRedColor,
         colorText: Colors.white,
          duration: const Duration(seconds: 3),
          'Error',
          'An error occurred : No records found on this Pan Card');
      const Duration(days: 1);
    } finally {
      isLoading = false;
      update();
    }
  }

//submit pan details method
  Future<void> submitLoanApplication() async {
    String? pincode = pinCodeController.pincode;
    // print("pincode inside submit method$pinCode");
    print("LeadId inside submit method$customerLeadId");
    const String url =
        'https://api.salary4sure.com/sla-customer-loan-application';
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
      };
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode({
          "customer_lead_id": customerLeadId.toString(),
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "dob": dobController.text,
          "gender": selectedGender,
          "monthly_salary": monthlyIncomeController.text,
          "loan_amount": loanAmountController.text,
          "email": emailController.text,
           "pincode": pincode,
          "pancard": panController.text,
          "pancard_verified_status": 1
        }),
      );
      if (response.statusCode == 200) {
        Get.toNamed(MyAppRoutes.aadhaarCardVerificationScreen);
        // Get.toNamed(MyAppRoutes.employmentVerificationScreen);
        Get.snackbar(
            backgroundColor: AppColors.black,
            colorText: AppColors.green,
            'Success',
            'Loan application submitted successfully.');
      } else {
        Get.snackbar(
          backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
          'Error', 'Failed to submit loan application.');
      }
    } catch (e) {
      Get.snackbar(
        backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
          'Error', 'An error occurred while submitting the application.');
    }
  }

// success dialog
  void showVerificationSuccessDialog() {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        iconPadding: const EdgeInsets.all(5),
        icon: const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 199, 245, 200),
          radius: 50,
          child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 145, 240, 148),
              radius: 40,
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check_circle,
                    size: 50,
                    color: AppColors.black,
                  ))),
        ),
        title: Center(
          child: CustomText(
            textName: 'Verification Successfully',
            fontSize: 20,
            textColor: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: CustomText(
                textName: 'OK',
                fontSize: 18,
                textColor: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //error dialouge
  void showVerificationErrorDialog(String errorMessage) {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        iconPadding: const EdgeInsets.only(top: 8),
        icon: const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(Icons.error_outline_rounded,
                size: 50, color: Color.fromARGB(255, 190, 43, 33))),
        title: Center(
          child: CustomText(
            textName: 'Verification Failed !',
            fontSize: 20,
            textColor: AppColors.logoRedColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: CustomText(
          textName: errorMessage,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.bold,
          textColor: AppColors.green,
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: CustomText(
                textName: 'OK',
                fontSize: 18,
                textColor: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
