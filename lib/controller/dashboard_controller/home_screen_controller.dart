// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/registration_form_controller.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenController extends GetxController {

bool isRegistrationCondition = false;
bool isloanApplyCondition = false;
String? isRegisterationMessage;
@override
  void onInit() {
   fetchDashboardDetails();
    super.onInit();
  }
  // Whatsap integration method
  whatsApp() async {
    const phoneNumber = AppStrings.whatsappNumber;
    const message = AppStrings.whatsappHelpText;
    final url = 'https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      if (Theme.of(Get.context!).platform == TargetPlatform.android) {
        const playStoreUrl = EndPoints.playStoreUrl;
        await launch(playStoreUrl);
      } else if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
        const appStoreUrl = EndPoints.appStoreUrl;
        await launch(appStoreUrl);
      } else {
        Get.snackbar(AppStrings.error,
            AppStrings.whatsappNotInstalledText);
      }
    }
  }
  Future<void> fetchDashboardDetails() async {
    RegistrationFormController registrationController = Get.put(RegistrationFormController());
    await registrationController.fetchDashboardDetails();
    isRegistrationCondition = registrationController.isRegistration;
    isloanApplyCondition = registrationController.isLoanApplied;
    isloanApplyCondition = registrationController.isLoanApplied;
       if (isRegisterationMessage == true) {
      update(); 
    }
    update();
  }

  //open url method
  Future<void> launchURL(String url) async {
  if (await launch(url)) {
    await launch(url);
  } else {
    throw '${AppStrings.couldNotLaunch}$url';
  }
}
}