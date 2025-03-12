// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qualoan/constants/app_strings.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images&icons.dart';
import '../../controller/registration_controller/upload_selfie_controller.dart';
import '../../reusable_widgets/common_back_header.dart';
import '../../reusable_widgets/custom_button.dart';
import '../../reusable_widgets/custom_text.dart';

class UploadSelfieScreen extends StatefulWidget {
  const UploadSelfieScreen({super.key});

  @override
  _UploadSelfieScreenState createState() => _UploadSelfieScreenState();
}

class _UploadSelfieScreenState extends State<UploadSelfieScreen>
    with SingleTickerProviderStateMixin {
  final _controller = Get.put(UploadSelfieController());
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          Padding(
            padding:const EdgeInsets.only(left: 10, right: 10, ),
            child: Center(
              child: Container(
                margin: const EdgeInsets.only(top: 35),
                decoration: BoxDecoration(
                  color: AppColors.darkGrey.withOpacity(0.9),
                  borderRadius:  BorderRadius.circular(20)
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    child: GetBuilder<UploadSelfieController>(
                      init: _controller,
                      builder: (controller) {
                        return Column(
                          children: [
                            const SizedBox(height: 30),
                            Center(
                              child: CustomText(
                                textName: AppStrings.takeSelfie,
                                fontSize: 20,
                                textColor: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ScaleTransition(
                                scale:
                                    Tween<double>(begin: 1.0, end: 1.1).animate(
                                  CurvedAnimation(
                                    parent: _animationController,
                                    curve: Curves.easeInOut,
                                  ),
                                ),
                                child: const CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      AssetImage(AppImages.userImage),
                                ),
                              ),
                            const SizedBox(height: 30),
                            const Center(
                              child: Text(
                                AppStrings.takeSelfie,
                                style: TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                                child: GestureDetector(
                              onTap: () {
                                // to Show options to pick from camera or gallery
                                showDialog(
                                  barrierColor: Colors.white.withOpacity(0.9),
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor:
                                          AppColors.black.withOpacity(0.7),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color: AppColors.lightOrange,
                                            width: 2),
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      title: Center(
                                        child: CustomText(
                                          textName:AppStrings.selectImageSource,
                                          fontSize: 20,
                                          textColor: AppColors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      content: SizedBox(
                                        height: Get.height * 0.15,
                                        child: Column(
                                          children: [
                                          const  SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                    _controller.pickImage(
                                                        ImageSource.camera);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.lightOrange
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Center(
                                                      child: CustomText(
                                                        textName: AppStrings.camera,
                                                        textColor:
                                                            AppColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                    _controller.pickImage(
                                                        ImageSource.gallery);
                                                  },
                                                  child: Container(
                                                    height: 40,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                      color: AppColors.lightOrange
                                                          .withOpacity(0.8),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Center(
                                                      child: CustomText(
                                                        textName: AppStrings.gallery,
                                                        textColor:
                                                            AppColors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                     
                                    );
                                  },
                                );
                              },
                              child: CircleAvatar(
                                radius: 35,
                                backgroundColor: AppColors.white.withOpacity(0.7),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: AppColors.lightOrange,
                                  child: CustomText(
                                    textName: AppStrings.tap,
                                    fontSize: 14,
                                    textColor: AppColors.white,
                                  ),
                                ),
                              ),
                            )),
                            const SizedBox(height: 30),
                            if (controller.selfieImage != null)
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 35, bottom: 50),
                                child: AnimatedOpacity(
                                  opacity: _fadeAnimation.value,
                                  duration: const Duration(milliseconds: 500),
                                  child:_controller.isLoading?Center(child: CircularProgressIndicator(color: AppColors.white,),): CustomButton(
                                    onPressed: () {
                                      _controller.uploadProfilePicture();
                                    },
                                    textName: AppStrings.uploadSelfie,
                                    fontSize: 17,
                                    color: AppColors.lightOrange.withOpacity(0.9),
                                    textColor: AppColors.white,
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CommonBackHeader(),
          ),
        ],
      ),
    );
  }
}
