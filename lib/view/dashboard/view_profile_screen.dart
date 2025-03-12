// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/loan_application/view_profile_controller.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/view/registration/address_information.dart';
import 'package:qualoan/view/registration/income_information.dart';
import '../../constants/app_colors.dart';
import '../../reusable_widgets/common_back_header.dart';

class ViewProfileScreen extends StatelessWidget {
  ViewProfileScreen({super.key});
  final _controller = Get.put(ViewProfileController());
  @override
  Widget build(BuildContext context) {
    _controller.fetchLoanApplicationDetails();
    _controller.fetchDocumentList();
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder<ViewProfileController>(
            init: _controller,
            builder: (controller) {
              return Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: Get.height * 0.1),
                child: SingleChildScrollView(
                  child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                          color: AppColors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 2,
                              ),
                              child: CustomText(
                                textName: AppStrings.userProfile,
                                textColor: AppColors.darkGrey,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20),
                                // width: Get.width * 0.65,
                                decoration: BoxDecoration(
                                    color: AppColors.lightOrange,
                                    border:
                                        Border.all(color: AppColors.darkGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 10, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Center(
                                      //   child: CircleAvatar(
                                      //       radius: 40,
                                      //       backgroundImage: _controller
                                      //               .isLoading
                                      //           ? const AssetImage(
                                      //                   AppImages.userImage)
                                      //               as ImageProvider
                                      //           : _controller
                                      //                           .userProfileResponse!
                                      //                           .data
                                      //                           .profileImage !=
                                      //                       null &&
                                      //                   _controller
                                      //                       .userProfileResponse!
                                      //                       .data
                                      //                       .profileImage!
                                      //                       .isNotEmpty
                                      //               ? NetworkImage(_controller
                                      //                   .userProfileResponse!
                                      //                   .data
                                      //                   .profileImage!)
                                      //               : const AssetImage(
                                      //                   AppImages.userImage)
                                      //                   ),
                                      // ),
                                      //new
                                      Center(
                                        child: CircleAvatar(
                                          radius: 40,
                                          backgroundImage: _controller.isLoading
                                              ? const AssetImage(
                                                      AppImages.userImage)
                                                  as ImageProvider
                                              : _controller
                                                              .userProfileResponse
                                                              ?.data
                                                              .profileImage !=
                                                          null &&
                                                      _controller
                                                          .userProfileResponse!
                                                          .data
                                                          .profileImage!
                                                          .isNotEmpty
                                                  ? NetworkImage(_controller
                                                      .userProfileResponse!
                                                      .data
                                                      .profileImage!)
                                                  : const AssetImage(
                                                      AppImages.userImage),
                                          child: _controller.isLoading
                                              ? const CircularProgressIndicator(color: AppColors.white,)
                                              : null,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: CustomText(
                                          textName: _controller.isLoading
                                              ? ""
                                              : _controller
                                                      .userProfileResponse
                                                      ?.data
                                                      .personalDetails
                                                      ?.fullName ??
                                                  "",
                                          textColor: AppColors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                    textName: "PAN Number:",
                                                    textColor: AppColors.white
                                                        .withOpacity(0.9),
                                                    fontSize: 15,
                                                    height: 1.5,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                CustomText(
                                                    textName: "Aadhaar Number:",
                                                    textColor: AppColors.white
                                                        .withOpacity(0.9),
                                                    fontSize: 15,
                                                    height: 1.5,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                CustomText(
                                                    textName: "Phone Number:",
                                                    textColor: AppColors.white
                                                        .withOpacity(0.9),
                                                    fontSize: 15,
                                                    height: 1.5,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  textName: _controller
                                                          .isLoading
                                                      ? ""
                                                      : _controller
                                                              .userProfileResponse
                                                              ?.data
                                                              .pan ??
                                                          "",
                                                  textColor: AppColors.white,
                                                  height: 1.5,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                CustomText(
                                                  textName: _controller
                                                          .isLoading
                                                      ? ""
                                                      : _controller
                                                              .userProfileResponse
                                                              ?.data
                                                              .aadhaarNumber ??
                                                          "",
                                                  textColor: AppColors.white,
                                                  fontSize: 13,
                                                  height: 2,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                                CustomText(
                                                  textName: _controller
                                                          .isLoading
                                                      ? ""
                                                      : _controller
                                                              .userProfileResponse
                                                              ?.data
                                                              .mobile ??
                                                          "",
                                                  textColor: AppColors.white,
                                                  fontSize: 13,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w300,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, bottom: 8),
                              child: CustomText(
                                textName: AppStrings.basicInformation,
                                textColor: AppColors.darkGrey,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.lightOrange,
                                  border: Border.all(color: AppColors.darkGrey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              textName: "Gender",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .personalDetails
                                                          ?.gender ??
                                                      "-",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "DOB",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller.formatDate( _controller.userProfileResponse
                                                          ?.data
                                                          .personalDetails
                                                          ?.dob.toString())
                                                  // _controller
                                                  //         .userProfileResponse
                                                  //         ?.data
                                                  //         .personalDetails
                                                  //         ?.dob 
                                                          ?? "-",
                                              height: 2,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "Email",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .personalDetails
                                                          ?.personalEmail ??
                                                      "-",
                                              height: 2,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "Mother's Name",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .personalDetails
                                                          ?.mothersName ??
                                                      "-",
                                              height: 2,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "Father's Name",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .personalDetails
                                                          ?.fathersName ??
                                                      "-",
                                              height: 2,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "Marital Status",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .personalDetails
                                                          ?.maritalStatus ??
                                                      "-",
                                              height: 2,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "Spause Name",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .personalDetails
                                                          ?.spouseName ??
                                                      "-",
                                              height: 1,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300)
                                        ],
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, bottom: 8),
                              child: CustomText(
                                textName: AppStrings.residenceAddress,
                                textColor: AppColors.darkGrey,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  // color: AppColors.darkGrey.withOpacity(0.8),
                                  color: AppColors.lightOrange,
                                  border: Border.all(color: AppColors.darkGrey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 10, top: 10, bottom: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "Address",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .residence
                                                          ?.address ??
                                                      "",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "Landmark",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .residence
                                                          ?.landmark ??
                                                      "",
                                              height: 2,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "Pincode",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .residence
                                                          ?.pincode ??
                                                      "",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "City",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .residence
                                                          ?.city ??
                                                      "",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "State",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .residence
                                                          ?.state ??
                                                      "",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "Residence Type",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .residence
                                                          ?.residenceType ??
                                                      "",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: "Residing Since",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? ""
                                                  : 
                                                  _controller.formatDate(
                                                    _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .residence
                                                          ?.residingSince
                                                          ) 
                                                          ??
                                                      "",
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: SizedBox(
                                          child: _controller.userProfileResponse
                                                      ?.data.residence ==
                                                  null
                                              ? const SizedBox(
                                                  height: 0,
                                                )
                                              : Container(
                                                  height: 40,
                                                  width: Get.width * 0.2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: AppColors.white),
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Get.to(
                                                            AddressInformation());
                                                      },
                                                      child: CustomText(
                                                        textName: "Edit",
                                                        textColor: AppColors
                                                            .lightOrange,
                                                      ))),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, bottom: 8),
                              child: CustomText(
                                textName: AppStrings.incomeInformation,
                                textColor: AppColors.darkGrey,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.lightOrange,
                                  border: Border.all(color: AppColors.darkGrey),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 10, top: 10, bottom: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName:
                                                  AppStrings.employementType,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? AppStrings.emptyString
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .incomeDetails
                                                          ?.employementType ??
                                                      AppStrings.emptyString,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName:
                                                  AppStrings.monthlyIncome,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? AppStrings.emptyString
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .incomeDetails
                                                          ?.monthlyIncome
                                                          .toString() ??
                                                      AppStrings.emptyString,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: AppStrings.obligation,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? AppStrings.emptyString
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .incomeDetails
                                                          ?.obligations
                                                          .toString() ??
                                                      AppStrings.emptyString,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName:
                                                  AppStrings.workingSinceDate,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? AppStrings.emptyString
                                                  : 
                                                  _controller.formatDate(_controller.userProfileResponse
                                                          ?.data
                                                          .incomeDetails
                                                          ?.workingSince.toString())
                                                          // .userProfileResponse
                                                          // ?.data
                                                          // .incomeDetails
                                                          // ?.workingSince
                                                           ??
                                                      AppStrings.emptyString,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName:
                                                  AppStrings.nextSalaryDate,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? AppStrings.emptyString
                                                  : _controller.formatDate(
                                                          _controller
                                                              .userProfileResponse
                                                              ?.data
                                                              .incomeDetails
                                                              ?.nextSalaryDate
                                                              .toString()) ??
                                                      AppStrings.emptyString,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                              textName: AppStrings.incomeMode,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                          CustomText(
                                              textName: _controller.isLoading
                                                  ? AppStrings.emptyString
                                                  : _controller
                                                          .userProfileResponse
                                                          ?.data
                                                          .incomeDetails
                                                          ?.incomeMode ??
                                                      AppStrings.emptyString,
                                              height: 1.5,
                                              textColor: AppColors.white
                                                  .withOpacity(0.9),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w300),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: SizedBox(
                                          child: _controller.userProfileResponse
                                                      ?.data.incomeDetails ==
                                                  null
                                              ? const SizedBox(
                                                  height: 0,
                                                )
                                              : Container(
                                                  height: 40,
                                                  width: Get.width * 0.2,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: AppColors.white),
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Get.to(
                                                            IncomeInformation());
                                                      },
                                                      child: CustomText(
                                                        textName: "Edit",
                                                        textColor: AppColors
                                                            .lightOrange,
                                                      ))),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 2, bottom: 8),
                              child: CustomText(
                                textName: AppStrings.loanDetails,
                                textColor: AppColors.darkGrey,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _controller.isLoading?
                              const Center(
                                  child: CircularProgressIndicator(
                                color: AppColors.white,
                              ))
                            // if (controller.isLoading)
                            //   const Center(
                            //       child: CircularProgressIndicator(
                            //     color: AppColors.white,
                            //   ))
                            // else if (controller.loanApplicationResponse == null)
                            //   CustomText(
                            //     textName: AppStrings.noLoanDetailsAvailable,
                            //     textColor: AppColors.lightOrange,
                            //     fontSize: 15,
                            //     fontWeight: FontWeight.bold,
                            //   )
                            // else
                              :Container(
                                decoration: BoxDecoration(
                                    color: AppColors.lightOrange,
                                    border:
                                        Border.all(color: AppColors.darkGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Loan Purpose",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.loanDetails
                                                            ?.loanPurpose ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Principal",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.loanDetails
                                                            ?.principal
                                                            .toString() ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Intrest/Month",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.loanDetails
                                                            ?.roi
                                                            .toString()
                                                            .trim() ??
                                                        "",
                                                height: 2,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Total Payble",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.loanDetails
                                                            ?.totalPayble
                                                            .toString() ??
                                                        "",
                                                height: 2,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Tenure (Days)",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.loanDetails
                                                            ?.tenure
                                                            .toString() ??
                                                        "",
                                                height: 2,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 2, bottom: 8, top: 20),
                              child: CustomText(
                                textName: AppStrings.employmentsDetails,
                                textColor: AppColors.darkGrey,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (controller.isLoading)
                              const CircularProgressIndicator()
                            else if (controller.loanApplicationResponse == null)
                              CustomText(
                                textName:
                                    AppStrings.noEmploymentsDetailsAvailable,
                                textColor: AppColors.lightOrange,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              )
                            else
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.lightOrange,
                                    border:
                                        Border.all(color: AppColors.darkGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Work From",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.workFrom ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Official Email",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.officeEmail ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Company Name",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.companyName ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Company Type",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.companyType ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Employed Since",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller.formatDate(_controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.employedSince.toString()) ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Designation",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.designation ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Office Addrress",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.officeAddrress ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Landmark",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.landmark ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "City",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.city ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "State",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.state ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: "Pincode",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? ""
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.employeeDetails
                                                            ?.pincode ??
                                                        "",
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 2, bottom: 8, top: 20),
                              child: CustomText(
                                textName: AppStrings.disbursalBankDetails,
                                textColor: AppColors.darkGrey,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (controller.isLoading)
                              const Center(child: CircularProgressIndicator())
                            else if (controller.loanApplicationResponse == null)
                              CustomText(
                                textName: AppStrings.noBankDetailsAvailable,
                                textColor: AppColors.lightOrange,
                                fontSize: 15,
                                overflow: TextOverflow.fade,
                                fontWeight: FontWeight.bold,
                              )
                            else
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.lightOrange,
                                    border:
                                        Border.all(color: AppColors.darkGrey),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15,
                                        right: 10,
                                        top: 10,
                                        bottom: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: AppStrings.bankName,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? AppStrings.emptyString
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.disbursalBankDetails
                                                            ?.bankName ??
                                                        AppStrings.emptyString,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName:
                                                    AppStrings.accountNumber,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? AppStrings.emptyString
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.disbursalBankDetails
                                                            ?.accountNumber ??
                                                        AppStrings.emptyString,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: AppStrings.ifscCode,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? AppStrings.emptyString
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.disbursalBankDetails
                                                            ?.ifscCode ??
                                                        AppStrings.emptyString,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName:
                                                    AppStrings.accountType,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? AppStrings.emptyString
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.disbursalBankDetails
                                                            ?.accountType ??
                                                        AppStrings.emptyString,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName: AppStrings.branchName,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? AppStrings.emptyString
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.disbursalBankDetails
                                                            ?.branchName ??
                                                        AppStrings.emptyString,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                                textName:
                                                    AppStrings.beneficiaryName,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            CustomText(
                                                textName: _controller.isLoading
                                                    ? AppStrings.emptyString
                                                    : _controller
                                                            .loanApplicationResponse
                                                            ?.data
                                                            ?.disbursalBankDetails
                                                            ?.beneficiaryName ??
                                                        AppStrings.emptyString,
                                                height: 1.5,
                                                textColor: AppColors.white
                                                    .withOpacity(0.9),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 2, bottom: 8, top: 20),
                              child: CustomText(
                                textName: AppStrings.previewDocuments,
                                textColor: AppColors.darkGrey,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              child: _controller
                                          .docTypeId?.documents?.isNotEmpty ??
                                      false
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.lightOrange,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                textName:
                                                    AppStrings.documentsName,
                                                textColor: AppColors.white,
                                                fontSize: 17,
                                                height: 2,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemCount: _controller.docTypeId
                                                    ?.documents?.length,
                                                // itemCount: 1,
                                                itemBuilder: (context, index) {
                                                  final document = _controller
                                                      .docTypeId
                                                      ?.documents?[index];
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5, right: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await _controller
                                                                .previewDocument(
                                                              document!.type
                                                                  .toString(),
                                                              document.id
                                                                  .toString(),
                                                            );
                                                          },
                                                          child: CustomText(
                                                            textName: document
                                                                    ?.name ??
                                                                AppStrings
                                                                    .emptyString,
                                                            textColor:
                                                                AppColors.white,
                                                            fontSize: 15,
                                                            height: 2,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          )))
                                  : CustomText(
                                      textName: AppStrings.noDocumentsAvailable,
                                      textColor: AppColors.lightOrange,
                                      fontSize: 15,
                                      height: 2,
                                      fontWeight: FontWeight.w400,
                                    ),
                            ),
                            const SizedBox(height: 10)
                          ],
                        ),
                      )),
                ),
              );
            },
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CommonBackHeader(),
          ),
        ],
      ),
    );
  }
}
