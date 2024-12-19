
import 'package:app_here/controller/dashboard_controller.dart';
import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_images&icons.dart';
import 'package:app_here/reusable_widgets/custom_top_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

final _controller = Get.put(DashboardScreenController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
         body: GetBuilder<DashboardScreenController>(
                  init: _controller,
                  builder: (controller) {
                    return Center(
                      child: _controller.isSelectedIndex != 3
                          ? _controller.pages.elementAt(_controller.isSelectedIndex)
                          : const SizedBox(),
                    );
                  },
                ),
      
            // /// working on to create custom
            bottomNavigationBar: GetBuilder<DashboardScreenController>(
              init: _controller,
              builder: (controller) {
                return Material(
                  child: Container(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: AppColors.logoBlueColor),
                    //   color: const Color.fromARGB(255, 233, 231, 231),
                    // ),
                    // color: const Color.fromARGB(255, 243, 242, 241),
                    
                    // color: const Color.fromARGB(255, 172, 200, 244),
                    color: AppColors.black,
                    height: Get.height * 0.12,
                    child: TabBar(
                      indicatorSize: TabBarIndicatorSize.label,
                      onTap: (index) {
                        _controller.onItemTapped(index);
                        _controller.update();
                      },
                      // labelColor: AppColors.logoRedColor,
                      // labelColor:Color.fromARGB(255, 203, 202, 202),
                      labelColor: AppColors.green,
                      labelStyle: const TextStyle(fontSize: 14),
                      unselectedLabelStyle: const TextStyle(fontSize: 13,fontWeight: FontWeight.w500),
                      unselectedLabelColor: Colors.white,
                      controller: controller.tabController,
                      labelPadding: EdgeInsets.zero,
                      indicator: TopIndicator(),
                      tabs: <Widget>[
                        Tab(
                          
                            // icon: Icon(Icons.person,size: 30,),
                            icon:SvgPicture.asset(AppImages.applyNowIcon,
                                height:  50,
                                width: 20,
                                fit: BoxFit.scaleDown,
                                colorFilter: _controller.isSelectedIndex == 0
                                    ? const ColorFilter.mode(
                                    AppColors.green,BlendMode.srcIn)
                                    : const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn)),
                            text: "Apply Loan"
                            ),
                        Tab(
                            icon:
                             SvgPicture.asset(AppImages.loanCalculatorIcon,
                                height:45,
                                width: 15,
                                fit: BoxFit.scaleDown,
                                colorFilter: _controller.isSelectedIndex == 1
                                    ?   const ColorFilter.mode(
                                   AppColors.green,BlendMode.srcIn)
                                    : const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn)
                                ),
                            text: " Loan Calculator",
                            ),
                        Tab(
                            icon:SvgPicture.asset(AppImages.questionAnswerIcon,
                                height:50,
                                width: 15,
                                fit: BoxFit.scaleDown,
                                colorFilter: _controller.isSelectedIndex == 2
                                    ? const  ColorFilter.mode(
                                  AppColors.green,BlendMode.srcIn)
                                    : const ColorFilter.mode(
                                    Colors.white, BlendMode.srcIn)
                                ),
                            text: "Help"
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
