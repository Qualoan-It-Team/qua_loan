import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
//token expired
  Future<bool> isTokenExpired(String token) async {
    // Decode the token to check its expiration
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(decodedToken['exp'] * 1000);
    return expirationDate.isBefore(DateTime.now());
  }
// final prefs =  SharedPreferences.getInstance();
//   final token = prefs.getString(AppStrings.prefToken);
 @override
void initState() {
  super.initState();
  Timer(const Duration(seconds: 3), () async {
     String? token = await getToken();
     print("token======>$token");
     if (token != null && await isTokenExpired(token)) {
        // Token is expired
        Get.offNamed(MyAppRoutes.signInWithAadhaarScreen);
      } else if (token != null) {
        // Token is valid
        Get.offNamed(MyAppRoutes.dashboardScreen);
      } else {
        // No token found, navigate to sign-in
        Get.offNamed(MyAppRoutes.signInWithAadhaarScreen);
      }

    // Get.offNamed(MyAppRoutes.dashboardScreen);
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(AppImages.quaLogo)
        )
    );
  }
}