// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/reusable_widgets/custom_button.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/view/dashboard/show_loan_details.dart';
import '../../controller/dashboard_controller/loan_status_controller.dart';

class LoanStatus extends StatelessWidget {
  LoanStatus({super.key});
  final _controller = Get.put(LoanStatusController());

  @override
  Widget build(BuildContext context) {
    _controller.getLoanStatus();
    _controller.fetchDashboardDetails();
    return Scaffold(
        backgroundColor: AppColors.lightOrange.withOpacity(0.8),
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.08, right: 10),
            child: GetBuilder<LoanStatusController>(
                init: _controller,
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                              child: CustomText(
                            textName: AppStrings.loanApplicationProgress,
                            textColor: AppColors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 50),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 15,
                                    backgroundColor: _controller
                                                    .applicationUnderProcess ==
                                                "REJECTED" &&
                                            _controller.isLoanApply == true
                                        ? AppColors.white
                                        : AppColors.darkGrey.withOpacity(0.9),
                                    child: _controller
                                                    .applicationUnderProcess ==
                                                "REJECTED" &&
                                            _controller.isLoanApply == true
                                        ? const Icon(
                                            Icons.close,
                                            color: AppColors.logoRedColor,
                                          )
                                        : Icon(
                                            Icons.check_circle,
                                            color: _controller
                                                            .applicationUnderProcess ==
                                                        "PENDING" &&
                                                    _controller.isLoanApply ==
                                                        true
                                                ? AppColors.white
                                                : _controller.applicationUnderProcess ==
                                                            "SUCCESS" &&
                                                        _controller
                                                                .isLoanApply ==
                                                            true
                                                    ? Colors.green
                                                        .withOpacity(0.9)
                                                    : AppColors.white,
                                          )),
                                SizedBox(
                                  width: Get.width * 0.035,
                                ),
                                CustomText(
                                  textName: _controller
                                                  .applicationUnderProcess ==
                                              "PENDING" &&
                                          _controller.isLoanApply == true
                                      ? "Application Underprocess"
                                      : _controller.applicationUnderProcess ==
                                                  "REJECTED" &&
                                              _controller.isLoanApply == true
                                          ? "Application Rejected"
                                          : _controller.applicationUnderProcess ==
                                                      "SUCCESS" &&
                                                  _controller.isLoanApply ==
                                                      true
                                              ? "Application Under Process"
                                              : " Loan Application ",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColors.darkGrey,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 18,
                                ),
                                child: SizedBox(
                                  height: Get.height * 0.17,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: VerticalDivider(
                                      color: AppColors.white,
                                      indent: 2,
                                      endIndent: 2,
                                      thickness: 2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                  width: Get.width * 0.7,
                                  child: CustomText(
                                      overflow: TextOverflow.fade,
                                      textColor: AppColors.white,
                                      fontWeight: FontWeight.w300,
                                      textName: _controller
                                                  .applicationUnderProcess ==
                                              "REJECTED"
                                          ? "Thank you for your loan application with QUA Loan. After review, we regret to inform you that it does not meet our current eligibility criteria.We appreciate your interest and encourage you to apply again in the future if your circumstances change."
                                          : ""))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      _controller.applicationSenction ==
                                                  "REJECTED" &&
                                              _controller.isLoanApply == true
                                          ? AppColors.white
                                          : AppColors.darkGrey.withOpacity(0.9),
                                  child: _controller.applicationSenction ==
                                              "REJECTED" &&
                                          _controller.isLoanApply == true
                                      ? const Icon(
                                          Icons.close,
                                          color: AppColors.logoRedColor,
                                        )
                                      : Icon(Icons.check_circle,
                                          color: _controller
                                                          .applicationSenction ==
                                                      "PENDING" &&
                                                  _controller.isLoanApply ==
                                                      true
                                              ? AppColors.white
                                              : _controller.applicationSenction ==
                                                          "SUCCESS" &&
                                                      _controller.isLoanApply ==
                                                          true
                                                  ? Colors.green
                                                      .withOpacity(0.9)
                                                  : AppColors.white),
                                  // Text(
                                  //   AppStrings.two,
                                  //   style: TextStyle(color: Colors.black),
                                  // ),
                                ),
                                SizedBox(
                                  width: Get.width * 0.025,
                                ),
                                CustomText(
                                  textName: _controller.applicationSenction ==
                                              "PENDING" &&
                                          _controller.isLoanApply == true
                                      ? "Sanction Pending"
                                      : _controller.applicationSenction ==
                                                  "REJECTED" &&
                                              _controller.isLoanApply == true
                                          ? " Sanction Rejected"
                                          : _controller.applicationSenction ==
                                                      "SUCCESS" &&
                                                  _controller.isLoanApply ==
                                                      true
                                              ? "Sanctioned"
                                              : " Sanction Pending",
                                  // "Application Sanction",
                                  // textName: AppStrings.screening,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColors.darkGrey,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 18,
                                ),
                                child: SizedBox(
                                  height: Get.height * 0.17,
                                  child: const Padding(
                                    padding: EdgeInsets.only(left: 8),
                                    child: VerticalDivider(
                                      color: AppColors.white,
                                      indent: 2,
                                      endIndent: 2,
                                      thickness: 2,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                width: Get.width * 0.7,
                                child: CustomText(
                                    overflow: TextOverflow.fade,
                                    textColor: AppColors.white,
                                    fontWeight: FontWeight.w300,
                                    textName: _controller.applicationSenction ==
                                            "REJECTED"
                                        ? "Thank you for your loan application with QUA Loan. After review, we regret to inform you that it does not meet our current eligibility criteria.We appreciate your interest and encourage you to apply again in the future if your circumstances change."
                                        : ""),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      _controller.applicationDisbursed ==
                                                  "REJECTED" &&
                                              _controller.isLoanApply == true
                                          ? AppColors.white
                                          : AppColors.darkGrey.withOpacity(0.9),
                                  child: _controller.applicationDisbursed ==
                                              "REJECTED" &&
                                          _controller.isLoanApply == true
                                      ? const Icon(
                                          Icons.close,
                                          color: AppColors.logoRedColor,
                                        )
                                      : Icon(Icons.check_circle,
                                          color: _controller
                                                          .applicationDisbursed ==
                                                      "PENDING" &&
                                                  _controller.isLoanApply ==
                                                      true
                                              ? AppColors.white
                                              : _controller.applicationDisbursed ==
                                                          "SUCCESS" &&
                                                      _controller.isLoanApply ==
                                                          true
                                                  ? Colors.green
                                                      .withOpacity(0.9)
                                                  : AppColors.white),
                                ),
                                SizedBox(
                                  width: Get.width * 0.035,
                                ),
                                CustomText(
                                  textName: _controller.applicationDisbursed ==
                                              "PENDING" &&
                                          _controller.isLoanApply == true
                                      ? "Disburse Pending"
                                      : _controller.applicationDisbursed ==
                                                  "REJECTED" &&
                                              _controller.isLoanApply == true
                                          ? "Disburse Rejected"
                                          : _controller.applicationDisbursed ==
                                                      "SUCCESS" &&
                                                  _controller.isLoanApply ==
                                                      true
                                              ? " Disbursed"
                                              : "Disburs Pending",
                                  // "Application Disbursed",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColors.darkGrey,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 50, right: 50, top: 30),
                            child: SizedBox(
                              width: double
                                  .infinity, 
                              child:_controller.applicationDisbursed=="SUCCESS" && _controller.isLoanApply==true?  CustomButton(
                                onPressed: () {
                                  Get.to(ShowLoanDetails());
                                },
                                textName: AppStrings.repayText,
                                color: AppColors.white,
                                textColor: AppColors.lightOrange,
                                fontSize: 16,
                              ):SizedBox()
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                                left: Get.height * 0.082,
                                right: 10,
                                bottom: 15),
                            child: SizedBox(
                                width: Get.width * 0.7,
                                child: CustomText(
                                    overflow: TextOverflow.fade,
                                    textColor: AppColors.white,
                                    fontWeight: FontWeight.w300,
                                    textName: _controller
                                                .applicationDisbursed ==
                                            "REJECTED"
                                        ? "Thank you for your loan application with QUA Loan. After review, we regret to inform you that it does not meet our current eligibility criteria.We appreciate your interest and encourage you to apply again in the future if your circumstances change."
                                        : "")),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(25),
                          //   child: CustomButton(onPressed: (){
                          //     Get.toNamed(MyAppRoutes.loanApplication);
                          //   }, textName: "Go to loan Application", color: AppColors.white,textColor: AppColors.lightOrange,fontSize: 16,),
                          // )
                        ]),
                  );
                }),
          )
        ]));
  }
}
