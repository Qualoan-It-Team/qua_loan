import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/network/api/api_clients.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadAllDocumentsController extends GetxController {
  TextEditingController salarySlipRemarksController = TextEditingController();
  TextEditingController frontAadhaarRemarksController = TextEditingController();
  TextEditingController backAadhaarRemarksController = TextEditingController();
  TextEditingController panRemarksController = TextEditingController();
  TextEditingController otherRemarksController = TextEditingController();
  List<String> salarySlips = [];
  List<String> aadhaarFront = [];
  List<String> aadhaarBack = [];
  List<String> pancardList = [];
  List<String> otherDocuments = [];
  bool isLoading = false;
  bool?  isLoanApply;
  String? selectedDocumentType;
  List<String> documentTypes = [
    'Electricity Bill',
    'Gas Bill',
    'Residence Address',
  ];
  late ApiClient apiClient;
  //tracking the status 
bool areDocumentsFetched = false;
 bool hasDocuments = false;
 bool hasOnlyBankStatements =false;

@override
  void onInit() {
    apiClient=ApiClient();
    fetchDocumentList();
    super.onInit();
  }

//upload documents 

  Future<void> pickDocument(String type, {int requiredCount = 1}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: requiredCount > 1,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.length == requiredCount) {
      switch (type) {
        case 'salarySlips':
          salarySlips = result.files.map((file) => file.path!).toList();
          break;
        case 'aadhaarFront':
          aadhaarFront = result.files.map((file) => file.path!).toList();
          break;
        case 'aadhaarBack':
          aadhaarBack = result.files.map((file) => file.path!).toList();
          break;
        case 'pancard':
          pancardList = result.files.map((file) => file.path!).toList();
          break;
        case 'otherDocuments':
          otherDocuments = result.files.map((file) => file.path!).toList();
          break;
      }
      update();    
    }else {
      showCustomSnackbar(AppStrings.error, "Please select exactly $requiredCount salary slip",backgroundColor: AppColors.logoRedColor,textColor: AppColors.white);
    }
  }

 void openDocument(String path) {
    OpenFile.open(path);
  }


 Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  //upload documents method
  Future<void> uploadDocuments() async {
  isLoading = true;
  update();
  String? token = await getToken(); 
  String url = EndPoints.localHostUploadDocuments;
  var request = http.MultipartRequest(
    'PATCH',
    Uri.parse(url));
     request.headers.addAll({
      'Authorization': 'Bearer $token',
    });
request.fields['remarks'] = salarySlipRemarksController.text;
request.fields['remarks'] = frontAadhaarRemarksController.text;
request.fields['remarks'] = backAadhaarRemarksController.text;
request.fields['remarks'] = panRemarksController.text;
request.fields['remarks'] = otherRemarksController.text;
  // Add the documents to the request

  
  if (aadhaarFront.isNotEmpty) {
    for (var filePath in aadhaarFront) {
      request.files.add(await http.MultipartFile.fromPath('aadhaarFront', filePath));
    }
  }
  if (salarySlips.isNotEmpty) {
    for (var filePath in salarySlips) {
      request.files.add(await http.MultipartFile.fromPath('salarySlip', filePath));
    }
  }

  if (pancardList.isNotEmpty) {
    for (var filePath in pancardList) {
      request.files.add(await http.MultipartFile.fromPath('panCard', filePath));
    }
  }

  if (aadhaarBack.isNotEmpty) {
    for (var filePath in aadhaarBack) {
      request.files.add(await http.MultipartFile.fromPath('aadhaarBack', filePath));
    }
  }

  // Add other documents similarly
  if (otherDocuments.isNotEmpty) {
    for (var filePath in otherDocuments) {
      request.files.add(await http.MultipartFile.fromPath('others', filePath));
    }
  }


  // Send the request
  try {
    var response = await request.send();
     var responseData = await http.Response.fromStream(response);
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(responseData.body);
      print(jsonResponse); 
      showCustomSnackbar(AppStrings.successText, jsonResponse['message'],backgroundColor: AppColors.black,textColor: AppColors.green);
      Get.toNamed(MyAppRoutes.dashboardScreen);
      Get.find<DashboardScreenController>().onItemTapped(1);
    } else {
      Get.snackbar("Error", "Failed to upload documents",backgroundColor: AppColors.logoRedColor,colorText: AppColors.white);
    }
  } catch (e) {
    // isLoading=false;
    // update();
    print("error$e");
    Get.snackbar("Error", "An error occurred while uploading documents",backgroundColor: AppColors.logoRedColor,colorText: AppColors.white);
  } finally{
    isLoading=false;
    update();
  }
} 


Future<void> fetchDocumentList() async {
  try {
    isLoading = true;
    update();
    var response = await apiClient.getRequestWithToken(endPoint: EndPoints.localHostGetDocumentList);
    isLoading = false;
    update();
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> documentResponse = json.decode(response.body);
      List<dynamic> documents = documentResponse['documents'];

      // Reset document lists
      salarySlips.clear();
      aadhaarFront.clear();
      aadhaarBack.clear();
      pancardList.clear();
      otherDocuments.clear();

      // Check for specific documents
      for (var doc in documents) {
        switch (doc['type']) {
          case 'salarySlip':
            salarySlips.add(doc['url']);
            break;
          case 'aadhaarFront':
            aadhaarFront.add(doc['url']);
            break;
          case 'aadhaarBack':
            aadhaarBack.add(doc['url']);
            break;
          case 'panCard':
            pancardList.add(doc['url']);
            break;
          case 'otherDocuments':
            otherDocuments.add(doc['url']);
            break;
        }
      }

      // Determine if the user has all required documents
      hasDocuments = salarySlips.isNotEmpty || aadhaarFront.isNotEmpty || aadhaarBack.isNotEmpty || pancardList.isNotEmpty;

      // Check if only bank statements are present
      hasOnlyBankStatements = salarySlips.isEmpty && aadhaarFront.isEmpty && aadhaarBack.isEmpty && pancardList.isEmpty;
      salarySlips.clear();
      aadhaarFront.clear();
      aadhaarBack.clear();
      pancardList.clear();
      otherDocuments.clear();
      update();
    } else {
      hasDocuments = false;
      
    }
  } catch (e) {
    isLoading = false;
    update();
  }
}

@override
  void onReady() {
    fetchDocumentList();
    super.onReady();
  }
}
