// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/loan_application/loan_calculator_controller.dart';
import 'package:qualoan/reusable_widgets/common_back_header.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/view/dashboard/common_drawer.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/reusable_widgets/custom_text_field.dart';
import '../../reusable_widgets/custom_button.dart';

class LoanCalculator extends StatelessWidget {
  final GlobalKey<ScaffoldState> calculatorScaffoldKey =
      GlobalKey<ScaffoldState>();
  LoanCalculator({super.key});

  final _controller = Get.put(LoanCalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        key: calculatorScaffoldKey,
        drawer: CommonDrawer(),
        body: Stack(children: [
          const CommonBackHeader(),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.15),
            child: GetBuilder<LoanCalculatorController>(
              init: _controller,
              builder: (controller) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      Center(
                          child: CustomText(
                              textColor: AppColors.darkGrey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              textName: "LOAN CALCULATOR")),
                      Center(
                        child: SizedBox(
                            height: Get.height * 0.3,
                            child: const Image(
                                image: AssetImage(AppImages.calculatorVideo))),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 25, left: 25),
                        child: CustomText(
                            textColor: AppColors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.fade,
                            textName: AppStrings.loanDes),
                      ),
                      //
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 25, left: 25, top: 20),
                        child: CustomText(
                            textColor: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w300,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.fade,
                            textName:
                                "Experience fast approvals and easy repayments with flexible terms"),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 76, 76, 76),
                                spreadRadius: 0.5,
                                blurRadius: 3,
                                offset: Offset(0, 1),
                              ),
                            ],
                            color: AppColors.darkGrey,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15, right: 5, left: 5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 15, bottom: 8),
                                    child: CustomText(
                                        textColor: AppColors.white,
                                        textName: "Purpose of Loan"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: SizedBox(
                                      height: 55,
                                      child: DropdownButtonFormField<String>(
                                        dropdownColor: AppColors.white,
                                        value:
                                            _controller.selectedLoanPurposeType,
                                        decoration: InputDecoration(
                                            fillColor:
                                                Colors.white.withOpacity(0.8),
                                            filled: true,
                                            hintText: AppStrings.select,
                                            labelStyle: const TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: _controller
                                                              .loanPurposeError !=
                                                          null
                                                      ? AppColors.logoRedColor
                                                      : AppColors.black,
                                                  width: 1),
                                            )),
                                        items: _controller.loanPurposeList
                                            .map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        selectedItemBuilder:
                                            (BuildContext context) {
                                          return _controller.loanPurposeList
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            );
                                          }).toList();
                                        },
                                        onChanged: (String? newValue) {
                                          _controller.selectedLoanPurposeType =
                                              newValue;
                                          // old but right code
                                          if (newValue != null) {
                                            _controller.loanPurposeError = null;
                                          }
                                          //new code
                                          // if (newValue != null) {
                                          //   _controller.loanPurposeError = null;
                                          //   if (newValue == "OTHERS") {
                                          //     // Show remarks input field
                                          //     _controller .remarksController.text = "";
                                          //   }
                                          // }
                                          _controller.validateFields();
                                          _controller.update();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: AppColors.orangeLogoColor,
                                        ),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (_controller.loanPurposeError != null)
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18, right: 10, top: 3),
                                      child: Text(
                                        _controller.loanPurposeError!,
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color.fromARGB(
                                                255, 201, 32, 20)),
                                      ),
                                    ),
                                  if (_controller.selectedLoanPurposeType ==
                                      "OTHERS")
                                    // ...[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: CustomTextField(
                                        controller:
                                            _controller.remarksController,
                                        errorText: _controller.remarksError,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(100),
                                        ],
                                        keyboardType: TextInputType.text,
                                        filled: true,
                                        fillColor:
                                            Colors.white.withOpacity(0.8),
                                        hintText: "Add Remarks:",
                                        onChanged: (value) {
                                          _controller.validateFields();
                                          _controller.update();
                                        },
                                      ),
                                    ),
                                  // ],

                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 25),
                                    child: CustomText(
                                        textColor: AppColors.white,
                                        textName: AppStrings.loanAmount),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: CustomTextField(
                                      controller:
                                          _controller.loanAmountController,
                                      // enabled: false,
                                      errorText: _controller.loanAmountError,
                                      inputFormatters: [
                                        FilteringTextInputFormatter(
                                            RegExp("[0-9]"),
                                            allow: true),
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      keyboardType: TextInputType.number,
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  Slider(
                                    activeColor: AppColors.orangeLogoColor,
                                    thumbColor: AppColors.white,
                                    // inactiveColor: Colors.gr,
                                    value: _controller.initialLoanAmount
                                        .toDouble(),
                                    onChanged: (value) {
                                      _controller.initialLoanAmount =
                                          value.toInt();
                                      _controller.loanAmountController.text =
                                          (_controller.initialLoanAmount * 1000)
                                              .toString();
                                      _controller.update();
                                    },
                                    min: 5,
                                    max: 100,
                                    divisions: 95,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          textName: AppStrings.fiveKText,
                                          textColor:
                                              Colors.white.withOpacity(0.8),
                                        ),
                                        CustomText(
                                          textName: AppStrings.hundredKText,
                                          textColor:
                                              Colors.white.withOpacity(0.8),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 25),
                                    child: CustomText(
                                        textColor: AppColors.white,
                                        textName: AppStrings.loanTenure),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: CustomTextField(
                                      controller:
                                          _controller.loanTenureController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter(
                                            RegExp("[0-9]"),
                                            allow: true),
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      errorText: _controller.loanTenureError,
                                      keyboardType: TextInputType.number,
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  Slider(
                                      activeColor: AppColors.orangeLogoColor,
                                      thumbColor: AppColors.white,
                                      value: _controller.initialLoanTenure
                                          .toDouble(),
                                      onChanged: (value) {
                                        _controller.initialLoanTenure =
                                            value.toInt();
                                        _controller.loanTenureController.text =
                                            _controller.initialLoanTenure
                                                .toString();
                                        _controller.update();
                                      },
                                      min: 1,
                                      max: 90,
                                      divisions: 89),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          textName: AppStrings.oneText,
                                          textColor:
                                              Colors.white.withOpacity(0.8),
                                        ),
                                        CustomText(
                                          textName: AppStrings.nintyText,
                                          textColor:
                                              Colors.white.withOpacity(0.8),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0, top: 25),
                                    child: CustomText(
                                        textColor: AppColors.white,
                                        textName: AppStrings.interestRate),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: CustomTextField(
                                      controller:
                                          _controller.interestRateController,
                                      inputFormatters: [
                                        FilteringTextInputFormatter(
                                            RegExp("[0-9.]"),
                                            allow: true),
                                        LengthLimitingTextInputFormatter(6),
                                      ],
                                      errorText: _controller.interestRateError,
                                      keyboardType: TextInputType.number,
                                      filled: true,
                                      fillColor: Colors.white.withOpacity(0.8),
                                    ),
                                  ),
                                  Slider(
                                    activeColor: AppColors.orangeLogoColor,
                                    thumbColor: AppColors.white,
                                    value: _controller.interestRate.toDouble(),
                                    onChanged: (value) {
                                      _controller.interestRate =
                                          (value * 10).round() / 10;
                                      _controller.interestRateController.text =
                                          _controller.interestRate
                                              .toStringAsFixed(1);
                                      _controller.update();
                                      if (_controller.interestRate < 0.8 ||
                                          _controller.interestRate > 2.75) {
                                        _controller.interestRateError =
                                            AppStrings.interestRateLimit;
                                      } else {
                                        _controller.interestRateError = null;
                                      }
                                    },
                                    min: 0.8,
                                    max: 2.75,
                                    divisions: ((2.75 - 0.8) * 10).toInt(),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          textName: AppStrings.zeroPoint8Rate,
                                          textColor:
                                              Colors.white.withOpacity(0.8),
                                        ),
                                        CustomText(
                                          textName: AppStrings.twoPoint75Rate,
                                          textColor:
                                              Colors.white.withOpacity(0.8),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Center(
                                      child: CustomText(
                                          textColor: AppColors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          textName: "Total Payable Amount")),
                                  Center(
                                      child: CustomText(
                                    textColor: AppColors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    textName:
                                        "${AppStrings.indianRupeesSymbol}${_controller.totalAmount.toStringAsFixed(2)}",
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    child: _controller.isLoading
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                            color: AppColors.white,
                                          ))
                                        : CustomButton(
                                            onPressed: () {
                                              _controller.validateFields();
                                              // Check for all validation errors
                                              if (_controller
                                                          .loanPurposeError ==
                                                      null &&
                                                  _controller.loanAmountError ==
                                                      null) {
                                                _controller.applyForLoan();
                                              } else {
                                                // Show appropriate error message
                                                String errorMessage = _controller
                                                        .loanPurposeError ??
                                                    _controller
                                                        .loanAmountError ??
                                                    "Please fix the errors.";
                                                showCustomSnackbar(
                                                    "Error", errorMessage,
                                                    backgroundColor:
                                                        AppColors.logoRedColor,
                                                    textColor: AppColors.white);
                                              }
                                              // _controller.validateFields();
                                              // if (_controller
                                              //         .loanPurposeError ==
                                              //     null) {
                                              //   _controller.applyForLoan();
                                              // } else {
                                              //   showCustomSnackbar("Error",
                                              //       "select loan purpuse before",
                                              //       backgroundColor:
                                              //           AppColors.logoRedColor,
                                              //       textColor: AppColors.white);
                                              // }
                                            },
                                            textName: _controller.isUpdated
                                                ? "Update"
                                                : AppStrings.submit,
                                            color: AppColors.orangeLogoColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            textColor: AppColors.white,
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ]));
  }
}
