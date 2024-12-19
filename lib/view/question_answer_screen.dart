import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/reusable_widgets/custom_app_bar.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:get/get.dart';

import '../controller/question_answer_controller.dart';

class QuestionAnswerScreen extends StatelessWidget {
  QuestionAnswerScreen({super.key});

  final _controller = Get.put(QuestionAnswerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            height: Get.height * 0.15,
            leftPadding: 25,
            // icon: Icons.arrow_back_ios,
            title: "Loan doubts"),
        body: GetBuilder<QuestionAnswerController>(
          init: _controller,
          builder: (controller) {
            return Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textName: "Loan related Questions Answers here",
                    textColor: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        RotateAnimatedText(
                          'Frequently Asked Questions',
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
                  const SizedBox(height: 10),
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
              ),
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
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 210, 241, 211),
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(
                  15,
                ),
                bottomLeft: Radius.circular(15)),
          ),
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              leading: CustomText(
                textName: "$index.",
                textColor: Colors.black,
                fontSize: 18,
              ),
              trailing: Icon(
                isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Colors.black,
                size: 35,
              ),
              title: CustomText(
                overflow: TextOverflow.fade,
                softWrap: true,
                textName: question,
                fontSize: 15,
                textColor: Colors.black,
              ),
            ),
            if (isExpanded)
              Container(
                // height: 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                    border: Border.all(color: AppColors.black, width: 1)),
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
