import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';

class CustomErrorDialog {
  static void showDialog({
    required String title,
    required String content,
     IconData? icon,
     Color? iconColor,
     Color? titleColor,
     Color? contentColor,
     String? buttonText,
     VoidCallback? onButtonPressed,
  }) {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        iconPadding: const EdgeInsets.only(top: 15),
        icon: Icon(Icons.error_outline,color: AppColors.logoRedColor,size: 35,),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              textName: title,
              fontSize: 20,
              textColor: AppColors.logoRedColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: CustomText(
          textName: content,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
          textColor: AppColors.black,
          overflow: TextOverflow.fade,
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: CustomText(
                textName: 'OK',
                fontSize: 18,
                textColor: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
