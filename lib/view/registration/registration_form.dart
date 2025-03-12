// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/registration_form_controller.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/routes/app_routes.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images&icons.dart';
import '../../reusable_widgets/custom_text_field.dart';

class RegistrationFormScreen extends StatelessWidget {
  RegistrationFormScreen({super.key});
  final _controller = Get.put(RegistrationFormController());
  @override
  Widget build(BuildContext context) {
    _controller.fetchDashboardDetails();
    _controller.fetchUserProfile();
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: GetBuilder<RegistrationFormController>(
              init: _controller,
              builder: (controller) {
                return SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: CustomText(
                          textName: AppStrings.registration,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.fade,
                          textColor: AppColors.darkGrey,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: CustomText(
                          textName: AppStrings.registrationThankYouDescription,
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          overflow: TextOverflow.fade,
                          textColor: AppColors.black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Center(
                          child: SizedBox(
                              height: Get.height * 0.3,
                              child: const Image(
                                  image:
                                      AssetImage(AppImages.registrationVideo))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 5, right: 5, top: Get.height * 0.01),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(Icons.check_circle,
                                      size: 30,
                                      color: _controller.isMobileVerify
                                          ? AppColors.green.withOpacity(0.7)
                                          : AppColors.white.withOpacity(0.8)),
                                )),
                            SizedBox(
                              width: Get.width * 0.05,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: controller.isMobileVerify
                                    ? null
                                    : () {
                                        Get.toNamed(MyAppRoutes
                                            .mobileNumberVerification);
                                      },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _controller.isMobileVerify
                                          ? AppColors.green.withOpacity(0.4)
                                          : AppColors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.darkGrey, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: CustomText(
                                            overflow: TextOverflow.fade,
                                            softWrap: true,
                                            height: 1.7,
                                            fontSize: 16,
                                            maxLines: 1,
                                            fontWeight: FontWeight.w400,
                                            textColor: AppColors.black,
                                            textName: AppStrings
                                                .mobileNumberVerificationText)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.06,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: VerticalDivider(
                            color: AppColors.darkGrey,
                            indent: 2,
                            endIndent: 2,
                            thickness: 4,
                          ),
                        ),
                      ),
                      //formFeilds
                      //  Padding(
                      //   padding: EdgeInsets.only(
                      //       left: 5, right: 5, top: Get.height * 0.01),
                      //   child: Row(
                      //     children: [
                      //       CircleAvatar(
                      //           radius: 22,
                      //           backgroundColor: AppColors.black,
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(2.0),
                      //             child: Icon(Icons.check_circle,
                      //                 size: 30,
                      //                 color: _controller.isFormFilled
                      //                     ? AppColors.green.withOpacity(0.7)
                      //                     : AppColors.white.withOpacity(0.8)),
                      //           )),
                      //       SizedBox(
                      //         width: Get.width * 0.05,
                      //       ),
                      //       Expanded(
                      //         child: InkWell(
                      //           onTap:controller.isFormFilled
                      //               ? null
                      //               : _controller.isMobileVerify
                      //                   ? () {
                      //                       Get.to(()=>BasicFormFields());
                      //                     }
                      //                   : () {
                      //                       showCustomSnackbar(AppStrings.error,
                      //                           AppStrings.basicFieldsStep,
                      //                           backgroundColor:
                      //                               AppColors.logoRedColor,
                      //                           textColor: AppColors.white);
                      //                     },
                      //           //  controller.isMobileVerify
                      //           //     ? null
                      //           //     : () {
                      //           //         Get.to(BasicFormFields());
                      //           //       },
                      //           child: Container(
                      //             decoration: BoxDecoration(
                      //                 color: _controller.isFormFilled
                      //                     ? AppColors.green.withOpacity(0.4)
                      //                     : AppColors.white.withOpacity(0.8),
                      //                 borderRadius: BorderRadius.circular(10),
                      //                 border: Border.all(
                      //                     color: AppColors.darkGrey, width: 2)),
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Center(
                      //                   child: CustomText(
                      //                       overflow: TextOverflow.fade,
                      //                       softWrap: true,
                      //                       height: 1.7,
                      //                       fontSize: 16,
                      //                       maxLines: 1,
                      //                       fontWeight: FontWeight.w400,
                      //                       textColor: AppColors.black,
                      //                       textName: AppStrings.basicFields)),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: Get.height * 0.06,
                      //   child: const Padding(
                      //     padding: EdgeInsets.only(left: 20),
                      //     child: VerticalDivider(
                      //       color: AppColors.darkGrey,
                      //       indent: 2,
                      //       endIndent: 2,
                      //       thickness: 4,
                      //     ),
                      //   ),
                      // ),

                      //pan verification
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(Icons.check_circle,
                                      size: 30,
                                      color: _controller.isPanVerify
                                          ? AppColors.green.withOpacity(0.7)
                                          : AppColors.white.withOpacity(0.8)),
                                )),
                            SizedBox(
                              width: Get.width * 0.05,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: controller.isPanVerify
                                    ? null
                                    : _controller.isMobileVerify
                                        ? () {
                                            showPanVerificationDialog(context);
                                            _controller.update();
                                          }
                                        : () {
                                            showCustomSnackbar(AppStrings.error,
                                                AppStrings.panVerficationStep,
                                                backgroundColor:
                                                    AppColors.logoRedColor,
                                                textColor: AppColors.white);
                                          },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _controller.isPanVerify
                                          ? AppColors.green.withOpacity(0.4)
                                          : AppColors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.darkGrey, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: CustomText(
                                          overflow: TextOverflow.fade,
                                          softWrap: true,
                                          height: 1.7,
                                          fontSize: 17,
                                          maxLines: 1,
                                          fontWeight: FontWeight.w400,
                                          textColor: AppColors.black,
                                          textName: AppStrings.panVerification),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: Get.height * 0.06,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: VerticalDivider(
                            color: AppColors.darkGrey,
                            indent: 2,
                            endIndent: 2,
                            thickness: 5,
                          ),
                        ),
                      ),
                      //personal information
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(Icons.check_circle,
                                      size: 30,
                                      color: _controller.isPersonalDetails
                                          ? AppColors.green.withOpacity(0.7)
                                          : AppColors.white.withOpacity(0.8)),
                                  // ),
                                )),
                            SizedBox(
                              width: Get.width * 0.05,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: controller.isPersonalDetails
                                    ? null
                                    : _controller.isPanVerify
                                        ? () {
                                            Get.toNamed(MyAppRoutes
                                                .personalInformation);
                                          }
                                        : () {
                                            showCustomSnackbar(
                                                AppStrings.error,
                                                AppStrings
                                                    .personalInformationStep,
                                                backgroundColor:
                                                    AppColors.logoRedColor,
                                                textColor: AppColors.white);
                                          },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _controller.isPersonalDetails
                                          ? AppColors.green.withOpacity(0.4)
                                          : AppColors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.darkGrey, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: CustomText(
                                            overflow: TextOverflow.fade,
                                            softWrap: true,
                                            height: 1.7,
                                            fontSize: 17,
                                            maxLines: 1,
                                            fontWeight: FontWeight.w400,
                                            textColor: AppColors.black,
                                            textName: AppStrings
                                                .personalInformation)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.06,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: VerticalDivider(
                            color: AppColors.darkGrey,
                            indent: 2,
                            endIndent: 2,
                            thickness: 4,
                          ),
                        ),
                      ),
                      //Address Information
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(Icons.check_circle,
                                      size: 30,
                                      color: _controller.isCurrentResidence
                                          ? AppColors.green.withOpacity(0.7)
                                          : AppColors.white.withOpacity(0.8)),
                                  // ),
                                )),
                            SizedBox(
                              width: Get.width * 0.05,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: controller.isCurrentResidence
                                    ? null
                                    : _controller.isPersonalDetails
                                        ? () {
                                            Get.toNamed(
                                                MyAppRoutes.addressInformation);
                                          }
                                        : () {
                                            showCustomSnackbar(
                                                AppStrings.error,
                                                AppStrings
                                                    .addressInformationStep,
                                                backgroundColor:
                                                    AppColors.logoRedColor,
                                                textColor: AppColors.white);
                                          },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _controller.isCurrentResidence
                                          ? AppColors.green.withOpacity(0.4)
                                          : AppColors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.darkGrey, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: CustomText(
                                          overflow: TextOverflow.fade,
                                          softWrap: true,
                                          height: 1.7,
                                          fontSize: 17,
                                          maxLines: 1,
                                          fontWeight: FontWeight.w400,
                                          textColor: AppColors.black,
                                          textName:
                                              AppStrings.addressInformation),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.06,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: VerticalDivider(
                            color: AppColors.darkGrey,
                            indent: 2,
                            endIndent: 2,
                            thickness: 4,
                          ),
                        ),
                      ),
                      //income information
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(Icons.check_circle,
                                      size: 30,
                                      color: _controller.isIncomDetails
                                          ? AppColors.green.withOpacity(0.7)
                                          : AppColors.white.withOpacity(0.8)),
                                )),
                            SizedBox(
                              width: Get.width * 0.05,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: controller.isIncomDetails
                                    ? null
                                    : _controller.isCurrentResidence
                                        ? () {
                                            Get.toNamed(
                                                MyAppRoutes.incomeInformation);
                                          }
                                        : () {
                                            showCustomSnackbar(
                                                AppStrings.error,
                                                AppStrings
                                                    .incomeInformationStep,
                                                backgroundColor:
                                                    AppColors.logoRedColor,
                                                textColor: AppColors.white);
                                          },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _controller.isIncomDetails
                                          ? AppColors.green.withOpacity(0.4)
                                          : AppColors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.darkGrey, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: CustomText(
                                          overflow: TextOverflow.fade,
                                          softWrap: true,
                                          height: 1.7,
                                          fontSize: 17,
                                          maxLines: 1,
                                          fontWeight: FontWeight.w400,
                                          textColor: AppColors.black,
                                          textName:
                                              AppStrings.incomeInformation),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: Get.height * 0.06,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: VerticalDivider(
                            color: AppColors.darkGrey,
                            indent: 2,
                            endIndent: 2,
                            thickness: 4,
                          ),
                        ),
                      ),
                      //upload selfie
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          children: [
                            CircleAvatar(
                                radius: 22,
                                backgroundColor: AppColors.black,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Icon(Icons.check_circle,
                                      size: 30,
                                      color: _controller.isProfileImage
                                          ? AppColors.green.withOpacity(0.7)
                                          : AppColors.white.withOpacity(0.8)),
                                )),
                            SizedBox(
                              width: Get.width * 0.05,
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: controller.isProfileImage
                                    ? null
                                    : _controller.isIncomDetails
                                        ? () {
                                            Get.toNamed(
                                                MyAppRoutes.uploadSelfie);
                                          }
                                        : () {
                                            showCustomSnackbar(
                                                AppStrings.error,
                                                AppStrings
                                                    .selfieVerificationStep,
                                                backgroundColor:
                                                    AppColors.logoRedColor,
                                                textColor: AppColors.white);
                                          },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: _controller.isProfileImage
                                          ? AppColors.green.withOpacity(0.4)
                                          : AppColors.white.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: AppColors.darkGrey, width: 2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: CustomText(
                                          overflow: TextOverflow.fade,
                                          softWrap: true,
                                          height: 1.7,
                                          fontSize: 17,
                                          maxLines: 1,
                                          fontWeight: FontWeight.w400,
                                          textColor: AppColors.black,
                                          textName:
                                              AppStrings.selfieVerification),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ]));
              },
            ),
          ),
        ]));
  }

