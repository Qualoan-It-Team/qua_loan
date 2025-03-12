
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/mobile_otp_controller.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';

class MobileOtpVerification extends StatelessWidget {
  MobileOtpVerification({super.key,});
  
  final _controller = Get.put(MobileOtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: AppColors.white,
      body: GetBuilder<MobileOtpController>(
        init: _controller,
        builder: (controller) {
          return Stack(
            children: [
              Center(
                child: Container(
                  width: Get.width * 0.9,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.darkGrey.withOpacity(0.8),
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
                        CustomText(
                          textName: AppStrings.otpVerification,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomText(
                          textName: "${AppStrings.otpEnterDescription}${_controller.mobileNumber}",
                          textColor: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15,
                          overflow: TextOverflow.fade,
                        ),
                        SizedBox(height: Get.height * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(6, (index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                width: 42,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(3, 7),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller:_controller.mobileOtpControllersList[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: InputDecoration(
                                    counterText: AppStrings.emptyString,
                                    border: InputBorder.none,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.orangeLogoColor),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (value.length == 1 && index < 5) {
                                      FocusScope.of(context).nextFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                    _controller.otp = _controller
                                        .mobileOtpControllersList
                                        .map((controller) => controller.text)
                                        .join('');
                                  },
                                  
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: Get.height * 0.05),
                         if (!_controller.isTimerExpired)
                          Column(
                            children: [
                              CustomText(
                                textName:
                                    "${AppStrings.otpExpireText} ${(_controller.remainingTime % 60).toString().padLeft(2, '0')} ${AppStrings.secText}",
                                fontSize: 16,
                                textColor: AppColors.white,
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: CircularProgressIndicator(
                                    value: 1.0 - (_controller.remainingTime / 60),
                                    strokeWidth: 6,
                                    color: AppColors.orangeLogoColor,
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ],
                          ),

                        if (_controller.isTimerExpired)
                          InkWell(
                            onTap: () {
                              _controller.reSendMobileOtp();
                            },
                            child: CustomText(
                              textName: AppStrings.reSendOtp,
                              textColor: AppColors.lightOrange,
                              fontSize: 16,
                            ),
                          ),
                        SizedBox(height: Get.height * 0.05),
                        Container(
                          width: Get.width * 0.8,
                          height: Get.height * 0.06,
                          decoration: BoxDecoration(
                            color: AppColors.lightOrange.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _controller.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: AppColors.black,
                                ))
                              : TextButton(
                                  onPressed: () {
                                    _controller.verifyMobileOtp();
                                      _controller.mobileOtpControllersList
                                          .map((controller) => controller.text)
                                          .join('');
                                       },
                                  child: CustomText(
                                    textName: AppStrings.verifyOtp,
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
      // ),
    );
  }
}
