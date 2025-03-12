// ignore_for_file: camel_case_types, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/mobile_no_verification_controller.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import '../../reusable_widgets/custom_text_field.dart';

class MobileNumberVerification extends StatelessWidget {
  MobileNumberVerification({super.key});
  final _controller = Get.put(MobileNumberVerificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MobileNumberVerificationController>(
        init: _controller,
        builder: (controller) {
          return Stack(
            children: [
               Positioned.fill(
                  child: Image.asset(
                    fit: BoxFit.cover,
                    opacity: const AlwaysStoppedAnimation(0.8),
                    AppImages.mobileBgImage)
                      ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 7.0),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: Get.width * 0.9,
                  padding: const EdgeInsets.only(
                  top: 10, right: 20, left: 20, bottom: 20),
                  decoration: BoxDecoration(
                    color: AppColors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.02),
                        Center(
                          child: CustomText(
                            textName: AppStrings.mobileNumberVerificationText,
                            textColor: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 19,
                          ),
                        ),
                        Padding(
                                padding: const EdgeInsets.only(left: 12,top: 15),
                                child: CustomText(
                                  textName: AppStrings.fatherName,
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.fathersNameController,
                                textCapitalization: true,
                                hintText: AppStrings.fatherName,
                                errorText: _controller.fathersNameError,
                                fillColor: AppColors.white,
                                filled: true,
                                prefixIcon: const Icon(Icons.person),
                                onChanged: (value) {
                                  _controller.validateInputs();
                                },
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.only(left: 12,top: 15),
                                child: CustomText(
                                  textName: AppStrings.panNumber,
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.panController,
                                hintText: AppStrings.panNumber,
                                textCapitalization: false,
                                prefixIcon: SvgPicture.asset(
                                  AppImages.panCardIcon,
                                  color: AppColors.darkGrey,
                                  height: 5,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter(
                                      RegExp("[A-Z0-9]"),
                                      allow: true)
                                ],
                                errorText: _controller.panError,
                                fillColor: AppColors.white,
                                filled: true,
                                onChanged: (value) {
                                  _controller.validateInputs();
                                },
                              ),
                             
                               Padding(
                                padding: const EdgeInsets.only(left: 12,top: 15),
                                child: CustomText(
                                  textName: AppStrings.mobileNumber,
                                  textColor: AppColors.white,
                                ),
                              ),
                        CustomTextField(
                          controller: _controller.phoneController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          errorText: !_controller.isPhoneValid
                              ? _controller.errorMessage
                              : null,
                          filled: true,
                          fillColor: AppColors.white,
                          prefixIcon: SvgPicture.asset(height: 0, AppImages.flagIcon),
                          hintText: AppStrings.mobileNumber,
                          prefixText: AppStrings.nineOne,
                        ),
                        SizedBox(height: Get.height * 0.04),
                        Container(
                          width: Get.width * 0.8,
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            color: AppColors.orangeLogoColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _controller.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: AppColors.black,
                                ))
                              : TextButton(
                                  onPressed: () {
                                    _controller.validateInputs();
                                          controller.update();
                                          if (_controller.fathersNameError ==
                                                  null &&
                                              _controller.panError == null ) {
                                                print("object");
                                            _controller.submitForm();
                                          }
                                    // _controller.submitForm();
                                  },
                                  child: CustomText(
                                    textName: AppStrings.sendOtp,
                                    textColor: AppColors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
