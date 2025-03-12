// ignore_for_file: deprecated_member_use

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/login_controller/sign_in_aadhaar_controller.dart';
import 'package:qualoan/reusable_widgets/animated_button.dart';
import 'package:qualoan/reusable_widgets/animated_logo.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/reusable_widgets/custom_text_field.dart';

class SignInWithAadhaarScreen extends StatelessWidget {
 SignInWithAadhaarScreen({super.key});
 final _controller = Get.put(SignInWithAadhaarController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SignInWithAadhaarController>(
        init: _controller,
        builder: (controller) {
          return  Container(
            height: Get.height*0.9999,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.white.withOpacity(0.14),        
                AppColors.black.withOpacity(1.0)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 55,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedLogo(),
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: CustomText(
                    textName: AppStrings.signInToContinue,
                  fontWeight: FontWeight.bold,
                    textColor: AppColors.white,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14,top: 20),
                  child: CustomText(
                    textName: AppStrings.signInWithAadhaar,
                  fontWeight: FontWeight.w400,
                    textColor: AppColors.black,
                    fontSize: 15,
                  ),
                ),
        
                  CustomTextField(
                        controller: _controller.aadhaarController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp("[0-9]"),allow: true),
                          LengthLimitingTextInputFormatter(12),
                        ],
                        errorText: !_controller.isAadhaarValid
                            ? _controller.errorMessage
                            : null,
                            filled: true,
                            fillColor: AppColors.white.withOpacity(0.7),
                        hintText: AppStrings.aadhaarNumber,
                      ),
                      SizedBox(height: Get.height*0.15),
                   Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      activeColor: AppColors.orangeLogoColor,
                      value: _controller.isTermsAccepted,
                      onChanged: (bool? value) {
                        _controller.toggleTerms();
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: AppStrings.byContinueText,
                              style: TextStyle(color: AppColors.white,fontSize: 14)),
                          TextSpan(
                            text: AppStrings.tAndctext,
                            style: const TextStyle(
                              color: AppColors.orangeLogoColor,

                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _controller.openWebPage(
                                    "https://www.qualoan.com/terms-condition");
                              },
                          ),
                          const TextSpan(
                              text: AppStrings.andText,
                              style: TextStyle(color: AppColors.white)),
                          TextSpan(
                            text: AppStrings.privacyText,
                            style: const TextStyle(
                              color: AppColors.orangeLogoColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              _controller.openWebPage(
                                    "https://www.qualoan.com/privacy-policy");
                            },
                          ),
                          const TextSpan(
                              text: AppStrings.applicationText,
                              style: TextStyle(color: AppColors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _controller.isLoading? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.white,
                        )) :
                AnimatedButton(
                  onPressed: () {
                      _controller.isTermsAccepted
                          ? _controller.submitForm()
                          : null;
                  },
                  label: AppStrings.signIn,
                  
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
        }
      ),
    );
  }
}