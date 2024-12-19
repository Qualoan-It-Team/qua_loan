import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/controller/loan_calculator_controller.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:app_here/reusable_widgets/custom_text_field.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../reusable_widgets/custom_button.dart';

class LoanCalculatorScreen extends StatelessWidget {
  LoanCalculatorScreen({super.key});

  final _controller = Get.put(LoanCalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<LoanCalculatorController>(
          init: _controller,
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 25, right: 25, top: Get.height * 0.1),
                child: Column(
                  children: [
                    Center(
                        child: CustomText(
                      textColor: AppColors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      textName: "Loan Calculator",
                    )),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
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
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 15, right: 5, left: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 15),
                                child: CustomText(
                                    textColor: Colors.green,
                                    textName: "Loan Amount (₹)"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: CustomTextField(
                                  controller: _controller.loanAmountController,
                                  // hintText: "Enter Loan Amount",
                                  errorText: _controller.loanAmountError,
                                  keyboardType: TextInputType.number,
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              Slider(
                                activeColor: AppColors.green,
                                thumbColor: AppColors.black,
                                // inactiveColor: Colors.gr,
                                value: _controller.initialLoanAmount.toDouble(),
                                onChanged: (value) {
                                  _controller.initialLoanAmount = value.toInt();
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(textName: "5k"),
                                    CustomText(textName: "100k")
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 25),
                                child: CustomText(
                                    // textColor: Colors.white,
                                    textColor: Colors.green,
                                    textName: "Loan Tenure (Days)"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: CustomTextField(
                                  controller: _controller.loanTenureController,
                                  // hintText: "Enter Loan Tenure",
                                  errorText: _controller.loanTenureError,
                                  keyboardType: TextInputType.number,
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              Slider(
                                  activeColor: AppColors.green,
                                  thumbColor: AppColors.black,
                                  value:
                                      _controller.initialLoanTenure.toDouble(),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(textName: "1"),
                                    CustomText(textName: "90")
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16.0, top: 25),
                                child: CustomText(
                                    textColor: Colors.green,
                                    textName: "Interest Rate (%)"),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: CustomTextField(
                                  controller:
                                      _controller.interestRateController,
                                  // hintText: "Enter Interest Rate",
                                  errorText: _controller
                                      .interestRateError, // Assuming you have an error handling mechanism
                                  keyboardType: TextInputType.number,
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                              Slider(
                                activeColor: AppColors.green,
                                thumbColor: AppColors.black,
                                value: _controller.interestRate
                                    .toDouble(), // Assuming you have a variable for interest rate
                                onChanged: (value) {
                                  _controller.interestRate =
                                      (value * 10).round() /
                                          10; // Round to nearest 0.1
                                  _controller.interestRateController.text =
                                      _controller.interestRate.toStringAsFixed(
                                          1); // Show one decimal place
                                  _controller.update();
                                  if (_controller.interestRate < 0.8 ||
                                      _controller.interestRate > 2.75) {
                                    _controller.interestRateError =
                                        "should be between 0.8% & 2.75%";
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(textName: "0.8%"),
                                    CustomText(textName: "2.75%")
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: CustomButton(
                                  onPressed: () {
                                    //  _controller.calculateTotalAmount();
                                  },
                                  textName:
                                      "₹${_controller.totalAmount.toStringAsFixed(2)}",
                                  color: AppColors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  textColor: AppColors.black,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
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
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 15, right: 5, left: 5),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                  child: CustomText(
                                      textColor: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      textName: "Clarity in Lending ")),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: CustomText(
                                    textColor: Colors.black,
                                    fontSize: 14,
                                    softWrap: true,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.fade,
                                    textName:
                                        "Detailed informtion to help you understand your financial commitment"),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Center(
                                  child: CustomText(
                                textName: "You have to pay",
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                textColor: Colors.green,
                              )),
                              const SizedBox(
                                height: 2,
                              ),
                              Center(
                                  child: CustomText(
                                textName:
                                    "₹${_controller.totalAmount.toStringAsFixed(2)}",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.black,
                              )),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomText(
                                      textName:
                                          "Interest Rate\n${_controller.interestRate} %",
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                      // textColor: Colors.green,
                                    ),
                                    CustomText(
                                      textName:
                                          "Loan Amount\n₹${_controller.initialLoanAmount * 1000}",
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                    ),
                                    CustomText(
                                      // textName: "Loan Tenure\n${_controller.initialLoanTenure}",
                                      textName:
                                          "Loan Tenure\n${_controller.initialLoanTenure} ${_controller.initialLoanTenure == 1 ? 'day' : 'days'}",
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 50),
                                child:
                                 CustomButton(
                                  gradient:  const LinearGradient(
                                  colors: [
                                    AppColors.green,
                                    AppColors.black
                                  ]),
                                  
                                    onPressed: () {
                                      Get.toNamed(MyAppRoutes.flowDiagramScreen);
                                    },
                                    textName: "Apply Now",
                                    color: AppColors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    textColor: AppColors.black,
                                  ),
                                ),
                        
                              const SizedBox(
                                height: 30,
                              ),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
