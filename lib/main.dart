
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
      // home: FlowDiagramScreen(),
      initialRoute: '/',
      getPages: MyAppRoutes.pages, 
    );
  }

}


