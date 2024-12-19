import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../reusable_widgets/custom_button.dart';

class FlowDiagramScreen extends StatelessWidget {
  const FlowDiagramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Get.height * 0.1,
            ),
            CustomText(
              textName: "Get Your Loan \nEasily in \n3 Simple Steps",
              fontSize: 27,
              fontWeight: FontWeight.bold,
              textColor: Colors.black,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomText(
              textName: "We are here for all your financial needs.",
              fontSize: 16,
              // fontWeight: FontWeight.bold,
              textColor: AppColors.green,
            ),
            SizedBox(
              height: Get.height * 0.05,
              // height: 25,
            ),
            
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.green,
                    child: Text(
                      "1",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.05,
                  ),
                  CustomText(
                    textName: "KYC Verification",
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                 SizedBox(
                        height: Get.height * 0.1,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: VerticalDivider(
                            color: Colors.green,
                            indent: 2,
                            endIndent: 2,
                            // width: 2,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                  SizedBox(
                    width: Get.width * 0.06,
                  ),
                   Expanded(
                     child: CustomText(
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            height: 1.6,
                            maxLines: 1,
                            textName:
                                "We'll start by verifyingyour documents simply upload your Pan and Aadhaar to get started on your loan journey.",
                          ),
                   ),
                ],
              ),
            ),
              Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.green,
                    child: Text(
                      "2",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                 SizedBox(
                    width: Get.width * 0.05,
                  ),
                  CustomText(
                    textName: "Provide Bank & Basic Details",
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                 SizedBox(
                        height: Get.height * 0.1,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: VerticalDivider(
                            color: Colors.green,
                            indent: 2,
                            endIndent: 2,
                            // width: 2,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                 SizedBox(
                    width: Get.width * 0.06,
                  ),
                   Expanded(
                     child: CustomText(
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            height: 1.6,
                            maxLines: 1,
                            textName:
                                "Next, share some basic information like your salary and bank details, including your bank name and account number, to proceed.",
                          ),
                   ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 15,
                    backgroundColor: AppColors.green,
                    child: Text(
                      "3",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                 SizedBox(
                    width: Get.width * 0.05,
                  ),
                  CustomText(
                    textName: "Collect Your Cash",
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.black,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                 SizedBox(
                        height: Get.height * 0.1,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: VerticalDivider(
                            color: Colors.white,
                            indent: 2,
                            endIndent: 2,
                            // width: 2,
                            thickness: 1.5,
                          ),
                        ),
                      ),
                 SizedBox(
                    width: Get.width * 0.06,
                  ),
                   Expanded(
                     child: CustomText(
                            overflow: TextOverflow.fade,
                            softWrap: true,
                            height: 1.6,
                            maxLines: 1,
                            textName:
                                "Once everything is verified, your loan is approved, and your cash is unlocked-ready to be transferred to your account.",
                          ),
                   ),
                ],
              ),
            ),




            // Padding(
            //   padding: const EdgeInsets.only(
            //     left: 10,
            //   ),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           const CircleAvatar(
            //             radius: 15,
            //             backgroundColor: AppColors.green,
            //             child: Text(
            //               "1",
            //               style: TextStyle(color: Colors.black),
            //             ),
            //           ),
            //           SizedBox(
            //             height: Get.height * 0.1,
            //             child: const Padding(
            //               padding: EdgeInsets.only(left: 8),
            //               child: VerticalDivider(
            //                 color: Colors.green,
            //                 indent: 2,
            //                 endIndent: 2,
            //                 // width: 2,
            //                 thickness: 1.5,
            //               ),
            //             ),
            //           ),
            //           const CircleAvatar(
            //             radius: 15,
            //             backgroundColor: AppColors.green,
            //             child: Text(
            //               "2",
            //               style: TextStyle(color: Colors.black),
            //             ),
            //           ),
            //           SizedBox(
            //             height: Get.height * 0.1,
            //             child: const Padding(
            //               padding: EdgeInsets.only(left: 8),
            //               child: VerticalDivider(
            //                 color: Colors.green,
            //                 indent: 2,
            //                 endIndent: 2,
            //                 // width: 2,
            //                 thickness: 1.5,
            //               ),
            //             ),
            //           ),
            //           const CircleAvatar(
            //             radius: 15,
            //             backgroundColor: AppColors.green,
            //             child: Text(
            //               "3",
            //               style: TextStyle(color: Colors.black),
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         width: Get.width * 0.05,
            //       ),
            //       Flexible(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             CustomText(
            //               textName: "KYC Verification",
            //               fontSize: 17,
            //               fontWeight: FontWeight.w700,
            //               textColor: AppColors.black,
            //             ),
            //             const SizedBox(
            //               height: 5,
            //             ),
            //             CustomText(
            //               overflow: TextOverflow.fade,
            //               softWrap: true,
            //               height: 1.6,
            //               maxLines: 1,
            //               textName:
            //                   "We'll start by verifyingyour documents simply upload your Pan and Aadhaar to\nget started on your loan journey.",
            //             ),
            //             const SizedBox(
            //               height: 20,
            //             ),
            //             CustomText(
            //               textName: "Provide Bank & Basic Details",
            //               fontSize: 17,
            //               fontWeight: FontWeight.w700,
            //               textColor: AppColors.black,
            //             ),
            //             // Text("Provide Bank & Basic Details"),
            //             // const SizedBox(
            //             //   height: 5,
            //             // ),
            //             SizedBox(
            //               width: Get.width,
            //               child: CustomText(
            //                   overflow: TextOverflow.fade,
            //                   softWrap: true,
            //                   maxLines: 1,
            //                   height: 1.7,
            //                   textName:
            //                       "Next, share some basic information like your salary and bank details, including your bank name and account number, to proceed."),
            //             ),
            //             const SizedBox(
            //               height: 15,
            //             ),
            //             CustomText(
            //               textName: "Collect Your Cash",
            //               fontSize: 17,
            //               fontWeight: FontWeight.w700,
            //               // height: 1.2,
            //               textColor: AppColors.black,
            //             ),
            //             const SizedBox(
            //               height: 5,
            //             ),
            //             CustomText(
            //                 overflow: TextOverflow.fade,
            //                 softWrap: true,
            //                 maxLines: 1,
            //                 height: 1.6,
            //                 // maxLines: 3,
            //                 textName:
            //                     "Once everything is verified, your loan is approved, and your cash is unlocked-ready to be transferred to your account."),
            //           ],
            //         ),
            //       )
            //     ],
            //   ),
            // ),
            
           
           
            const SizedBox(
              height: 15,
            ),
            CustomText(
              textName: "Begin your juorney and unlock your \ncash today!",
              fontSize: 18,
              height: 1.8,
              fontWeight: FontWeight.w700,
              textColor: AppColors.green,
            ),
            SizedBox(
              height: Get.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: CustomButton(
                onPressed: () {
                  Get.toNamed(MyAppRoutes.pincodeScreen);
                },
                textName: "Get Started",
                fontSize: 18,
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                textColor: AppColors.green,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
