
// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadBankStatementController extends GetxController{
TextEditingController bankPasswordController=TextEditingController();
List<File> selectedFiles = [];
bool isBankStatementlipSelected = false;
bool isLoading=false;
String? customerLeadId;

 Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }
  Future<void> pickPDF() async {
    final FilePickerResult? pickedFiles = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (pickedFiles != null && pickedFiles.files.isNotEmpty) {
      // if ((pickedFiles.files.length <= 1) || (pickedFiles.files.length <= 3)) {
      // if ((pickedFiles.files.length <= 1)) {
      selectedFiles =pickedFiles.files.map((file) => File(file.path!)).toList();
       isBankStatementlipSelected = false;
       update();

      // }
      //  else {
      //   Get.snackbar(
      //     snackPosition: SnackPosition.TOP,
      //   colorText: Colors.white,
      //   backgroundColor: AppColors.logoRedColor,
      //   'Failed', 'You can only select up to 3 PDF files.');
      // }
    } 
    else {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: AppColors.logoRedColor,
        'Retry', 'No files selected. Please try again');
     
    }
  }

Future<void> uploadBankStatements() async {
    if (selectedFiles.isEmpty) {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: AppColors.logoRedColor,
        'Error', 'No files selected for upload');
      return;
    }

    isLoading = true;
    update();
    var url = EndPoints.localHostUploadDocuments;
    String? token = await getToken(); 
    var request = http.MultipartRequest('PATCH', Uri.parse(url));
    request.headers.addAll({
      'Authorization': 'Bearer $token',
    });
    request.fields['remarks'] = bankPasswordController.text;
    for (var file in selectedFiles) {
      request.files.add(await http.MultipartFile.fromPath(
        'bankStatement',
        file.path,
        contentType: MediaType('application', 'pdf'), 
      ));
    }

    try {
      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);
      if (response.statusCode == 200) {
        Get.toNamed(MyAppRoutes.dashboardScreen);
        Get.find<DashboardScreenController>().onItemTapped(1);
        Get.snackbar('Success', 'Bank statements uploaded successfully',backgroundColor: AppColors.black,colorText: AppColors.green);
      } else {
        Get.snackbar('Error', 'Failed to upload bank statements: ${responseBody.body}',backgroundColor: AppColors.logoRedColor,colorText: AppColors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while uploading the bank statements',backgroundColor: AppColors.logoRedColor,colorText: AppColors.white);
    } finally {
      isLoading = false;
      update();
    }
  }
}
