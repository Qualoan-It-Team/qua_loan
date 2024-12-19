import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_images&icons.dart';
import 'package:app_here/reusable_widgets/custom_button.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ApplyLoanScreen extends StatelessWidget {
  const ApplyLoanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 70, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  textName: "Get Instant Loan \nin Minutes!",
                  // textColor: AppColors.logoBlueColor,
                  textColor: AppColors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
               const  SizedBox( height: 10,),
                CustomText(
                  textName: "We are here for all your  financial needs.",
                  // textColor: AppColors.logoBlueColor,
                  textColor: AppColors.green,
                  fontSize: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0))
                        ],
                        borderRadius: BorderRadius.circular(15),
                        // color: const Color.fromARGB(255, 240, 213, 195)),
                        color: const Color.fromARGB(255, 210, 241, 211)),
                        // color: AppColors.green),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, top: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    textName: "Unlock",
                                    textColor: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  CustomText(
                                    textName: "₹ 1,00,000",
                                    // textColor: AppColors.green,
                                    textColor: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                              SvgPicture.asset(
                                AppImages.loanPageIcon,
                                width: Get.width * 0.25,
                                height: Get.height * 0.13,
                              )
                            ],
                          ),
                          CustomText(
                            textName: "Only in few clicks ",
                            textColor: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          const SizedBox(height: 7, ),
                          CustomText(
                              textName:"Secure your personal loan effortlessly with a easy process. Unlock now !! ",
                              textColor: Colors.black,
                              fontSize: 15,
                              overflow: TextOverflow.fade,
                              softWrap: true),
                          const SizedBox(height: 15,),
                          CustomButton(
                            onPressed: () {
                              Get.toNamed( MyAppRoutes.flowDiagramScreen);
                            },
                            textName: "Apply Now",
                            color: AppColors.black,
                            // textColor: AppColors.green,
                            textColor: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          const SizedBox(height: 15,)
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(2.0, 2.0), 
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    AppImages.bookIcon,
                                    height: Get.height * 0.07,
                                    width: Get.width * 0.13,
                                  ),
                                  SvgPicture.asset(
                                    AppImages.loanArrowIcon,
                                    height: Get.height * 0.07,
                                    width: Get.width * 0.15,
                                    color: AppColors.green,
                                  ),
                                ],
                              ),
                              RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: "    Apply for a  \n",
                                    style: TextStyle( fontSize: 15,color: AppColors.black)),
                                     TextSpan(
                                  text: "    Loan  ",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      height: 1.5,
                                      color: AppColors.green),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(MyAppRoutes.pincodeScreen);
                                    },
                                ),
                                const TextSpan(
                                    text: "now",
                                    style: TextStyle(
                                        fontSize: 15,
                                        height: 1.5,
                                        color: AppColors.logoBlueColor))
                              ])),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0,
                                          2.0), 
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, right: 12, top: 10, bottom: 20),
                                child: RichText(
                                    text: const TextSpan(children: [
                                  TextSpan(
                                      text: "Your balance \n",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColors.black)),
                                  TextSpan(
                                      text: "₹ 1,00,000\n",
                                      style: TextStyle(
                                          fontSize: 20,
                                          height: 1.5,
                                          // color: AppColors.green
                                          color: Colors.green
                                          )),
                                  TextSpan(
                                      text: "is waiting for you.",
                                      style: TextStyle(
                                          fontSize: 14,
                                          height: 1.5,
                                          color: AppColors.black)),
                                ])),
                              ))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.black,width: 1),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                                  colors: [
                                    AppColors.black,
                                    AppColors.green,
                                    
                                  ])
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10,top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomText(
                                  textName:"Get Your Loan \nEasily in \n3 Simple Steps.",
                                  // textColor: AppColors.black,
                                  textColor: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.fade,
                                  softWrap: true,
                                ),
                              ),
                              SvgPicture.asset(
                                AppImages.moneyIcon,
                                color: Colors.white,
                                height: Get.height * 0.15,
                                width: Get.width * 0.2,
                              )
                            ],
                          ),
                           Align(
                            heightFactor: 1.2,
                            alignment: Alignment.bottomRight,
                             child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.green,
                                borderRadius: BorderRadius.circular(7),
                                border: Border.all(color: AppColors.black,width: 1),
                                gradient: const LinearGradient(
                                  colors: [
                                    AppColors.green,
                                    AppColors.black
                                  ])
                              ),
                               height: Get.height * 0.047,
                              width: Get.width * 0.5,
                               child: CustomButton(
                                onPressed: () {
                                    Get.toNamed(MyAppRoutes.flowDiagramScreen);
                                  },
                                textName: "see how it works",
                                // color: AppColors.green,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                textColor: AppColors.black,
                                fontSize: 14,
                              ),
                             ),
                           ),
                          const SizedBox( height: 15, )
                        ],
                      ),
                    ),
                  ),
                ),
               const SizedBox(height: 10,)
              ],
            ),
          ),
        ));
  }
}
