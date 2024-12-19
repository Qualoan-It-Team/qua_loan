// // ignore_for_file: prefer_const_constructors_in_immutables, deprecated_member_use
// ignore_for_file: deprecated_member_use

import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_strings.dart';
import 'package:app_here/controller/login_otp_controller.dart';
import 'package:app_here/reusable_widgets/custom_app_bar.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class LoginOtpScreen extends StatelessWidget {
  LoginOtpScreen({super.key});

  final _controller = Get.put(LoginOtpController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          leftPadding: 25,
          forceMaterialTransparency: true,
          title: AppStrings.verifyOtpText,
          height: Get.height * 0.2,
          icon: Icons.arrow_back_ios,
        ),
        body: GetBuilder(
          init: LoginOtpController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomText(
                    textName: AppStrings.fourDigitOtp,
                    textColor: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  CustomText(
                    textName: "+91-${_controller.phoneNumber}",
                    textColor: AppColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: TextField(
                          controller: _controller.otpControllers[index],
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter(RegExp("[0-9]"),
                                allow: true)
                          ],
                          textAlign: TextAlign.center,
                          maxLength: 1, // Limit to one character
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  color: AppColors.black,
                                  width: 1,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                color: AppColors.green,
                                width: 1,
                              ),
                            ),
                            counterText: "", // Hide the counter text
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            // Move to the next field when a character is entered
                            if (value.length == 1 && index < 3) {
                              FocusScope.of(context).nextFocus();
                            }
                            // Update the overall OTP value
                            _controller.otp = _controller.otpControllers
                                .map((controller) => controller.text)
                                .join('');
                          },
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: Get.height * 0.15,
                  ),
                  if (!_controller.isTimerExpired)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          // textName: "OTP will expire in ${_controller.remainingTime.toString().padLeft(2, '0')} seconds",
                          textName: "OTP will expire in ${_controller.remainingTime ~/ 60}:${(_controller.remainingTime % 60).toString().padLeft(2, '0')} minutes",
                          fontSize: 16,
                        ),
                        const SizedBox(height: 20),
                        CircularProgressIndicator(
                          value: _controller.remainingTime / 600,
                          strokeWidth: 5,
                          color: AppColors.green,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ],
                    ),

                  if (_controller.isTimerExpired)
                    InkWell(
                      onTap: () {
                        _controller
                            .resendOtp(_controller.phoneNumber.toString());
                      },
                      child: CustomText(
                        textName: AppStrings.reSendOtp,
                        textColor: AppColors.logoRedColor,
                        fontSize: 16,
                      ),
                    ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.green, width: 2),
                          borderRadius: BorderRadius.circular(8)),
                      height: Get.height * 0.06,
                      width: Get.width * 0.4,
                      child: FloatingActionButton(
                          hoverColor: AppColors.green,
                          elevation: 15,
                          onPressed: () {
                            String otp = _controller.otpControllers
                                .map((controller) => controller.text)
                                .join('');
                            _controller.verifyMobileOtp(
                                _controller.phoneNumber.toString(), otp);
                          },
                          backgroundColor: AppColors.black,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: CustomText(
                            textName: "Verify OTP",
                            textColor: AppColors.green,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          )),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
