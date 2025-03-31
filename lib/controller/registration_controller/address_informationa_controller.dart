import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/controller/loan_application/view_profile_controller.dart';
import 'package:qualoan/network/end_points.dart';
import 'dart:convert';
import 'package:qualoan/view/dashboard/dashboard_screen.dart';
import 'package:http/http.dart' as http;
import 'package:qualoan/constants/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressInformationController extends GetxController {
  final List<TextEditingController> pincodeControllers =
      List.generate(6, (index) => TextEditingController());
  List<String> recidenceOptions = <String>[
    AppStrings.owned,
    AppStrings.rented,
    AppStrings.parental,
    AppStrings.companyProvided,
    AppStrings.others
  ];
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  TextEditingController addressController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController residingSinceController = TextEditingController();
  String? pincode;
  bool isLoading = false;
  bool isUpdated = false;
  String? addressError;
  String? residingSinceError;
  String? landmarkError;
  String? cityError;
  String? stateError;
  String? pinCodeError;
  String? recidentTypeError;
  String? selectedResidenceType;
  bool isValid = false;
 
@override
void onInit() {
    resetErrors();
    super.onInit();
  }
  void resetErrors() {
    addressError = null;
    landmarkError = null;
    cityError = null;
    stateError = null;
    pinCodeError = null;
    recidentTypeError=null;
   residingSinceError = null;

    update(); 
  }
  void validateFields() {
    addressError = null;
    landmarkError = null;
    cityError = null;
    stateError = null;
    pinCodeError = null;
    recidentTypeError = null;
    residingSinceError = null;
    update();

    if (addressController.text.isEmpty) {
      addressError = "Address is required";
    }
    if (landmarkController.text.isEmpty) {
      landmarkError = "Landmark is required";
    }
    if (residingSinceController.text.isEmpty) {
      residingSinceError = "Residing since is required";
    }
    if (cityController.text.isEmpty) {
      cityError = "City is required";
    }
    if (stateController.text.isEmpty) {
      stateError = "State is required";
    }
    String pincode =
        pincodeControllers.map((controller) => controller.text).join('');
    if (pincode.length < 6) {
      pinCodeError = "Pincode must be 6 digits";
    }
    if (selectedResidenceType == null) {
      recidentTypeError = "Residence type is required";
    }
    isValid = addressError == null &&
        landmarkError == null &&
        cityError == null &&
        stateError == null &&
        pinCodeError == null &&
        recidentTypeError == null && 
        residingSinceError==null;

    update();
  }

  ///
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  ///pincode Api
  void fetchCityState(String pincode) async {
    isLoading = true;
    update();
    try {
      final response = await http
          .get(Uri.parse('https://api.postalpincode.in/pincode/$pincode'));
      isLoading = false;
      update();
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data[0]['Status'] == 'Success') {
          final postOffice = data[0]['PostOffice'];
          if (postOffice.isNotEmpty) {
            cityController.text = postOffice[0]['Name'];
            stateController.text = postOffice[0]['State'];
            cityError = null;
            stateError = null;
          } else {
            Get.snackbar(
                backgroundColor: AppColors.white,
                colorText: AppColors.logoRedColor,
                AppStrings.error,
                "failed to fetch city state");
          }
        } else {
          Get.snackbar(
              backgroundColor: AppColors.white,
              colorText: AppColors.logoRedColor,
              AppStrings.error,
              "failed to fetch city state");
        }
      } else {
        cityController.text = 'Error: ${response.statusCode}';
        stateController.text = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      cityController.text = 'Error';
      stateController.text = 'Error';
    } finally {
      isLoading = false;
    }
  }


  //onchange method for api
  void onOtpChanged(String value, int index) {
    if (value.length == 1) {
      if (index < 5) {
        FocusScope.of(Get.context!).requestFocus(focusNodes[index + 1]);
      } else {
        String pincode =
            pincodeControllers.map((controller) => controller.text).join('');
        this.pincode = pincode;
        if (pincode.length == 6) {
          fetchCityState(pincode);
        }
      }
    }
  }

  ///addressinfo api
  Future<void> updateAddress() async {
    String url = EndPoints.localHostCurrentResidence;
    String? token = await getToken();
    final Map<String, dynamic> body = {
      "address": addressController.text,
      "landmark": landmarkController.text,
      "city": cityController.text,
      "state": stateController.text,
      "pincode": pincode,
      "residenceType": selectedResidenceType,
      "residingSince": residingSinceController.text,
    };

    try {
      isLoading = true;
      isUpdated = false;
      update();
      
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(body),
      );
      isLoading = false;
      update();
      if (response.statusCode == 200) {
       Get.snackbar(
           backgroundColor: AppColors.black,
          colorText: AppColors.green,
          AppStrings.successText, "Address submitted successfully");
        Get.to(DashboardScreen());
        Get.find<DashboardScreenController>().onItemTapped(1);
      } else {
        Get.snackbar(
          AppStrings.error, " ${response.body}",backgroundColor: AppColors.logoRedColor,colorText: AppColors.white);
      }
    } catch (e) {
       isLoading=false;
    update();
      Get.snackbar(AppStrings.error, "${AppStrings.errorOccured} $e");
    }
  }

  //select residing since date
  Future<void> selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      // firstDate: DateTime.now().add( const Duration(days: 365)),
      lastDate: DateTime.now(),
      // lastDate: DateTime.now().add( const Duration(days: 365)),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(),
          child: child!,
        );
      },
    );
    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      residingSinceController.text = formattedDate;
      validateFields();
    }
  }

  ///this is api for fetch data when user edit
   @override
void onReady() {
  super.onReady();
  fetchResidenceAddress();
  update();
}
  void fetchResidenceAddress() async {
  await Get.find<ViewProfileController>().fetchUserProfile();
  if (Get.find<ViewProfileController>().loanApplicationResponse?.data != null) {
    addressController.text = Get.find<ViewProfileController>().userProfileResponse!.data.residence!.address.toString();
    landmarkController.text = Get.find<ViewProfileController>().userProfileResponse!.data.residence!.landmark.toString();
    cityController.text = Get.find<ViewProfileController>().userProfileResponse!.data.residence!.city.toString();
    stateController.text = Get.find<ViewProfileController>().userProfileResponse!.data.residence!.state.toString();
    selectedResidenceType = Get.find<ViewProfileController>().userProfileResponse!.data.residence!.residenceType.toString();
    String? residenceSince = Get.find<ViewProfileController>().userProfileResponse!.data.residence!.residingSince.toString();
     if (residenceSince != null) {
        DateTime dateTime = DateTime.parse(residenceSince);
        residingSinceController.text = DateFormat('yyyy/MM/dd').format(dateTime);
      } else {
        residingSinceController.text = '';
      }
    pincode = Get.find<ViewProfileController>().userProfileResponse!.data.residence!.pincode.toString();
    for (int i = 0; i < pincode!.length; i++) {
        pincodeControllers[i].text = pincode![i];
      }
    
    isUpdated = true;
    update();
  }
  update();
}
  }

