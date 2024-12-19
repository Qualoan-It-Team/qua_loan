

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanCalculatorController extends GetxController{
  double totalAmount = 5040.00;

  int initialLoanAmount=5;
  String? loanAmountError;
  TextEditingController loanAmountController = TextEditingController();

  int initialLoanTenure = 1; 
  String? loanTenureError;
  TextEditingController loanTenureController = TextEditingController();
  
  double interestRate = 0.8;
  String? interestRateError;
  TextEditingController interestRateController = TextEditingController();
  int value1 = 10;
  @override
  void onInit() {
    super.onInit();
    loanAmountController.text = (initialLoanAmount * 1000).toString();
    loanTenureController.text = initialLoanTenure.toString();
    interestRateController.text = interestRate.toStringAsFixed(1);
    loanAmountController.addListener(() {
      String input = loanAmountController.text;
      if (input.isNotEmpty) {
        int enteredValue = int.tryParse(input) ?? 0;
        if (enteredValue < 5000 || enteredValue > 100000) {        
            loanAmountError = "should be between ₹5000 & ₹100000";
            initialLoanAmount = (enteredValue ~/ 1000).clamp(5, 100);
            update();
        } else {
            loanAmountError = null; 
            initialLoanAmount = (enteredValue ~/ 1000).clamp(5, 100);
          update();        
        }
      } else {    
          loanAmountError = null;
          initialLoanAmount = 5; 
       update();
      }
      calculateTotalAmount();
      update();
    });


    loanTenureController.addListener(() {
      String input = loanTenureController.text;
      if (input.isNotEmpty) {
        int enteredValue = int.tryParse(input) ?? 0;
        if (enteredValue < 1 || enteredValue > 90) {
          loanTenureError = "should be between 1 & 90 days";
          initialLoanTenure = enteredValue.clamp(1, 90);
          update();
        } else {
          loanTenureError = null;
          initialLoanTenure = enteredValue.clamp(1, 90);
          update();
        }
      } else {
        loanTenureError = null;
        initialLoanTenure = 1;
        update();
      }
      calculateTotalAmount();
      update();
    });


    interestRateController.addListener(() {
      String input = interestRateController.text;
      if (input.isNotEmpty) {
        double enteredValue = double.tryParse(input) ?? 0.0;
        if (enteredValue < 0.8 || enteredValue > 2.75) {
          interestRateError = "should be between 0.8% & 2.75%";
          interestRate = enteredValue.clamp(0.8, 2.75);
          update();
        } else {
          interestRateError = null;
          interestRate = enteredValue;
          update();
        }
      } else {
        interestRateError = null;
      }
      calculateTotalAmount();
      update();
    });
  }
  void calculateTotalAmount() {
    // Convert inputs to appropriate types
    int loanAmount = initialLoanAmount * 1000;
    int loanTenureDays = initialLoanTenure*1;
    double interestRateDecimal = interestRate / 100; 
    int timeInYears = loanTenureDays ;
    totalAmount = loanAmount + (loanAmount * interestRateDecimal * timeInYears);
    
    update();
  }
}