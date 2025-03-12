// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/calculator_controller.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/reusable_widgets/custom_text_field.dart';
import '../../reusable_widgets/custom_button.dart';

class CalculatorScreen extends StatelessWidget {
  CalculatorScreen({super.key});

  final _controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
          SizedBox(
            child: GetBuilder<CalculatorController>(
              init: _controller,
              builder: (controller) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Center(
                          child: CustomText(
                              textColor: AppColors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              textName: AppStrings.calculator)),
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                        left: 16.0, top: 15),
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
                                      errorText: _controller
                                          .interestRateError,
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: CustomButton(
                                      onPressed: () {},
                                      textName:
                                          "${AppStrings.indianRupeesSymbol}${_controller.totalAmount.toStringAsFixed(2)}",
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
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                      child: CustomText(
                                          textColor: AppColors.orangeLogoColor
                                              .withOpacity(0.8),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          textName:
                                              AppStrings.clarityInLending)),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: CustomText(
                                        textColor:
                                            Colors.white.withOpacity(0.8),
                                        fontSize: 14,
                                        softWrap: true,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        textName:
                                            AppStrings.clarityInLendingDes),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: CustomText(
                                    textName: AppStrings.youHaveToPay,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    textColor: AppColors.orangeLogoColor,
                                  )),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  Center(
                                      child: CustomText(
                                    textName:
                                        "${AppStrings.indianRupeesSymbol}${_controller.totalAmount.toStringAsFixed(2)}",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    textColor: Colors.white.withOpacity(0.8),
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomText(
                                          textName:
                                              "${AppStrings.interestRateSlash}${_controller.interestRate} ${AppStrings.modSymbol}",
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                          textColor:
                                              Colors.white.withOpacity(0.8),
                                        ),
                                        CustomText(
                                          textName:
                                              "${AppStrings.loanAmountSlash}${_controller.initialLoanAmount * 1000}",
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                          textColor:
                                              Colors.white.withOpacity(0.8),
                                        ),
                                        CustomText(
                                          textName:
                                              "${AppStrings.loanTenureSlash}${_controller.initialLoanTenure} ${_controller.initialLoanTenure == 1 ? AppStrings.dayText : AppStrings.daysText}",
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.fade,
                                          textColor:
                                              Colors.white.withOpacity(0.8),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //       left: 20, right: 20, top: 50),
                                  //   child: CustomButton(
                                  //     gradient: const LinearGradient(colors: [
                                  //       AppColors.orangeLogoColor,
                                  //       AppColors.black
                                  //     ]),
                                  //     onPressed: () {
                                  //       Get.to(DashboardScreen());
                                  //       Get.find<DashboardScreenController>()
                                  //           .onItemTapped(1);
                                  //     },
                                  //     textName: AppStrings.applyNow,
                                  //     color: AppColors.orangeLogoColor,
                                  //     fontWeight: FontWeight.bold,
                                  //     fontSize: 16,
                                  //     textColor: AppColors.white,
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                ]),
                          ),
                        ),
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
