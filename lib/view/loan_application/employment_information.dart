// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/loan_application/employment_information_controller.dart';
import 'package:qualoan/reusable_widgets/common_back_header.dart';
import 'package:qualoan/reusable_widgets/custom_button.dart';
import 'package:qualoan/reusable_widgets/custom_text_field.dart';
import '../../constants/app_images&icons.dart';
import '../../reusable_widgets/custom_text.dart';

class EmploymentInformation extends StatelessWidget {
  EmploymentInformation({super.key});

  final _controller = Get.put(EmploymentInformationController());
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(children: [
        const Positioned(top: 0, left: 0, right: 0, child: CommonBackHeader()),
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.2),
          child: GetBuilder<EmploymentInformationController>(
            init: _controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: CustomText(
                    textName: "EMPLOYMENT INFORMATION",
                    textColor: AppColors.darkGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: CustomText(
                      textName:
                          "Provide the All required details about your company",
                      fontSize: 17,
                      overflow: TextOverflow.fade,
                      textColor: Colors.black,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
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
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Are you working from Office or Home?",
                                  overflow: TextOverflow.fade,
                                  textColor: AppColors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 9, left: 9, top: 8),
                                child: SizedBox(
                                  height: 60,
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: AppColors.darkGrey,
                                    value: _controller.selectedWorkingType,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.white,
                                        filled: true,
                                        hintText: AppStrings.select,
                                        labelStyle: const TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: _controller.workingTypeError != null
                                                  ? AppColors
                                                      .logoRedColor 
                                                  : AppColors.logoBlueColor,
                                              width: 1
                                              ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: const BorderSide(
                                              color: AppColors.black,
                                              width: 1
                                              ),
                                        )
                                        ),
                                    items: _controller.workingType
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return _controller.workingType
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
                                        _controller.selectedWorkingType =
                                            newValue;
                                        if (newValue != null) {
                                          _controller.workingTypeError = null;
                                        }
                                        _controller.validateFields();
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
                               if (_controller.workingTypeError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 10, top: 3),
                                  child: Text(
                                    _controller.workingTypeError,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color:
                                            Color.fromARGB(255, 201, 32, 20)),
                                  ),
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Company Name",
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.companyNameController,
                                keyboardType: TextInputType.name,
                                hintText: "Company Name",
                                filled: true,
                                fillColor: AppColors.white,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(Icons.merge_type_sharp,color: AppColors.grey,),
                                ),
                                errorText: _controller.employerNameError,
                                textCapitalization: true,
                                onChanged: (value) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Company Type",
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.companyTypeController,
                                keyboardType: TextInputType.name,
                                hintText: "Company Type",
                                filled: true,
                                fillColor: AppColors.white,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(Icons.merge_type_sharp,color: AppColors.grey,),
                                ),
                                errorText: _controller.companyTypeError,
                                textCapitalization: true,
                                onChanged: (value) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Employed Since Date",
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.employedSinceController,
                                keyboardType: TextInputType.name,
                                hintText: "Select Date ",
                                filled: true,
                                fillColor: AppColors.white,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Icon(Icons.calendar_month,color: AppColors.grey,),
                                ),
                                errorText: _controller.employedSinceError,
                                textCapitalization: true,
                                onTap: () async{
                                      await  _controller.selectDate(context);
                                      },
                                onChanged: (value) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Official Email",
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.officialEmailController,
                                hintText: AppStrings.email,
                                textCapitalization: true,
                                keyboardType: TextInputType.emailAddress,
                                filled: true,
                                fillColor: AppColors.white,
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: AppColors.grey,
                                ),
                                errorText: _controller.emailError,
                                onChanged: (value) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Designation",
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.designationController,
                                keyboardType: TextInputType.name,
                                hintText: "Designation",
                                filled: true,
                                fillColor: AppColors.white,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    AppImages.designationIcon,
                                    color: AppColors.grey,
                                    height: 15,
                                  ),
                                ),
                                errorText: _controller.designationError,
                                textCapitalization: true,
                                onChanged: (value) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Office Address",
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.officeAddressController,
                                hintText: "Office Address",
                                textCapitalization: true,
                                filled: true,
                                fillColor: AppColors.white,
                                keyboardType: TextInputType.name,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    AppImages.officeAddressIcon,
                                    color: AppColors.grey,
                                    height: 15,
                                  ),
                                ),
                                errorText: _controller.officeAddressError,
                                onChanged: (value) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: AppStrings.addressLandmark,
                                  textColor: AppColors.white,
                                  fontSize: 15,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.officeLandmarkController,
                                hintText: AppStrings.landmark,
                                errorText: controller.landmarkError,
                                filled: true,
                                prefixIcon: const Icon(Icons.landscape,color: AppColors.grey,),
                                fillColor: AppColors.white,
                                onChanged: (p0) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, bottom: 10),
                                child: CustomText(
                                  textName: AppStrings.pincode,
                                  textColor: AppColors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(6, (index) {
                                  return Container(
                                    width: 40,
                                    height: 45,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: TextField(
                                      focusNode:
                                          _controller.focusNodes[index],
                                      controller: 
                                      _controller.pincodeControllers[index],

                                      inputFormatters: [
                                        FilteringTextInputFormatter(
                                            RegExp("[0-9]"),
                                            allow: true)
                                      ],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      maxLength: 1, 
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: AppColors.black,
                                              width: 1,
                                            )),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                              color: AppColors.logoRedColor,
                                              width: 1,
                                            )),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: AppColors.black,
                                            width: 1,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: AppColors.white,
                                        counterText: "",
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        _controller.onOtpChanged(
                                            value, index);

                                        _controller.validateFields();
                                        _controller.update();
                                      },
                                    ),
                                  );
                                }),
                              ),
                              if (_controller.pinCodeError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 10, top: 3),
                                  child: Text(
                                    _controller.pinCodeError!,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color:
                                            Color.fromARGB(255, 201, 32, 20)),
                                  ),
                                ),
                              const SizedBox(height: 20),                     
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: CustomText(
                                  textName: AppStrings.cityName,
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.cityNameController,
                                enabled: false,
                                hintText: AppStrings.city,
                                errorText: _controller.cityError,
                                filled: true,
                                fillColor: AppColors.white,
                                onChanged: (p0) {
                                  _controller.validateFields();
                                  
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 15),
                                child: CustomText(
                                  textName: AppStrings.stateName,
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.stateNameController,
                                errorText: _controller.stateError,
                                enabled: false,
                                hintText: AppStrings.state,
                                filled: true,
                                fillColor: AppColors.white,
                                onChanged: (p0) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              const SizedBox(height: 30),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, bottom: 50),
                                child:_controller.isLoading? const Center(child: CircularProgressIndicator(color: AppColors.white,),)  : CustomButton(
                                  onPressed: () {
                                    _controller
                                        .validateFields(); 
                                    if (_controller.isValid) {
                                      _controller.submitEmploymentDetails(); 
                                    } else {
                                      Get.snackbar(
                                        'Validation Error',
                                        'Please fix the errors before submitting.',
                                        backgroundColor: AppColors.logoRedColor,
                                        colorText: Colors.white,
                                      );
                                    }
                                  },
                                  textName: _controller.isUpdated ? "UPDATE" : AppStrings.submit,
                                  fontSize: 17,
                                  color: AppColors.lightOrange.withOpacity(0.9),
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
