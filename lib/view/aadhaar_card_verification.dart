import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_images&icons.dart';
import 'package:app_here/reusable_widgets/custom_app_bar.dart';
import 'package:app_here/reusable_widgets/custom_button.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:app_here/reusable_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../controller/aadhaar_verification_controller.dart';

class AadhaarVerificationSCreen extends StatelessWidget { AadhaarVerificationSCreen({super.key});
final _controller = Get.put(AadhaarVerificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          leftPadding: 25,
          height: Get.height * 0.2,
          title: "Aadhaar Verification"),
      body: GetBuilder<AadhaarVerificationController>(
        init: _controller,
        builder: (controller) {
          return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              children: [
                CustomText(
                    textName: "Please authorise verification of your Aadhaar card from otp",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                    fontSize: 18),
                const SizedBox(
                  height: 40,
                ),
                SvgPicture.asset(
                  AppImages.aadhaarLogo,
                  height: 80,
                ),
                const SizedBox(height: 50),
               CustomTextField(
                  controller:_controller.aadhaarController,
                  inputFormatters: [
                      // _controller.maskFormatter,
                      FilteringTextInputFormatter(RegExp("[0-9]"),
                          allow: true),
                      // FilteringTextInputFormatter
                      //     .digitsOnly,
                      LengthLimitingTextInputFormatter(12),
                    ],
                  labelText: "Aadhaar Number ",
                  hintText: "Enter Aadhaar Number ",
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 50,
                ),
                if (_controller.isLoading) 
                const CircularProgressIndicator(color: AppColors.black,)
               else
                CustomButton(
                  onPressed: () {
                    final aadhaarNumber = _controller.aadhaarController.text.trim(); // Get the Aadhaar number input
                    if (aadhaarNumber.isNotEmpty) {
                      _controller.verifyAadhaar(); // Call the verification method
                    } else {
                      Get.snackbar(
                        backgroundColor: AppColors.logoRedColor,
                        colorText: Colors.white,
                        'Error', 'Please enter Aadhaar Number'); 
                    }
                  },
                  textName: "Next",
                  color: AppColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textColor: AppColors.green,
                ),
              ],
            ),
        
          ),
        );
        },
      ),
    );
  }
}
