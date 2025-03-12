import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';

void showCustomSnackbar(String title, String message, {Color? backgroundColor, Color? textColor}) {
  Get.snackbar(
    title,
    message,
    backgroundColor: backgroundColor ?? AppColors.black, 
    colorText: textColor ?? Colors.white, 
    snackPosition: SnackPosition.TOP, 
    duration: const Duration(seconds: 3),
  );
}