// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/view/dashboard/dashboard_screen.dart';
import 'package:qualoan/view/dashboard/show_loan_details.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/dashboard_controller/home_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final _controller = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    _controller.fetchDashboardDetails();
    return Scaffold(
        body: SingleChildScrollView(
      child: GetBuilder<HomeScreenController>(
        init: _controller,
        builder: (controller) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.only(right: 35, left: 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => ShowLoanDetails());
                    },
                    child: Container(
                        height: Get.height * 0.065,
                        width: Get.width * 0.38,
                        decoration: BoxDecoration(
                            color: AppColors.lightOrange.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.grey, width: 0.5)),
                        child: Center(
                            child: CustomText(
                          textName: AppStrings.repayText,
                          textColor: AppColors.white,
                          fontSize: 16,
                        ))),
                  ),
                  Container(
                    height: Get.height * 0.065,
                    width: Get.width * 0.38,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: AppColors.lightOrange.withOpacity(0.8),
                            width: 0.5)),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: AppColors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: Get.height * 0.18,
                                    width: Get.width,
                                    decoration: const BoxDecoration(
                                        color: AppColors.darkGrey,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(60),
                                            bottomRight: Radius.circular(60)),
                                        border: Border(
                                            bottom: BorderSide(
                                                color: AppColors.orangeLogoColor,
                                                width: 10))),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15, top: 20),
                                      child: CustomText(
                                        textName: AppStrings.callWhatsAppText,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.fade,
                                        maxLines: 3,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        softWrap: true,
                                        textColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    height: 10,
                                    color: AppColors.white.withOpacity(0.09),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    height: 10,
                                    color: AppColors.white.withOpacity(0.09),
                                  ),
                                  const SizedBox(height: 5),
                                  Container(
                                    height: 10,
                                    color: AppColors.white.withOpacity(0.09),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.2,
                                    child: Center( child: Image.asset( AppImages.welcomeQuaLoanText)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 40, left: 40),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            _controller.whatsApp();
                                          },
                                          child: SvgPicture.asset(
                                              height: 50, AppImages.whatsappIcon),
                                        ),
                                        InkWell(
                                            onTap: () =>
                                                // launch('tel://8800858959'),
                                                launch(
                                                    'tel://${AppStrings.whatsappNumber}'),
                                            child: const Icon(Icons.call,
                                                color: AppColors.orangeLogoColor,
                                                size: 55)),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors.lightOrange.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: CustomText(
                            textName: AppStrings.supportText,
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 35, left: 35),
            child: InkWell(
              onTap: () {
                if (_controller.isRegistrationCondition==true) {
                   Get.to(DashboardScreen());
                      Get.find<DashboardScreenController>().onItemTapped(1);
                  
                // Get.to(DashboardScreen());
                // Get.find<DashboardScreenController>().onItemTapped(2);
                }else if(_controller.isloanApplyCondition==true){
                  Get.to(DashboardScreen());
                      Get.find<DashboardScreenController>().onItemTapped(2);

                }else{
                   Get.to(DashboardScreen());
                      Get.find<DashboardScreenController>().onItemTapped(1);
                }
              },
              child: Container(
                height: Get.height * 0.065,
                decoration: BoxDecoration(
                    color: AppColors.darkGrey,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.pink, width: 0.5)),
                child: Center(
                    child: CustomText(
                  textName:_controller.isRegistrationCondition? AppStrings.registration:_controller.isloanApplyCondition? AppStrings.applicationStatusCaps:AppStrings.applyLoan,
                  // textName:_controller.isRegistrationCondition? AppStrings.applyLoan:" APPLICATION STATUS",
                  textColor: AppColors.white,
                  fontSize: 15,
                )),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
            child: Container(
              height: Get.height * 0.21,
              decoration: BoxDecoration(
                color: AppColors.lightOrange,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            textName: AppStrings.forInstantSupport,
                            fontSize: 17,
                            textColor: AppColors.white,
                            overflow: TextOverflow.fade,
                            fontWeight: FontWeight.w300,
                          ),
                          const SizedBox(height: 25),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {
                              _controller.launchURL("https://www.youtube.com/watch?v=0aKwYTqEr80");
                              
                            },
                            child: Container(
                                height: 40,
                                width: Get.width * 0.42,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.white, width: 1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.video_file,
                                        color: AppColors.white,
                                      ),
                                      const SizedBox(width: 15),
                                      CustomText(
                                        textName: AppStrings.clickHere,
                                        fontSize: 15,
                                        textColor: AppColors.white,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ],
                                  ),
                                )),
                          )
                        ],
                      )),
                  IgnorePointer(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: SvgPicture.asset(AppImages.halfQuaIcon, height: 150),
                    ),
                  ),
                ],
              ),
            ),
          )
        ]);
        },
      ),
    ));
  }
}
