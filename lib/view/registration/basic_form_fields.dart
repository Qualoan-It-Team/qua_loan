// ignore_for_file: must_be_immutable, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/basic_form_controller.dart';
import 'package:qualoan/reusable_widgets/custom_button.dart';
import 'package:qualoan/reusable_widgets/custom_text_field.dart';
import '../../reusable_widgets/common_back_header.dart';
import '../../reusable_widgets/custom_text.dart';

class BasicFormFields extends StatelessWidget {
  BasicFormFields({super.key});

  final _controller = Get.put(BasicFormController());

//  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(children: [
        const Positioned(top: 0, left: 0, right: 0, child: CommonBackHeader()),
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.2),
          child: GetBuilder<BasicFormController>(
            init: _controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: CustomText(
                    textName: AppStrings.basicInformationCapitalized,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          decoration: BoxDecoration(
                              color: AppColors.darkGrey.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: CustomText(
                                  textName: AppStrings.yourName,
                                  textColor: AppColors.white,
                                ),
                              ),
                              SizedBox(
                                child: _controller.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.white,
                                      ))
                                    : CustomTextField(
                                        controller:
                                            _controller.fullNameController,
                                        hintText: AppStrings.fullName,
                                        enabled: false,
                                        filled: true,
                                        errorText: _controller.fullNameError,
                                        fillColor: AppColors.white,
                                        prefixIcon: const Icon(Icons.person),
                                        onChanged: (value) {
                                          _controller.validateInputs();
                                        },
                                      ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: CustomText(
                                  textName: AppStrings.mobileNumber,
                                  textColor: AppColors.white,
                                ),
                              ),
                              SizedBox(
                                child: _controller.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.white,
                                      ))
                                    : CustomTextField(
                                        controller:
                                            _controller.mobileNumberController,
                                        hintText: AppStrings.mobileNumber,
                                        enabled: false,
                                        filled: true,
                                        errorText: _controller.mobileError,
                                        fillColor: AppColors.white,
                                        prefixIcon: const Icon(Icons.phone),
                                        onChanged: (value) {
                                          _controller.validateInputs();
                                        },
                                      ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
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
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
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
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 50),
                                child: _controller.isLoadingButton
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      )
                                    : CustomButton(
                                        onPressed: () {
                                          _controller.validateInputs();
                                          controller.update();
                                          if (_controller.fullNameError ==
                                                  null &&
                                              _controller.mobileError == null &&
                                              _controller.fathersNameError ==
                                                  null &&
                                              _controller.panError==null) {
                                                print("object");
                                            _controller.updatePersonalInfo();
                                          }
                                        },
                                        textName: AppStrings.submit,
                                        fontSize: 17,
                                        color: AppColors.lightOrange
                                            .withOpacity(0.9),
                                        textColor: AppColors.white,
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}
