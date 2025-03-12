
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:qualoan/view/loan_application/employment_information.dart';
import 'package:qualoan/view/registration/mobile_number_verification.dart';
import 'package:qualoan/view/registration/personal_information.dart';
import 'package:qualoan/view/registration/registration_form.dart';




int? isViewed;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // InAppWebViewPlatform.instance = InAppWebViewFlutterPlatform();
  // final prefs = await SharedPreferences.getInstance();
  // final token = prefs.getString(AppStrings.token);
  // final prefs = await SharedPreferences.getInstance();
  // isViewed = prefs.getInt('onboard');
  await dotenv.load(fileName: "assets/.env"); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: MyAppRoutes.pages, 
      // home: PersonalInformation(),
      // home: token != null ? SplashScreen() : SignInWithAadhaarScreen(),
    );
  }

}


