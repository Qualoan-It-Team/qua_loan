// ignore_for_file: deprecated_member_use
import 'package:app_here/routes/app_routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class LocationScreenController extends GetxController {
  var isFirstTime = true.obs;
  var isLocationPermissionGranted = false;
  // bool status = SharedPrefs.getBool(key: "AppStrings.locationText");
//   // this is also working good 
//   //one time screen show method
//   Future<void> checkFirstTime() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     isFirstTime.value = prefs.getBool('isFirstTime') ?? true;
//     if (isFirstTime.value) {
//       await prefs.setBool('isFirstTime', false);
//     }
//   }


// here i implement only allow cases
Future<void> checkLocationPermission() async {
  while (true) {
    var permissionStatus = await Permission.location.status;
    if (permissionStatus.isGranted) {
      isLocationPermissionGranted = true;
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      Get.toNamed(MyAppRoutes.loginScreen);
      break; 
    } else if (permissionStatus.isDenied) {
      var status = await Permission.location.request();
      if (status.isGranted) {
        isLocationPermissionGranted = true;
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        break; 
      } else {
      }
    } else if (permissionStatus.isPermanentlyDenied) {
      openAppSettings();
      break;
    }
    await Future.delayed(const Duration(seconds: 2));
  }
}
}