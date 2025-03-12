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

class BasicFormController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController fathersNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  var fullNameError;
  var mobileError;
  var fathersNameError;
  var panError;
  bool isLoading = false;
  bool isLoadingButton = false;

  @override
  void onInit() {
    super.onInit();
    fetchProfileDetails();
  }

  //valid pan
   bool isPanValid(String pan) {
    final RegExp panRegExp = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$');
    return panRegExp.hasMatch(pan);
  }

//all validation method
  void validateInputs() {
    fullNameError = null;
    mobileError=null;
    fathersNameError=null;
    panError=null;
    //first name
    if (fullNameController.text.isEmpty) {
      fullNameError = AppStrings.fullNameRequired;
    } else {
      fullNameError = null;
    }
    if (mobileNumberController.text.isEmpty) {
      mobileError = AppStrings.mobileNumberRequired;
    } else {
      mobileError = null;
    }
    if (fathersNameController.text.isEmpty) {
      fathersNameError = AppStrings.fathersNameRequired;
    } else {
      fathersNameError = null;
    }
    if (!isPanValid(panController.text)) {
      panError = AppStrings.validPan;
    } else {
      panError = null;
    }
    update();
  }

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
         mobileNumberController.text = data['data']['mobile'] ?? '';
        fullNameController.text = data['data']['personalDetails']['fullName'] ?? '';
        String? dob = data['data']['personalDetails']['dob'];
        if (dob != null) {
        DateTime dateTime = DateTime.parse(dob);
        dobController.text = DateFormat('yyyy/MM/dd').format(dateTime);
      } else {
        dobController.text = '';
      }
        genderController.text = data['data']['personalDetails']['gender'] ?? '';
       
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

  Future<void> updatePersonalInfo() async {
    isLoadingButton = true;
    update();
    String? token = await getToken();
    final response = await http.patch(
      Uri.parse('https://api.qualoan.com/api/user/addFormDetails'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
       'pan': panController.text.trim(),
       'fathersName': fathersNameController.text.trim(),
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
