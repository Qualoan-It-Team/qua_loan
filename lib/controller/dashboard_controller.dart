
import 'package:app_here/view/apply_loan.dart';
import 'package:app_here/view/loan_calculator_screen.dart';
import 'package:app_here/view/question_answer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DashboardScreenController extends GetxController with GetSingleTickerProviderStateMixin{

 int isSelectedIndex = 0;
  late TabController tabController = TabController(length: 3, vsync: this);
  List<Widget> pages = <Widget>[
    const ApplyLoanScreen(),
    LoanCalculatorScreen(),
    QuestionAnswerScreen()
    
  ];
void onItemTapped(int index) {
    isSelectedIndex = index;
    if (index == 0) {
    } else if (index == 1) {
    } else if (index == 2) {
    } 
     update();
  }


}