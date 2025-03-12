import 'package:get/get.dart';
import 'package:qualoan/constants/app_strings.dart';

class QuestionAnswerController extends GetxController{

final List<bool> isExpanded = List.generate(5, (index) => false);
final List<String> questions = [
   AppStrings.whatIsQuaLoan,
   AppStrings.howQuaLoanHelp,
   AppStrings.howQuaLoanDifferent,
    AppStrings.howDoApply,
   AppStrings.howLongDoesItTakeApproval
  ];
final List<String> answers = [
  AppStrings.whatIsQuaLoanAnswer,
  AppStrings.howQuaLoanHelpAnswer,
  AppStrings.howQuaLoanDifferentAnswer,
  AppStrings.howDoApplyAnswer,
  AppStrings.howLongDoesItTakeApprovalAnswer
  ];

  void toggleExpansion(int index) {
      isExpanded[index] = !isExpanded[index];
      update();
  }
}