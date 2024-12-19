// ignore_for_file: deprecated_member_use

import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_images&icons.dart';
import 'package:app_here/constants/app_strings.dart';
import 'package:app_here/controller/login_screen_controller.dart';
import 'package:app_here/reusable_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import '../reusable_widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final _controller = Get.put(LoginScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
          body: GetBuilder<LoginScreenController>(
        init: LoginScreenController(),
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.43,
                  width: Get.width,
                  decoration: const BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60)),
                      border: Border(
                          bottom:
                              BorderSide(color: AppColors.black, width: 10)),
                      image: DecorationImage(
                          image: AssetImage(AppImages.welcomeSalary4sureText))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 50),
                  child: CustomTextField(
                    controller: _controller.phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      // _controller.maskFormatter,
                      FilteringTextInputFormatter(RegExp("[0-9]"),
                          allow: true),
                      // FilteringTextInputFormatter
                      //     .digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    errorText: !_controller.isPhoneValid
                        ? _controller.errorMessage
                        : null,
                    prefixIcon: SvgPicture.asset(height: 0, AppImages.flagIcon),
                    labelText: AppStrings.mobileNumber,
                    prefixText: "+91",
                  ),
                ),
                SizedBox(height: Get.height * 0.2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      activeColor: Colors.green,
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
                              style: TextStyle(color: AppColors.black)),
                          TextSpan(
                            text: AppStrings.tAndctext,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _controller.openWebPage(
                                    "https://salary4sure.com/terms-and-conditions.php");
                              },
                          ),
                          const TextSpan(
                              text: AppStrings.andText,
                              style: TextStyle(color: AppColors.black)),
                          TextSpan(
                            text: AppStrings.privacyText,
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              _controller.openWebPage(
                                    "https://salary4sure.com/privacy-policy.php");
                            },
                          ),
                          const TextSpan(
                              text: AppStrings.applicationText,
                              style: TextStyle(color: AppColors.black)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 45, right: 45),
                  child: _controller.isLoading? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.black,
                        )) :CustomButton(
                    onPressed: () {
                      _controller.isTermsAccepted
                          ? _controller.submitForm()
                          
                          : null;
                    },
                    textName: AppStrings.login,
                    fontSize: 18,
                    color: _controller.isTermsAccepted
                        ? AppColors.black
                        : const Color.fromARGB(255, 214, 214, 214),
                    fontWeight: FontWeight.bold,
                    textColor: _controller.isTermsAccepted? AppColors.green:Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
