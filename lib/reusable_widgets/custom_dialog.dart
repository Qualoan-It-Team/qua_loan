
import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_images&icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_strings.dart';
import 'custom_text.dart';


class CustomDialog extends StatelessWidget {
  final String? title;
  final String? text;
  final String? message;
  final Function()? onPressed;
  const CustomDialog({
    this.onPressed,
    this.title,
    this.text,
    this.message,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }
  Widget contentBox(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: Image.asset(AppImages.rightArrow,
              height: 100,
              width: 100,),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              textAlign: TextAlign.center,
              textName: title!,
              textColor: AppColors.logoBlueColor,
              fontWeight: FontWeight.bold,

            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              textName: text!,
              textAlign: TextAlign.center,
              fontSize: 16,
              fontWeight: FontWeight.bold,

            ),
          ),
          Text(
            message!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 25,
                color: AppColors.logoBlueColor,
                fontWeight: FontWeight.bold,
                fontFamily: "Audiowide"
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin:const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: onPressed,
              child: CustomText(
                textName: AppStrings.ok,
                fontSize: 17,
                textColor: AppColors.logoRedColor,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
        ],
      ),
    );
  }
}

