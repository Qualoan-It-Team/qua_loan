// // ignore_for_file: prefer_const_constructors_in_immutables, deprecated_member_use
// ignore_for_file: deprecated_member_use

import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_strings.dart';
import 'package:app_here/controller/aadhaar_otp_controller.dart';
import 'package:app_here/reusable_widgets/custom_app_bar.dart';
import 'package:app_here/reusable_widgets/custom_button.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AadhaarOtpVerification extends StatelessWidget {
  AadhaarOtpVerification({super.key});
  // final _controller = Get.put(AadhaarOtpVerificationController());

  @override
  Widget build(BuildContext context) {
    // final String phoneNumber = Get.arguments;
    final _controller = Get.put(AadhaarOtpVerificationController());
    return Scaffold(
      appBar: CustomAppBar(
        leftPadding: 25,
        forceMaterialTransparency: true,
        title: AppStrings.verifyOtpText,
        height: Get.height * 0.2,
        icon: Icons.arrow_back_ios,
      ),
      body: GetBuilder<AadhaarOtpVerificationController>(
        init: AadhaarOtpVerificationController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomText(
                  textName:
                      "We have sent a temporary 6 digit OTP to your Mobile Number which is linked with your Aadhaar Card (otp valid for 10 mins). ",
                  textColor: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: TextField(
                    controller: _controller.aadhaarOtpController,
                    inputFormatters: [
                      // _controller.maskFormatter,
                      FilteringTextInputFormatter(RegExp("[0-9]"),
                          allow: true),
                      // FilteringTextInputFormatter
                      //     .digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    obscureText: !_controller.passwordVisible,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: AppColors.green),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: AppColors.logoRedColor),
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                        color: AppColors.black,
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _controller.passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          // color: Theme.of(context).primaryColorDark,s
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable

                          _controller.passwordVisible =
                              !_controller.passwordVisible;
                          _controller.update();
                        },
                      
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 15),
                  child: CustomText(
                    textName: "Wait few minutes for the OTP ,",
                    textColor: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    // textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25,
                  ),
                  child: CustomText(
                    textName: "do not refresh or close !",
                    height: 2,
                    textColor: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    // textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 70),
                  child: _controller.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.black,
                        ))
                      : CustomButton(
                          onPressed: () {
                            final otp =
                                _controller.aadhaarOtpController.text.trim();
                            if (otp.isNotEmpty) {
                              _controller
                                  .submitOtp(); // Call the submit OTP method
                            } else {
                              Get.snackbar(
                                backgroundColor: AppColors.logoRedColor,
                                colorText: Colors.white,
                                'Error',
                                  'Please enter the OTP'); // Show error if empty
                            }
                          },
                          textName: "Verify OTP",
                          color: AppColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.green,
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
