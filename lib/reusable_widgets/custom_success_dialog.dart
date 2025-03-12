import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';

class CustomSuccessDialog {
  static void showDialog({
    required String title,
    required String content,
    required IconData icon,
    required Color iconColor,
    required Color titleColor,
    required Color contentColor,
    required String buttonText,
    required VoidCallback onButtonPressed,
  }) {
    Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        content: CustomText(textName: content,overflow: TextOverflow.fade,textAlign: TextAlign.center,fontSize: 16,),
        iconPadding: const EdgeInsets.all(5),
        icon:  const CircleAvatar(
          backgroundColor: Color.fromARGB(255, 199, 245, 200),
          radius: 50,
          child: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 145, 240, 148),
              radius: 40,
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check_circle,
                    size: 50,
                    color: AppColors.black,
                  )
                  )),
        ),
        title: Center(
          child: CustomText(
            textName: title,
            fontSize: 22,
            textColor: titleColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Center(
            child: TextButton(
              onPressed: () {
                Get.back();
              },
              child: CustomText(
                textName: AppStrings.ok,
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
