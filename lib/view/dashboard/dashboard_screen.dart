// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/reusable_widgets/common_header.dart';
import 'package:qualoan/reusable_widgets/custom_top_indicator.dart';
import 'package:qualoan/view/dashboard/common_drawer.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});
  final GlobalKey<ScaffoldState> homeScaffoldKey = GlobalKey<ScaffoldState>();

  final _controller = Get.put(DashboardScreenController());

  @override
  Widget build(BuildContext context) {
    _controller.fetchDashboardDetails();
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        key: homeScaffoldKey,
        drawer: CommonDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder(
                init: _controller,
                builder: (controller) {
                  return SizedBox(
                    height: _controller.isSelectedIndex == 0
                        ? Get.height * 0.45
                        : Get.height * 0.15,
                    child: CommonHeader(
                      showFullHeader:
                          _controller.isSelectedIndex == 0 ? true : false,
                      onDrawerTap: () {
                        homeScaffoldKey.currentState?.openDrawer();
                      },
                    ),
                  );
                },
              ),
              SizedBox(
                child: GetBuilder<DashboardScreenController>(
                  init: _controller,
                  builder: (controller) {
                    return SizedBox(
                      height: _controller.isSelectedIndex == 0
                          ? Get.height * 0.44
                          : Get.height * 0.76,
                      child: Center(
                        child: _controller.isSelectedIndex != 4
                            ? _controller.pages
                                .elementAt(_controller.isSelectedIndex)
                            : const SizedBox(),
                      ),
                    );
                  },
                ),
                // ),
              ),
              // ),
            ],
          ),
        ),
        bottomNavigationBar: GetBuilder<DashboardScreenController>(
          init: _controller,
          builder: (controller) {
            return Material(
              child: Container(
                color: AppColors.darkGrey,
                height: Get.height * 0.095,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  onTap: (index) {
                    _controller.onItemTapped(index);
                    _controller.update();
                  },
                  labelColor: AppColors.orangeLogoColor,
                  labelStyle: const TextStyle(fontSize: 14),
                  unselectedLabelStyle: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500),
                  unselectedLabelColor: Colors.grey,
                  controller: controller.tabController,
                  labelPadding: EdgeInsets.zero,
                  indicator: TopIndicator(),
                  tabs: <Widget>[
                    Tab(
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.home_outlined,
                          size: 25,
                          color: _controller.isSelectedIndex == 0
                              ? AppColors.orangeLogoColor
                              : Colors.grey,
                        ),
                      ),
                      text: AppStrings.home,
                    ),
                    Tab(
                      icon: SvgPicture.asset(
                        AppImages.questionAnswerIcon,
                        height: 40,
                        fit: BoxFit.scaleDown,
                        colorFilter: _controller.isSelectedIndex == 1
                            ? const ColorFilter.mode(
                                AppColors.orangeLogoColor, BlendMode.srcIn)
                            : const ColorFilter.mode(
                                Colors.grey, BlendMode.srcIn),
                      ),
                      text: _controller.isRegisterationtab
                          ? AppStrings.tabRegistration
                          : AppStrings.applyLoanTab
                          // _controller.isLoanApply
                              // ? AppStrings.applicationStatus
                              // : AppStrings.applyLoanTab,
                    ),
                    Tab(
                      iconMargin: EdgeInsets.all(7),
                      icon: Icon(
                        size: 26,
                        Icons.format_indent_increase_rounded,
                        color: _controller.isSelectedIndex == 2
                            ? AppColors.orangeLogoColor
                            : Colors.grey,
                      ),
                      text: AppStrings.applicationStatus,
                    ),
                    Tab(
                      icon: SvgPicture.asset(
                        AppImages.loanCalculatorIcon,
                        height: 40,
                        width: 10,
                        fit: BoxFit.scaleDown,
                        colorFilter: _controller.isSelectedIndex == 3
                            ? const ColorFilter.mode(
                                AppColors.orangeLogoColor, BlendMode.srcIn)
                            : const ColorFilter.mode(
                                Colors.grey, BlendMode.srcIn),
                      ),
                      text: AppStrings.calculator,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
