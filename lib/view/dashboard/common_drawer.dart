import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:qualoan/view/dashboard/show_loan_details.dart';

import '../../controller/dashboard_controller/common_drawer_controller.dart';

class CommonDrawer extends StatelessWidget {
  CommonDrawer({super.key});
  final _controller = Get.put(CommonDrawerController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(251, 197, 194, 194),
      child: GetBuilder<CommonDrawerController>(
        init: _controller,
        builder: (controller) {
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                padding: EdgeInsets.zero,
                height: Get.height * 0.4,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppImages.headerImage))),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 70),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.userProfilePicture !=
                                      null &&
                                  controller.userProfilePicture!.isNotEmpty
                              ? NetworkImage(controller
                                  .userProfilePicture!) 
                              : AssetImage(AppImages.userImage)
                                  as ImageProvider, 
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: TextButton(
                              onPressed: () {
                                Get.toNamed(MyAppRoutes.viewProfile);
                              },
                              child: CustomText(
                                textName: AppStrings.viewProfile,
                                textColor: AppColors.orangeLogoColor,
                                fontSize: 15,
                              ))),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 22),
                child: CustomText(
                  textName: AppStrings.fullName,
                  fontSize: 15,
                  textColor: AppColors.darkGrey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.grey,
                      border: Border.all(color: AppColors.darkGrey),
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: CustomText(
                      textName: controller.userName ?? AppStrings.loading,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(MyAppRoutes.questionAnswerScreen);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 3, right: 20, top: 20),
                  child: ListTile(
                    leading: const Icon(
                      Icons.help,
                      color: AppColors.lightOrange,
                    ),
                    title: CustomText(
                      textName: AppStrings.frequentlyAskedQuestion,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(ShowLoanDetails());
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 3, right: 20),
                  child: ListTile(
                    leading: const Icon(
                      Icons.payment,
                      color: AppColors.lightOrange,
                    ),
                    title: CustomText(textName: AppStrings.rePay),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 20),
                child: ListTile(
                  leading: const Icon(
                    Icons.policy_rounded,
                    color: AppColors.lightOrange,
                  ),
                  title: GestureDetector(
                      onTap: () {
                        _controller.openWebPage(
                            "https://www.qualoan.com/privacy-policy");
                      },
                      child: CustomText(textName: AppStrings.privacyText)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, right: 20),
                child: ListTile(
                  leading: const Icon(
                    Icons.terminal_sharp,
                    color: AppColors.lightOrange,
                  ),
                  title: GestureDetector(
                      onTap: () {
                        _controller.openWebPage(
                            "https://www.qualoan.com/terms-condition");
                      },
                      child: CustomText(textName: AppStrings.tAndc)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                child: GestureDetector(
                  onTap: () {
                    _controller.logout();
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.lightOrange,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: CustomText(
                        textName: AppStrings.logout,
                        textColor: AppColors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
