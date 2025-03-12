// ignore_for_file: must_be_immutable, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/personal_information_controller.dart';
import 'package:qualoan/reusable_widgets/custom_button.dart';
import 'package:qualoan/reusable_widgets/custom_text_field.dart';
import '../../reusable_widgets/common_back_header.dart';
import '../../reusable_widgets/custom_text.dart';

class PersonalInformation extends StatelessWidget {
  PersonalInformation({super.key});

  final _controller = Get.put(PersonalInformationController());

//  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(children: [
        const Positioned(top: 0, left: 0, right: 0, child: CommonBackHeader()),
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.2),
          child: GetBuilder<PersonalInformationController>(
            init: _controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: CustomText(
                    textName: AppStrings.personalInformationCapitalized,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
                  Expanded(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 15),
                          decoration: BoxDecoration(
                              color: AppColors.darkGrey.withOpacity(0.9),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: CustomText(
                                  textName: AppStrings.yourName,
                                  textColor: AppColors.white,
                                ),
                              ),
                              SizedBox(
                                child: _controller.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.white,
                                      ))
                                    : CustomTextField(
                                        controller:
                                            _controller.fullNameController,
                                        hintText: AppStrings.fullName,
                                        enabled: false,
                                        filled: true,
                                        errorText: _controller.fullNameError,
                                        fillColor: AppColors.white,
                                        prefixIcon: const Icon(Icons.person),
                                        onChanged: (value) {
                                          _controller.validateInputs();
                                        },
                                      ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: CustomText(
                                  textName: AppStrings.motherName,
                                  textColor: AppColors.white,
                                ),
                              ),
                              SizedBox(
                                child: _controller.isLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                        color: AppColors.white,
                                      ))
                                    : CustomTextField(
                                        controller:
                                            _controller.mothersNameController,
                                            textCapitalization: true,
                                        hintText: AppStrings.motherName,
                                        errorText: _controller.mothersNameError,
                                        fillColor: AppColors.white,
                                        filled: true,
                                        prefixIcon: const Icon(Icons.person),
                                        onChanged: (value) {
                                          _controller.validateInputs();
                                        },
                                      ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: CustomText(
                                  textName: AppStrings.personalEmail,
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.emailController,
                                hintText: AppStrings.email,
                                filled: true,
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: AppColors.grey,
                                ),
                                errorText: controller.emailError,
                                fillColor: AppColors.white,
                                onChanged: (value) {
                                  _controller.validateInputs();
                                },
                              ),
                              const SizedBox(height: 20),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: CustomText(
                                          textName: AppStrings.dateOfBirth,
                                          textColor: AppColors.white,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 65,
                                          width: 175,
                                          child: _controller.isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: AppColors.white,
                                                ))
                                              : CustomTextField(
                                                  controller:
                                                      _controller.dobController,
                                                  errorText:
                                                      controller.dobError,
                                                  hintText: AppStrings.dob,
                                                  enabled: false,
                                                  filled: true,
                                                  prefixIcon: const Icon(Icons
                                                      .date_range_outlined),
                                                  fillColor: AppColors.white,
                                                  onChanged: (value) {
                                                    _controller
                                                        .validateInputs();
                                                  },
                                                )),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12),
                                        child: CustomText(
                                          textName: AppStrings.gender,
                                          textColor: AppColors.white,
                                        ),
                                      ),
                                      SizedBox(
                                          height: 65,
                                          width: 120,
                                          child: _controller.isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: AppColors.white,
                                                ))
                                              : CustomTextField(
                                                  controller:
                                                      TextEditingController(
                                                          text: _controller
                                                              .selectedGender),
                                                  hintText: AppStrings.gender,
                                                  enabled: false,
                                                  errorText:
                                                      controller.genderError,
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            9.0),
                                                    child: SvgPicture.asset(
                                                      AppImages.genderIcon,
                                                      color: AppColors.grey,
                                                      height: 5,
                                                    ),
                                                  ),
                                                  filled: true,
                                                  fillColor: AppColors.white,
                                                  onChanged: (value) {
                                                    _controller
                                                        .validateInputs();
                                                        
                                                  },
                                                )),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: CustomText(
                                  textName: AppStrings.maritalStatus,
                                  textColor: AppColors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8, right: 10, left: 10),
                                child: SizedBox(
                                  height: 60,
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: AppColors.darkGrey,
                                    value: _controller.maritalStatus.isNotEmpty
                                        ? _controller.maritalStatus
                                        : null,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),

                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: AppColors.logoBlueColor,
                                            )),
                                        hintText: AppStrings.select,
                                        labelStyle: const TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: _controller.maritalstatusError != null
                                                  ? AppColors
                                                      .logoRedColor 
                                                  : AppColors.logoBlueColor,
                                              width: 1
                                              ),
                                        )),
                                    items: _controller.maritalStatusOptions
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return _controller.maritalStatusOptions
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    onChanged: (String? newValue) {
                                      _controller.maritalStatus = newValue!;
                                      _controller.update();
                                      _controller.validateInputs();
                                    },
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.orangeLogoColor,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              if (_controller.maritalstatusError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 10, top: 3),
                                  child: Text(
                                    _controller.maritalstatusError,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color:
                                            Color.fromARGB(255, 201, 32, 20)),
                                  ),
                                ),
                              if (_controller.maritalStatus ==
                                  AppStrings.marriedText)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 20),
                                      child: CustomText(
                                        textName: AppStrings.spouseName,
                                        textColor: AppColors.white,
                                      ),
                                    ),
                                    CustomTextField(
                                      controller:
                                          _controller.spouseNameController,
                                      hintText: AppStrings.spouseName,
                                      filled: true,
                                      errorText: controller.spouseNameError,
                                      prefixIcon: const Icon(Icons.person),
                                      fillColor: AppColors.white,
                                      onChanged: (p0) {
                                        controller.validateInputs();
                                      },
                                    ),
                                  ],
                                ),

                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 50),
                                child: _controller.isLoadingButton
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      )
                                    : CustomButton(
                                        onPressed: () {
                                          
                                          _controller.validateInputs();
                                          controller.update();
                                          if (_controller.emailError == null &&
                                              _controller.fullNameError ==
                                                  null &&_controller.mothersNameError==null &&
                                              _controller.genderError == null &&
                                              _controller.dobError == null &&
                                              (_controller.spouseNameError ==
                                                      null ||
                                                  _controller.maritalStatus !=
                                                      AppStrings.marriedText)) {
                                            _controller.updatePersonalInfo();
                                          }
                                        },
                                        textName: AppStrings.submit,
                                        fontSize: 17,
                                        color: AppColors.lightOrange
                                            .withOpacity(0.9),
                                        textColor: AppColors.white,
                                      ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}
