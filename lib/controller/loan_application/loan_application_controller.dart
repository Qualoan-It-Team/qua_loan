// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/loan_status_controller.dart';
import 'package:qualoan/model/response_model/loan_application_details_response.dart';
import 'package:qualoan/network/api/api_clients.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoanApplicationController extends GetxController {
  late ApiClient apiClient;
  LoanApplicationDetailsRespons? loanApplicationResponse;
  bool isLoading=false;
  bool isLoanCalculated =false;
  bool isEmployInformation =false;
  bool isUploadBankStatements =false;
  bool isShowDocuments =false;
  bool isBankDetails =false;
  String? applicationUnderProcess;
 String? applicationSenction;
 String? applicationDisbursed;

@override
  void onInit() {
    apiClient =ApiClient();
    fetchDashboardDetails();
    fetchRejectedStatus();
    update();
    super.onInit();
   
  }

  //token method
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

   Future<void> fetchDashboardDetails() async {
  const String url = 'https://api.qualoan.com/api/user/getDashboardDetails';
  String? token = await getToken();
  isLoading = true;
  update();
  try {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    isLoading = false;
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      isLoanCalculated = responseData['isLoanCalculated'] is bool ? responseData['isLoanCalculated'] : false;
      isEmployInformation = responseData['isEmploymentDetailsSaved'] is bool ? responseData['isEmploymentDetailsSaved'] : false;
      isUploadBankStatements = responseData['isBankStatementUploaded'] is bool ? responseData['isBankStatementUploaded'] : false;
      isShowDocuments = responseData['isDocumentUploaded'] is bool ? responseData['isDocumentUploaded'] : false;
      isBankDetails = responseData['isDisbursalDetailsSaved'] is bool ? responseData['isDisbursalDetailsSaved'] : false;
      update();
    } else {
       Get.snackbar(
      backgroundColor: AppColors.logoRedColor,
      colorText: AppColors.white,
      AppStrings.error,
      "Failed to fetch dashboard details");
    }
  } catch (e) {
     isLoading = false;
    update();
  }
}

//loan application api method
Future<void> fetchLoanApplicationDetails() async {
  isLoading = true;
  update();
  try {
    var response = await apiClient.getRequestWithToken(
        endPoint: EndPoints.localHostGetLoanApplicationDetailsUrl);
    final userResponse = jsonDecode(response.body);
      isLoading= false;
      update();
    if (response.statusCode == 200) {
      loanApplicationResponse = LoanApplicationDetailsRespons.fromJson(userResponse);
    } else {
      showCustomSnackbar("Error", "Failed to fetch loan details");
    }
  } catch (e) {
    showCustomSnackbar("Error", "An error occurred while fetching loan details");
  } finally {
    isLoading = false;
    update();
  }
}


//this method is created for show status bar
double getProgressPercentage() {
    int completedSteps = 0;
    int totalSteps = 5; 
    if (isLoanCalculated) completedSteps++;
    if (isEmployInformation) completedSteps++;
    if (isUploadBankStatements) completedSteps++;
    if (isShowDocuments) completedSteps++;
    if (isBankDetails) completedSteps++;
    return (completedSteps / totalSteps) * 100; 
    
  }
@override
  void onReady() {
    getProgressPercentage();
    fetchDashboardDetails();
    fetchRejectedStatus();
    super.onReady();
  }

  //method for get rejected status 
  Future<void> fetchRejectedStatus() async {
    LoanStatusController loanStatusController = Get.find<LoanStatusController>();
        await loanStatusController.getLoanStatus();
    applicationUnderProcess = loanStatusController.applicationUnderProcess;
    applicationSenction=loanStatusController.applicationSenction;
    applicationDisbursed=loanStatusController.applicationDisbursed;
       update();
      }
}