//this dialoge to show pan dialouge
  void showPanVerificationDialog(BuildContext context) {
    // _controller.panController.clear();
    _controller.panError = null;
    Get.dialog(
      barrierDismissible: false,
      barrierColor: Colors.white.withOpacity(0.9),
      GetBuilder<RegistrationFormController>(
        init: _controller,
        builder: (controller) {
          return AlertDialog(
            backgroundColor: AppColors.black.withOpacity(0.7),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.white, width: 2),
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Center(
              child: CustomText(
                textName: AppStrings.panVerification,
                textColor: AppColors.white,
              ),
            ),
            content: SizedBox(
              height: Get.height * 0.25,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CustomText(
                      textName: AppStrings.panCardNumber,
                      textColor: AppColors.white,
                    ),
                  ),
                  CustomTextField(
                    textCapitalization: false,
                    controller: _controller.panController,
                    errorText: _controller.panError,
                    hintText: AppStrings.panNumber,
                    inputFormatters: [
                      FilteringTextInputFormatter(RegExp("[A-Z0-9]"),
                          allow: true)
                    ],
                    filled: true,
                    fillColor: AppColors.white.withOpacity(0.7),
                    prefixIcon: SvgPicture.asset(
                      AppImages.panCardIcon,
                      color: AppColors.orangeLogoColor,
                      height: 5,
                    ),
                    onChanged: (value) {
                      if (value.length == 10) {}
                      _controller.validateInputs();
                    },
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: CustomText(
                                textName: AppStrings.cancelText,
                                textColor: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _controller.validateInputs();
                            if (_controller.panError == null) {
                              controller.verifyPan();
                              _controller.update();
                            }
                            _controller.update();
                          },
                          child: controller.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                  color: AppColors.white,
                                ))
                              : Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.lightOrange.withOpacity(0.8),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      textName: AppStrings.verifyText,
                                      textColor: AppColors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
