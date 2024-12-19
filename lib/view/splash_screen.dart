import 'dart:async';
import 'package:app_here/constants/app_images&icons.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {

 @override
void initState() {
  super.initState();
  Timer(const Duration(seconds: 3), () {


    Get.offNamed(MyAppRoutes.locationScreen);
    // Get.offNamed(MyAppRoutes.panKycVerificationScreen);

    // Get.toNamed(MyAppRoutes.aadhaarCardVerificationScreen);
    //this is for one time location screen 
    // controller.isFirstTime.value ?
    //  Get.toNamed(MyAppRoutes.locationScreen)

    //  : Get.toNamed(MyAppRoutes.loginScreen);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white
      ,
        body: Center(
          child: Image.asset(AppImages.salary4SureLogo)
        )
    );
  }
}