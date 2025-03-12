// ignore_for_file: prefer_typing_uninitialized_variables, empty_catches
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/view/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dashboard_controller/dashboard_controller.dart';

class PersonalInformationController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mothersNameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController spouseNameController = TextEditingController();
  String? selectedGender ;
  String maritalStatus = '';
  var emailError;
  var fullNameError;
  var mothersNameError;
  var genderError;
  var dobError;
  var maritalstatusError;
  var spouseNameError;
  bool isLoading = false;
  bool isLoadingButton = false;
  List<String> maritalStatusOptions = <String>[
    AppStrings.singleText,
    AppStrings.marriedText,
    AppStrings.divorcedText,
    AppStrings.separatedText,
    AppStrings.windowedText,
  ];

  @override
  void onInit() {
    super.onInit();
    fetchProfileDetails();
  }

//email validation
  bool isEmailValid(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }
//all validation method
  void validateInputs() {
    fullNameError = null;
    emailError = null;
    genderError = null;
    dobError = null;
    maritalstatusError = null;
    spouseNameError = null;
    mothersNameError=null;
    //first name
    if (fullNameController.text.isEmpty) {
      fullNameError = AppStrings.fullNameRequired;
    } else {
      fullNameError = null;
    }
    if (mothersNameController.text.isEmpty) {
      mothersNameError = AppStrings.motherNameRequired;
    } else {
      mothersNameError = null;
    }
//gender
    if (selectedGender!.isEmpty) {
      genderError = AppStrings.genderRequired;
    } else {
      genderError = null;
    }
    // Marital Status
    if (maritalStatus == AppStrings.marriedText) {
      if (spouseNameController.text.isEmpty) {
        spouseNameError = AppStrings.spouseNameRequired;
      }
    }
    if (maritalStatus.isEmpty) {
      maritalstatusError = AppStrings.maritalStatusRequired;
    } else {
      maritalstatusError = null;
    }

    if (dobController.text.isEmpty) {
      dobError = AppStrings.dobRequired;
    } else {
      dobError = null;
    }
    if (spouseNameController.text.isEmpty) {
      spouseNameError = AppStrings.spouseNameRequired;
    } else {
      spouseNameError = null;
    }
    if (!isEmailValid(emailController.text)) {
      emailError = AppStrings.emailRequired;
    } else {
      emailError = null;
    }
    update();
  }

//this is for token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> fetchProfileDetails() async {
    isLoading = true;
    update();
    try {
      const String url = 'https://api.qualoan.com/api/user/getProfileDetails';
      String? token = await getToken();
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      isLoading = false;
      update();
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        fullNameController.text = data['data']['personalDetails']['fullName'] ?? '';
        fathersNameController.text = data['data']['personalDetails']['fathersName'] ?? '';
        String? dob = data['data']['personalDetails']['dob'];
      if (dob != null) {
        DateTime dateTime = DateTime.parse(dob);
         DateTime localDateTime = dateTime.toLocal();
        dobController.text = DateFormat('yyyy/MM/dd').format(localDateTime);
      } else {
        dobController.text = '';
      }
        selectedGender = data['data']['personalDetails']['gender'] ?? '';
        update();
      } else {
        Get.snackbar(
            backgroundColor: AppColors.white,
            colorText: AppColors.logoRedColor,
            AppStrings.error,
            AppStrings.faileToLoadProfile);
      }
      isLoading = false;
      update();
    } catch (e) {
    }
  }
//this method for submit the details
  Future<void> updatePersonalInfo() async {
    isLoadingButton = true;
    update();
    String? token = await getToken();
    // String formattedDob = DateFormat('yyyy-MM-dd').format(DateTime.parse(dobController.text));
    final response = await http.patch(
      Uri.parse('https://api.qualoan.com/api/user/personalInfo'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'personalEmail': emailController.text,
        'maritalStatus': maritalStatus,
        'spouseName': maritalStatus == AppStrings.marriedText ? spouseNameController.text: null,
        'dob': dobController.text,
        'gender': selectedGender.toString(),
        'fullName': fullNameController.text,
        'mothersName': mothersNameController.text
      }
      ),
    );
    isLoadingButton = false;
    update();
    if (response.statusCode == 200) {
      showCustomSnackbar(AppStrings.successText, AppStrings.personalInformationUptedSuccessfully,backgroundColor: AppColors.black,textColor: AppColors.green);
      Get.to(DashboardScreen());
      Get.find<DashboardScreenController>().onItemTapped(1);
    } else {
      showCustomSnackbar(AppStrings.error, AppStrings.failedUpdatPersonalInformation,backgroundColor: AppColors.logoRedColor,textColor: AppColors.white);
    }
    isLoadingButton = false;
    update();
  }
}
