import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_images&icons.dart';
import 'package:app_here/constants/app_strings.dart';
import 'package:app_here/controller/location_screen_controller.dart';
import 'package:app_here/reusable_widgets/custom_app_bar.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../reusable_widgets/custom_button.dart';
import '../reusable_widgets/custom_list_tile.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({super.key});
  final _controller = Get.put(LocationScreenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
            height: Get.height * 0.2,
            leftPadding: 25,
            forceMaterialTransparency: true,
            title: AppStrings.permissionToServeText),
        body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
               const CustomListTile(
                  isThreeLine: true,
                  titleTextName: AppStrings.location,
                  titleFontweight: FontWeight.bold,
                  titleFontSize: 16,
                  titleTextColor: AppColors.black,
                  subTitleTextName: AppStrings.locationDes,
                  subTitleTextColor: AppColors.black,
                  subTitleFontSize: 12,
                  leading:  Icon(Icons.location_on,
                        color: AppColors.green)
                ),
                const SizedBox(height: 5,),
               const CustomListTile(
                  isThreeLine: true,
                  titleTextName: AppStrings.camera,
                  titleFontweight: FontWeight.bold,
                  titleFontSize: 16,
                  titleTextColor: AppColors.black,
                  subTitleTextName: AppStrings.cameraDes,
                  subTitleTextColor: AppColors.black,
                  subTitleFontSize: 12,
                    leading: Icon(Icons.camera_alt_rounded,
                        color: AppColors.green)
                ),
               const SizedBox(height: 5,),
               const CustomListTile(
                  isThreeLine: true,
                  titleTextName: AppStrings.storageText,
                  titleFontweight: FontWeight.bold,
                  titleFontSize: 16,
                  titleTextColor: AppColors.black,
                  subTitleTextName: AppStrings.storageDes,
                  subTitleTextColor: AppColors.black,
                  subTitleFontSize: 12,
                    leading: Icon(Icons.sd_storage_rounded,
                        color: AppColors.green)
                ),
                const SizedBox(height: 75),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.rightArrow,
                      height: 40,
                    ),
                    CustomText(
                      textName: AppStrings.infoSafeWithUsText,
                      textColor: AppColors.black,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  child: CustomButton(
                   onPressed: () {
                          _controller.checkLocationPermission();
                        },
                    textName: AppStrings.letsGo,
                    color: AppColors.black,                    
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.green,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
