// // ignore_for_file: unrelated_type_equality_checks

// import 'package:application/utils/shared_pref.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';


// mixin Helper {
//   /// Here creating the network connection check method
//   Future<bool> checkConnectivity() async {
//     var connectivityResult = await Connectivity().checkConnectivity();

//     if (connectivityResult == ConnectivityResult.wifi ||
//         connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.ethernet) {
//       return true;
//     }
//     return false;
//   }

//   ///Here creating the snackBar method.
//   void showSnackBar({required String title, required String message}) {
//     Get.snackbar(
//       title,
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: Colors.white,
//       borderColor: Colors.red,
//       borderWidth: 1,
//       colorText: Colors.red,
//       snackStyle: SnackStyle.GROUNDED,
//       duration: const Duration(seconds: 4),
//       margin: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
//       padding: const EdgeInsets.only(left: 10, top: 5, bottom: 10),
//     );
//   }

//   ///Here creating the method for date picker.
//   static Future<DateTime?> showDatePickerDialog(
//       {required BuildContext context,
//       required DateTime initialDate,
//       DateTime? firstDate,
//       DateTime? lastDate}) async {
//     var dateTime = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: firstDate ?? DateTime(1947),
//         lastDate: lastDate ?? DateTime.now());
//     return dateTime;
//   }

//   ///Here creating methods for time picker.
//   static Future<TimeOfDay?> showTimePickerDialog(
//       {required BuildContext context, required TimeOfDay initialTime}) async {
//     var time = await showTimePicker(
//       context: context,
//       initialTime: initialTime,
//     );
//     return time;
//   }

//   int getDifferenceInDates(String endDate, String startDate) {
//     int differenceInDay = 0;
//     differenceInDay = dateFormatter(endDate).difference(dateFormatter(startDate)).inDays;
//     debugPrint(differenceInDay.toString());
//     return differenceInDay+1;
//   }

//   String getSharedPrefValue(String key){
//     return SharedPrefs.getString(key: key);
//   }

//   int getIntegerValue(String key){
//     return SharedPrefs.getInt(key: key);
//   }
//   setStringValue(String key, String value){
//     return SharedPrefs.setString(key: key, value: value);
//   }

//   setIntegerValue(String key, int value){
//     return SharedPrefs.setInt(key: key, value: 0);
//   }
//   bool getBoolValue(String key){
//     return SharedPrefs.getBool(key: key);
//   }
//   setBoolValue(String key, bool value){
//     SharedPrefs.setBool(key: key, value: value);
//   }

//   DateTime dateFormatter(String date){
//     return DateFormat("MM/dd/yyyy").parse(date);

//   }


//    String dateFormat(DateTime date){
//     return DateFormat("MM/dd/yyyy").format(date).toString();

//   }

//   String unMaskNumber(String number){
//     return number
//         .toString().replaceAll("(", "").replaceAll(")", "")
//         .replaceAll(" ", "").replaceAll("-", "");
//   }


//   String maskNumber(String number){

//     return MaskTextInputFormatter(mask: '(###) ###-####', filter: {"#": RegExp(r'[0-9]')})
//         .maskText(number);
//   }


//   /// This function create for mobile number validation...
//   // String? validateMobile(String value) {
//   //   if (value.isEmpty) {
//   //     return AppStrings.enterNumber;
//   //   } else if (value.length != 14) {
//   //     return AppStrings.enterValidateNumber;
//   //   }
//   //   return null;
//   // }

//   // bool activeOrExpired(){
//   //   return getSharedPrefValue(AppStrings.userType) == AppStrings.activeTrip || getSharedPrefValue(AppStrings.userType) == AppStrings.expiredActiveQuote;
//   // }

  
//   // bool activeTripOrSold(){
//   //   return getSharedPrefValue(AppStrings.userType) == AppStrings.activeTrip || getSharedPrefValue(AppStrings.userType) == AppStrings.soldPending;
//   // }
// }
