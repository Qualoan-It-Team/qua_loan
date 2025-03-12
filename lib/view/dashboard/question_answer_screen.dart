
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import '../../controller/dashboard_controller/question_answer_controller.dart';
import '../../reusable_widgets/common_back_header.dart';

class QuestionAnswerScreen extends StatelessWidget {
  QuestionAnswerScreen({super.key});

  final _controller = Get.put(QuestionAnswerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<QuestionAnswerController>(
          init: _controller,
          builder: (controller) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CommonBackHeader( ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          height: 50,
                          AppImages.loanAmountIcon),
                          const SizedBox(width: 5),
                        CustomText(
                          textName: AppStrings.loanDoubts,
                          textColor: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        
                      ],
                    ),
                  ),
                  const SizedBox(height: 10,),
                  CustomText(
                    textName: AppStrings.loanRelatedQuestionText,
                    textColor: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 40,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText(
                          AppStrings.frequentlyAskedQuestion,
                          textStyle: const TextStyle(
                            color: AppColors.bgColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      isRepeatingAnimation: true,
                      totalRepeatCount: 100,
                      pause: const Duration(milliseconds: 100),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount:  _controller.questions.length,
                      itemBuilder: (context, index) {
                        return QuestionTile(
                          index: index + 1,
                          question: _controller.questions[index],
                          answer: _controller. answers[index],
                          isExpanded: _controller. isExpanded[index],
                          onTap: () =>_controller. toggleExpansion(index),
                        );
                      },
                    ),
                  )
                ],
            );
          },
        )
      );
  }
}

class QuestionTile extends StatelessWidget {
  final String question;
  final int index;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const QuestionTile({
    super.key,
    required this.question,
    required this.answer,
    required this.index,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 15,left: 15),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.black.withOpacity(0.8),
            border: Border.all(color: AppColors.orangeLogoColor,width: 2),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(
                  15,
                ),
                bottomLeft: Radius.circular(15)),
          ),
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              leading: CustomText(
                textName: "$index.",
                textColor: AppColors.orangeLogoColor,
                fontSize: 18,
              ),
              trailing: Icon(
                isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.white,
                size: 35,
              ),
              title: CustomText(
                overflow: TextOverflow.fade,
                softWrap: true,
                textName: question,
                fontSize: 15,
                textColor: Colors.white,
              ),
            ),
            if (isExpanded)
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15)
                        ),
                    border: Border.all(color: AppColors.black, width: 2)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomText(
                    textName: answer,
                    textColor: AppColors.black,
                    fontSize: 16,
                    overflow: TextOverflow.fade,
                    softWrap: true,
                  ),
                ),
              )
          ]),
        ),
      ),
    );
  }
}
