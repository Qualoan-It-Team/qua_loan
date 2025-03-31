// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/network/end_points.dart';
import 'package:qualoan/reusable_widgets/custom_success_dialog.dart';
import 'package:qualoan/view/dashboard/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadSelfieController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  XFile? selfieImage;
  bool isLoading = false;

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> pickImage(ImageSource source) async {
  try {
    selfieImage = await _picker.pickImage(source: source);
    if (selfieImage != null) {
      update();
    } else {
      Get.snackbar(AppStrings.error, 'No image selected',backgroundColor: AppColors.logoRedColor,colorText: AppColors.white);
    }
  } catch (e) {
    Get.snackbar(AppStrings.error, 'An error occurred while picking the image',backgroundColor: AppColors.logoRedColor,colorText: AppColors.white);
  }
}

  Future<void> uploadProfilePicture() async {
  if (selfieImage == null) return;
  var url = EndPoints.localHostUploadProfile; 

  String? token = await getToken();
  var request = http.MultipartRequest('PATCH', Uri.parse(url));
  request.headers.addAll({
    'Authorization': 'Bearer $token',
  });
  request.files.add(await http.MultipartFile.fromPath(
    'profilePicture', 
    selfieImage!.path,
    contentType: MediaType('image', 'jpeg'),
  ));

  try {
    isLoading = true;
  update();
    final response = await request.send();
    final responseBody = await http.Response.fromStream(response);
   isLoading = false;
  update();
    if (response.statusCode == 200) {
      Future.delayed(Duration.zero, () {
      CustomSuccessDialog.showDialog(
        title: 'Thank! You',
        icon: Icons.check,
        iconColor: AppColors.green,
        titleColor: Colors.green,
        buttonText: 'OK',
        content: "Your Registration has been completed successfully",
        contentColor: AppColors.black,
        onButtonPressed: () {
          Get.back(); 
        },
      );
    });
      Get.snackbar(AppStrings.successText, 'Profile picture uploaded successfully',backgroundColor: AppColors.black,colorText: AppColors.green);
      Get.to(DashboardScreen());
      Get.find<DashboardScreenController>().onItemTapped(1);
    } else {
      Get.snackbar(AppStrings.error, 'Failed to upload profile picture: ${responseBody.body}',backgroundColor: AppColors.logoRedColor,colorText: AppColors.white);
    }
  }  finally {
    isLoading = false;
    update();
  }
}
}


