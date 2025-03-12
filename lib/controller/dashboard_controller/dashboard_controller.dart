// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/registration_form_controller.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/view/dashboard/home_screen.dart';
import 'package:qualoan/view/dashboard/calculator.dart';
import 'package:qualoan/view/dashboard/loan_status.dart';
import 'package:qualoan/view/loan_application/loan_application.dart';
import 'package:qualoan/view/registration/registration_form.dart';

class DashboardScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  bool isRegisterationtab=false;
  bool isLoanApply=false;
  int isSelectedIndex = 0;
  String?message;
  var isLocationPermissionGranted = false;
  late TabController tabController = TabController(length: 4, vsync: this);
  List<Widget> pages = <Widget>[
    HomeScreen(),
    RegistrationFormScreen(),
    LoanStatus(),
    CalculatorScreen(),


  ];
  @override
  void onInit() {
   checkLocationPermission();
   fetchDashboardDetails();
    super.onInit();
  }

  //this method for ontap for indexing
  void onItemTapped(int index) {
    isSelectedIndex = index;
    tabController.index = index; 
    update(); 
  }
 Future<void> fetchDashboardDetails() async {
    RegistrationFormController registrationController = Get.find<RegistrationFormController>();
        await registrationController.fetchDashboardDetails();
    isRegisterationtab=registrationController.isRegistration;
    isLoanApply=registrationController.isLoanApplied;
    message=registrationController.message;
    update();
    if (registrationController.isRegistration==true) {
      pages[1] = RegistrationFormScreen();
    } else{
      pages[1] = LoanApplicationScreen();
    }
    if(registrationController.isLoanApplied==true){
     pages[2] = LoanStatus();
    }else{
      pages[2]=  Center(child: CustomText(textName: AppStrings.firstCompleteLoanApp,textColor: AppColors.lightOrange,fontSize: 16,));

    }

    update(); 
  }

// here i implement only allow cases
  Future<void> checkLocationPermission() async {
    while (true) {
      var permissionStatus = await Permission.location.status;
      if (permissionStatus.isGranted) {
        isLocationPermissionGranted = true;
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        break;
      } else if (permissionStatus.isDenied) {
        var status = await Permission.location.request();
        if (status.isGranted) {
          isLocationPermissionGranted = true;
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          break;
        } else {}
      } else if (permissionStatus.isPermanentlyDenied) {
        openAppSettings();
        break;
      }
      await Future.delayed(const Duration(seconds: 2));
    }
  }
  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
