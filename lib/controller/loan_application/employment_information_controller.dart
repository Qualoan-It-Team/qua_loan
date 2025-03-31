import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/controller/loan_application/loan_application_controller.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';

class EmploymentInformationController extends GetxController {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyTypeController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  TextEditingController officeAddressController = TextEditingController();
  TextEditingController officeLandmarkController = TextEditingController();
  final List<TextEditingController> pincodeControllers = List.generate(6, (index) => TextEditingController()); 
  TextEditingController officialEmailController = TextEditingController();
  TextEditingController cityNameController = TextEditingController();
  TextEditingController stateNameController = TextEditingController();
  final TextEditingController employedSinceController = TextEditingController();
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  List<String> workingType = <String>[
    "OFFICE",
    "HOME"
  ];
  String? pincode;
  String? selectedWorkingType;
  String? employerNameError;
  var workingTypeError;
  String? designationError;
  String? officeAddressError;
  String? companyTypeError;
  String? pinCodeError;
  String? emailError;
  String? cityError;
  String? stateError;
  String? landmarkError;
  String? employedSinceError;

  bool isValid = false; 
  bool isLoading = false; 
  bool isUpdated = false; 
  @override
  void onInit() {
   resetErrors();
   fetchLoanApplicationDetails();
   update();
    super.onInit();
  }

  bool isEmailValid(String email) {
    final RegExp emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegExp.hasMatch(email);
  }
void resetErrors() {
   employerNameError = null;
    designationError = null;
    officeAddressError = null;
    pinCodeError = null;
    emailError = null;
    cityError = null;
    landmarkError = null;
    stateError = null;
    workingTypeError = null;
    companyTypeError = null;
    employedSinceError=null;

    update(); 
  }
  void validateFields() {
    // Reset errors
    employerNameError = null;
    designationError = null;
    officeAddressError = null;
    pinCodeError = null;
    emailError = null;
    cityError = null;
    landmarkError = null;
    stateError = null;
    workingTypeError = null;
    companyTypeError = null;
    employedSinceError=null;


    // Validate each field
    if (companyNameController.text.isEmpty) {
      employerNameError = "Employer Name is required";
    }
    else{
      employerNameError=null;
    }
    if (designationController.text.isEmpty) {
      designationError = "Designation is required";
    }
    else{
      designationError = null;
    }
    if (employedSinceController.text.isEmpty) {
      employedSinceError = "Employed since date is required";
    }else{
      employedSinceError=null;
    }

    if (officeAddressController.text.isEmpty) {
      officeAddressError = "Office Address is required";
    }
    else {
      officeAddressError=null;
    }
    if (!isEmailValid(officialEmailController.text)) {
      emailError = 'Enter a valid email address';
    } else {
      emailError = null;
    }
    String pincode =
        pincodeControllers.map((controller) => controller.text).join('');
    if (pincode.length < 6) {
      pinCodeError = "Pincode must be 6 digits";
    }
    if (selectedWorkingType==null) {
      workingTypeError = "Select working type";
    } else {
      workingTypeError = null;
    }
      if (officeLandmarkController.text.isEmpty) {
      landmarkError = "Landmark is required";
    }
    else{
      landmarkError = null;
    }
     if (cityNameController.text.isEmpty) {
      cityError = "City is required";
    }else{
      cityError = null;
    }
    if (stateNameController.text.isEmpty) {
      stateError = "State is required";
    }
    else{
      stateError = null;
    }
    if (companyTypeController.text.isEmpty) {
      companyTypeError = "State is required";
    }
    else{
      stateError = null;
    }

    isValid = employerNameError == null &&
        designationError == null &&
        officeAddressError == null &&
        workingTypeError == null &&
        landmarkError == null &&
        cityError == null &&
        stateError == null &&     
        emailError == null &&
        pinCodeError == null&&
        employedSinceError==null&&
        companyTypeError == null;
    update();
  }

Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  ///pincode Api
  void fetchLocation(String pincode) async {
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
            cityNameController.text = postOffice[0]['Name'];
            stateNameController.text = postOffice[0]['State'];
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
              "Invalid pincode");
        }
      } else {
        cityNameController.text = 'Error: ${response.statusCode}';
        stateNameController.text = 'Error: ${response.statusCode}';
      }
    } catch (e) {
      cityNameController.text = 'Error';
      stateNameController.text = 'Error';
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
          fetchLocation(pincode);
        }
      }
    }
  }

  
 Future<void> submitEmploymentDetails() async {
  isLoading=true;
  update();
    String url = EndPoints.localHostAddEmploymentInfo;
    String? token = await getToken();
    pincode =pincodeControllers.map((controller) => controller.text).join('');
    final Map<String, dynamic> requestBody = {
      "workFrom": selectedWorkingType,
      "officeEmail": officialEmailController.text.trim(),
      "companyName": companyNameController.text.trim(),
      "companyType": companyTypeController.text.trim(),
      "designation": designationController.text.trim(),
      "officeAddrress": officeAddressController.text.trim(),
      "landmark": officeLandmarkController.text.trim(),
      "city": cityNameController.text.trim(),
      "state": stateNameController.text.trim(),
      "employedSince": employedSinceController.text.trim(),
      "pincode": pincode,
    };

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(requestBody),
      );
      isLoading=false;
  update();
      if (response.statusCode == 200) {
        Get.toNamed(MyAppRoutes.dashboardScreen);
        Get.find<DashboardScreenController>().onItemTapped(1);
        Get.snackbar(
          'Success',
          'Employment details submitted successfully.',
          backgroundColor: AppColors.black,
          colorText: AppColors.green,
        );
      } else {
        Get.snackbar(
          'Error',
          'Failed to submit employment details: ${response.body}',
          backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      isLoading=false;
  update();
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: AppColors.logoRedColor,
        colorText: Colors.white,
      );
    }
  }

@override
void onReady() {
  super.onReady();
  fetchLoanApplicationDetails();
}
  void fetchLoanApplicationDetails() async {
    
  await Get.find<LoanApplicationController>().fetchLoanApplicationDetails();
  if (Get.find<LoanApplicationController>().loanApplicationResponse?.data != null) {
    companyNameController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.companyName.toString();
    companyTypeController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.companyType.toString();
    officialEmailController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.officeEmail.toString();
    designationController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.designation.toString();
    officeAddressController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.officeAddrress.toString();
    cityNameController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.city.toString();
    stateNameController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.state.toString();
    officeLandmarkController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.landmark.toString();
    // employedSinceController.text = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.employedSince.toString();
   
    String? employedSinceDate =Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.employedSince.toString();
     if (employedSinceDate != null) {
        DateTime dateTime = DateTime.parse(employedSinceDate);
        employedSinceController.text = DateFormat('yyyy/MM/dd').format(dateTime);
      } else {
        employedSinceController.text = '';
      }
    pincode = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.pincode.toString();
    for (int i = 0; i < pincode!.length; i++) {
        pincodeControllers[i].text = pincode![i];
      }
    selectedWorkingType = Get.find<LoanApplicationController>().loanApplicationResponse!.data!.employeeDetails!.workFrom;
    print("value== ${companyNameController.text} ${companyTypeController.text} ${officialEmailController.text} ${designationController.text} ${officeAddressController.text} ${employedSinceController.text},");
    isUpdated = true;
    update();
  }
  update();
}


//select date method
 Future<void> selectDate(BuildContext context,) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      // firstDate: DateTime(1900),
      // firstDate: DateTime.now(),
      lastDate:DateTime.now());
    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      employedSinceController.text = formattedDate;
      validateFields();
    }
}
}
