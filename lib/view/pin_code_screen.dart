
import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/reusable_widgets/custom_app_bar.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:app_here/reusable_widgets/custom_text_field.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/pincode_screen_controller.dart';
import '../reusable_widgets/custom_button.dart';

class PinCodeScreen extends StatelessWidget {
   PinCodeScreen({super.key});
final PinCodeController controller = Get.put(PinCodeController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        height: Get.height * 0.23,
        forceMaterialTransparency: true,
        leftPadding: 25,
        icon: Icons.arrow_back_ios,
        title: "Verify your location",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: CustomText(
                textName:
                    "First thing first,\nlet's confirm whether we're operational at your location.",
                textColor: AppColors.black,
                fontSize: 15,
                overflow: TextOverflow.fade,
                maxLines: 3,
                softWrap: true,
              ),
            ),
            const SizedBox(height: 30),
            CustomText(
              textName: "Resident Pincode",
              textColor: Colors.grey,
              fontSize: 16,
              overflow: TextOverflow.fade ,
              maxLines: 3,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
             const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(6, (index) {
                return Container(
                  width: 40,
                  height: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: TextField(
                    focusNode: controller.focusNodes[index],
                    controller: controller.otpControllers[index],
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp("[0-9]"),allow: true)
                    ],
                    keyboardType: TextInputType.number,
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
                      controller.onOtpChanged(value, index);
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: CustomText(
                textName:
                    "Enter Pincode of your Present residence address when different from your aadhaar address.",
                textColor: AppColors.logoRedColor,
                fontSize: 13,
                overflow: TextOverflow.fade,
                maxLines: 3,
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 30),
              child: CustomTextField(
                controller: controller.cityController,
                labelText: "City",
                enabled: false,
                readOnly: true,
                filled: true,
                fillColor: const Color.fromARGB(255, 239, 237, 237),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
              child: CustomTextField(
                controller: controller.stateController,
                enabled: false,
                labelText: "State",
                readOnly: true,
                filled: true,
                fillColor: const Color.fromARGB(255, 239, 237, 237),
              ),
            ),
            const SizedBox(height: 50),
            Obx(() {
              return controller.isLoading.value
                  ? const CircularProgressIndicator(
                      color: AppColors.black,
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: CustomButton(
                        onPressed: () {
                          if (controller.isPincodeComplete() && 
                  controller.cityController.text.isNotEmpty && 
                  controller.stateController.text.isNotEmpty) {
                String pincode = controller.otpControllers
                    .map((controller) => controller.text)
                    .join('');
                controller.fetchLocation(pincode);
                Get.toNamed(MyAppRoutes.panKycVerificationScreen);
                print("Pincode========>$pincode");
                          }
                        },
                        textName: "Continue",
                        fontSize: 18,
                        color: controller.isPincodeComplete()
                            ? AppColors.black
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                        textColor: controller.isPincodeComplete()
                            ? AppColors.green
                            : AppColors.black,
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}