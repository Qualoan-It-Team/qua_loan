// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/model/response_model/get_user_details_response.dart';
import 'package:qualoan/model/response_model/loan_application_details_response.dart';
import 'package:qualoan/model/response_model/model_for_id_type.dart';
import 'package:qualoan/network/api/api_clients.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/view/dashboard/document_preview.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewProfileController extends GetxController {
  bool isLoading = false;
  bool isLoanApply = false;
  GetProfileDetailsResponse? userProfileResponse;
  LoanApplicationDetailsRespons? loanApplicationResponse;
  DocumentTypeResponse? docTypeId;
  String? nextSalaryDateString;
  String? formattedDate;
  String? nextSalaryDate;
  late ApiClient apiClient;
  

  @override
  void onInit() {
    apiClient = ApiClient();
    super.onInit();
    fetchDocumentList();
    fetchUserProfile();
    fetchLoanApplicationDetails();
  }

  //date formate method
  String formatDate(String? dateString) {
  if (dateString == null) {
    return ""; 
  }
  
  // Parse the UTC date string in to local
  DateTime dateTime = DateTime.parse(dateString);
    DateTime localDateTime = dateTime.toLocal();
    return DateFormat('yyyy/MM/dd').format(localDateTime);
}


//fetch user profile
  Future<void> fetchUserProfile() async {
    try {
       var response = await apiClient.getRequestWithToken(endPoint: EndPoints.localHostGetProfileDetails);
      if (response.statusCode == 200) {
        final Map<String, dynamic> userResponse = json.decode(response.body);
        userProfileResponse = GetProfileDetailsResponse.fromJson(userResponse);
        nextSalaryDate=userProfileResponse?.data.incomeDetails?.nextSalaryDate.toString();
        
      } else {
        isLoading = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
    }
    isLoading = false;
    update();
  }

  //fetch loan application details
  Future<void> fetchLoanApplicationDetails() async {
  isLoading = true;
  update();
  try {
    var response = await apiClient.getRequestWithToken(endPoint: EndPoints.localHostGetLoanApplicationDetailsUrl);
    final userResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {   
      loanApplicationResponse = LoanApplicationDetailsRespons.fromJson(userResponse);
    } 
    else {
    }
  } catch (e) {
    showCustomSnackbar(AppStrings.error,  "$e");
  } finally {
    isLoading = false;
    update();
  }
}

//
  Future<void> openWebPageForDocuments(String url) async {
    if (await launch(url)) {
      await launch(url);
    } else {
      throw '${AppStrings.couldNotLaunch} $url';
    }
  }

  //method for fetch documnet list
  Future<void> fetchDocumentList() async {
    try {
      isLoading = true;
      update();
      var response = await apiClient.getRequestWithToken(endPoint: EndPoints.localHostGetDocumentList);
      isLoading = false;
      update();
      if (response.statusCode == 200) {
        final Map<String, dynamic> documentResponse =json.decode(response.body);
        docTypeId = DocumentTypeResponse.fromJson(documentResponse);
      } else {}
    } catch (e) {
      isLoading = false;
      update();
    }
    update();
  }


//api method for preview documents
  Future<void> previewDocument(String docType, String docId) async {
    try {
      var response = await apiClient.getRequestWithToken( endPoint: "${EndPoints.localHostDocumentPreview}$docType&docId=$docId");
      print("response===documents${response.body}");
      if (response.statusCode == 200) {
        final Map<String, dynamic> previewResponse = json.decode(response.body);
        String previewUrl = previewResponse['url'];
        if (previewUrl != null && previewUrl.isNotEmpty) {
          Get.to(() => PdfViewerScreen(pdfUrl: previewUrl));
        } else {
          showCustomSnackbar(AppStrings.error, AppStrings.previewErrorMessage,backgroundColor: AppColors.black,textColor: AppColors.green);
          
        }
      } else {
        showCustomSnackbar(AppStrings.error, AppStrings.previewErrorMessage,backgroundColor: AppColors.logoRedColor,textColor: AppColors.white);
      }
    } catch (e) {
     print("$e");
    }
  }
}
