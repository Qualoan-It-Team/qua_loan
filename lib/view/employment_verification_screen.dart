import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/controller/employment_verification_controller.dart';
import 'package:app_here/reusable_widgets/custom_app_bar.dart';
import 'package:app_here/reusable_widgets/custom_button.dart';
import 'package:app_here/reusable_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/app_images&icons.dart';
import '../reusable_widgets/custom_text.dart';

class EmploymentVerificationScreen extends StatelessWidget {
  EmploymentVerificationScreen({super.key});

  final _controller = Get.put(EmploymentVerificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: Get.height * 0.2,
        title: "Employer Verification",
        leftPadding: 25,
        icon: Icons.arrow_back_ios,
      ),
      body: SingleChildScrollView(
          child: GetBuilder<EmploymentVerificationController>(
        init: _controller,
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CustomText(
                      textName: "Congratulations !",
                      fontSize: 25,
                      textColor: AppColors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CustomText(
                      textName: "You are eligible for loan !",
                      fontSize: 15,
                      textColor: Colors.black,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CustomText(
                      textName:
                          "let's know some bit about where you work and your employer",
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      height: 1.5,
                      fontSize: 15,
                      textColor: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    labelText: "Employer Name",
                    textCapitalization: true,
                    controller: _controller.employerNameController,
                    errorText: _controller.employerNameError,
                    prefixIcon: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppImages.personIcon,
                            height: 15,
                          ),
                        ),  
                    keyboardType: TextInputType.name,
                    onChanged: (value) {
                      _controller.validateFields();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _controller.designationController,
                    keyboardType: TextInputType.name,
                    labelText: "Designation",
                    prefixIcon:  Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppImages.designationIcon,
                            height: 15,
                          ),
                        ),  
                    errorText: _controller.designationError,
                    textCapitalization: true,
                    onChanged: (value) {
                      _controller.validateFields();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _controller.officeAddressController,
                    labelText: "Current Office Address",
                    textCapitalization: true,
                    keyboardType: TextInputType.name,
                    prefixIcon: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppImages.officeAddressIcon,
                            height: 15,
                          ),
                        ),
                    errorText: _controller.officeAddressError,
                    onChanged: (value) {
                      _controller.validateFields();
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _controller.emailController,
                    labelText: "Employer Email",
                    textCapitalization: true,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(
                      Icons.email,
                      color: AppColors.green,
                    ),
                    errorText: _controller.emailError,
                    onChanged: (value) {
                      _controller.validateFields();
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    controller: _controller.employerPinCodeController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      // _controller.maskFormatter,
                      FilteringTextInputFormatter(RegExp("[0-9]"), allow: true),
                      // FilteringTextInputFormatter
                      //     .digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    errorText: _controller.pinCodeError,
                    labelText: "Pin Code",
                    prefixIcon:Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppImages.pincodeIcon,
                            height: 15,
                          ),
                        ),  
                    onChanged: (value) {
                      _controller.validateFields();
                    },
                  ),
                  // const SizedBox(height: 20,),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 40, right: 15, left: 15),
                    child: CustomButton(
                        onPressed: () {
                          _controller
                              .validateFields(); 
                          if (_controller.isValid) {
                            _controller.submitEmploymentDetails();
                          
                          } else {
                            Get.snackbar(
                                colorText: Colors.white,
                                backgroundColor: AppColors.logoRedColor,
                                "Validation Error",
                                "Please fill in all fields correctly.");
                          }
                        },
                        textName: "Continue",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        textColor: AppColors.green,
                        color: AppColors.black),
                  )
                ]),
          );
        },
      )),
    );
  }
}
