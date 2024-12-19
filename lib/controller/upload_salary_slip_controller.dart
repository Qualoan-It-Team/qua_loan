
import 'dart:convert';
import 'dart:io';
import 'package:app_here/routes/app_routes.dart';
import 'package:http/http.dart' as http;
import 'package:app_here/constants/app_colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UploadSalarySlipController extends GetxController{

List<File> selectedFiles = [];
bool isPayslipSelected = false;
bool isLoading=false;
String? customerLeadId;
TextEditingController salarySlipPasswordController=TextEditingController();



 void setCustomerLeadId(String id) {
    customerLeadId = id;
    update(); // Notify listeners about the change
  }

  Future<void> pickPDF() async {
    // Allow the user to pick multiple PDF files
    final FilePickerResult? pickedFiles = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFiles != null && pickedFiles.files.isNotEmpty) {
      if (pickedFiles.files.length <= 3) {
          selectedFiles =pickedFiles.files.map((file) => File(file.path!)).toList();
       isPayslipSelected = false;
       update();

      } else {
        // Handle the case where more than 3 files are selected
        Get.snackbar(
          snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: AppColors.logoRedColor,
        'Failed', 'You can only select up to 3 PDF files.');
       
      }
    } else {
      // Handle the case where no files are selected
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: AppColors.logoRedColor,
        'Retry', 'No files selected. Please try again');
     
    }
  }
  

    Future<void> slipDocumentsUpload() async {
    if (selectedFiles.isEmpty) {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: AppColors.logoRedColor,
        'Error', 'No files selected for upload');
      return;
    }

  final response1 = await http.get(
      Uri.parse('https://api.salary4sure.com/sla-get-docs-master'),
      headers: {
        'Content-Type': 'application/json',
        'accept': 'application/json',
        'auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
      },
    );

    if (response1.statusCode == 200) {
      // Handle the response from the first API if needed
      print('Documents fetched successfully: ${response1.body}');
    } else {
      Get.snackbar('Error', 'Failed to fetch documents');
      return;
    }
 isLoading = true;
 update();
 int successfulUploads = 0;
    // Prepare the request for the second API
    for (var file in selectedFiles) {
            List<int> fileBytes = await file.readAsBytes();
            String base64File = base64Encode(fileBytes);
      final requestBody = jsonEncode({
        "customer_lead_id": customerLeadId.toString().trim(),
        "docs_id": "16", 
        "password": salarySlipPasswordController.text.trim(),
        "file": base64File,
      });
      print("${salarySlipPasswordController.text.trim()}");
      print("Lead ID${customerLeadId.toString().trim()}");
      //send the request
final response2 = await http.post(
        Uri.parse('https://api.salary4sure.com/sla-customer-upload-docs'),
        headers: {
          'Content-Type': 'application/json',
          'accept': 'application/json',
          'auth': 'ZDljOGRhMjFhMjEyZmQ5OGNlNGE0NTFhZTkxOWU0Njc=',
        },
        body: requestBody,
      );
      print("Status code: ${response2.statusCode}");
  isLoading=false;
  update();
      if (response2.statusCode == 200) {
         successfulUploads++;
        // Get.snackbar(
        //   backgroundColor: AppColors.black,
        //   colorText: AppColors.green,
          // 'Success' ,'File uploaded successfully');
          // Get.toNamed(MyAppRoutes.uploadSalarySlipScreen);
      } else {
        Get.snackbar(
          backgroundColor: AppColors.logoRedColor,
          colorText: Colors.white,
          'Error', 'Failed to upload Salary slip: ${file.path}');
      }
    }
    isLoading = false;
  update();
  if (successfulUploads == selectedFiles.length) {
    Get.snackbar(
      backgroundColor: AppColors.black,
      colorText: AppColors.green,
      'Success', 'Salary slip uploaded successfully');
    Get.toNamed(MyAppRoutes.loanConfirmation);
  }
  }
}
