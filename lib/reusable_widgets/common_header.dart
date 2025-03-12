import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';

import '../controller/dashboard_controller/common_drawer_controller.dart';

class CommonHeader extends StatelessWidget {
   final _controller = Get.put(CommonDrawerController());
  final bool showFullHeader;
  final VoidCallback onDrawerTap;
    CommonHeader(
      {super.key, this.showFullHeader = true, required this.onDrawerTap});

  @override
  Widget build(BuildContext context) {
    _controller.fetchUserProfile();
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (showFullHeader)
          // First Container
          Container(
            height: Get.height * 0.32,
            decoration: const BoxDecoration(
              color: Color.fromARGB(251, 197, 194, 194),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        height: 40,
                        child: Image.asset(AppImages.quaHomeLogoPng),
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: IconButton(
                            icon: SvgPicture.asset(AppImages.humburgerIcon,
                                height: 20),
                            onPressed: onDrawerTap,
                            // () {
                            // scaffoldState.openDrawer();
                            // Scaffold.of(context)
                            //     .openDrawer(); // Open the drawer
                            // },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 55.0),
                    child: InkWell(
                      onTap: onDrawerTap,
                      // onTap: () {
                      //   // Scaffold.of(context).openDrawer();
                      //   scaffoldState.openDrawer();
                      // },
                      child:  CircleAvatar(
                        // backgroundImage: AssetImage(AppImages.userImage),
                        backgroundImage: _controller.userProfilePicture !=
                                      null &&
                                  _controller.userProfilePicture!.isNotEmpty
                              ? NetworkImage(_controller
                                  .userProfilePicture!) 
                              : AssetImage(AppImages.userImage)
                                  as ImageProvider,
                        radius: 30,
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        if (!showFullHeader)
          // Simplified header with only logo and hamburger icon
          Container(
            color: const Color.fromARGB(251, 197, 194, 194),
            height: 125,
            padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.012),
                  child: SizedBox(
                      height: 40, child: Image.asset(AppImages.quaHomeLogoPng)),
                ),
                Builder(
                  builder: (context) {
                    return IconButton(
                      icon: SizedBox(
                        height: 25,
                        child: SvgPicture.asset(AppImages.humburgerIcon,
                            height: 20),
                      ),

                      onPressed: onDrawerTap,
                      // onPressed: () {
                      //   // Scaffold.of(context)
                      //   //    .openDrawer(); // Open the drawer
                      //   scaffoldState.openDrawer();
                      // },
                    );
                  },
                ),
              ],
            ),
          ),
        if (showFullHeader)
          // Second Container (Overlapping)
          Positioned(
            top: Get.height * 0.28 - 70,
            right: 0,
            child: Align(
                alignment: Alignment.topRight,
                child: Container(
                    height: 220,
                    width: 220,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AppImages.chatboxLogoPng)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              textName: AppStrings.welcome,
                              textColor: AppColors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomText(
                              textName: AppStrings.getInstantLoanInMinutes,
                              textColor: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomText(
                              textName:
                                  AppStrings.weAreHereForAllFinancialNeeds,
                                  overflow: TextOverflow.fade,
                              textColor: AppColors.white,
                              fontWeight: FontWeight.w200),
                        ],
                      ),
                    ))),
          ),
      ],
    );
  }
}
