// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/registration_controller/address_informationa_controller.dart';
import 'package:qualoan/reusable_widgets/custom_button.dart';
import 'package:qualoan/reusable_widgets/custom_text_field.dart';
import '../../reusable_widgets/common_back_header.dart';
import '../../reusable_widgets/custom_text.dart';

class AddressInformation extends StatelessWidget {
  AddressInformation({super.key});
  final _controller = Get.put(AddressInformationController());
  @override
  Widget build(BuildContext context) {
    // _controller.resetErrors();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(children: [
        const Positioned(top: 0, left: 0, right: 0, child: CommonBackHeader()),
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.2),
          child: GetBuilder<AddressInformationController>(
              init: _controller,
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                        child: CustomText(
                      textName: AppStrings.currentResidenceAddress,
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
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: AppColors.darkGrey.withOpacity(0.9),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: CustomText(
                                    textName: AppStrings.address,
                                    fontSize: 15,
                                    textColor: AppColors.white,
                                  ),
                                ),
                                CustomTextField(
                                  controller: _controller.addressController,
                                  textCapitalization: true,
                                  hintText: AppStrings.address,
                                  filled: true,
                                  errorText: _controller.addressError,
                                  fillColor: AppColors.white,
                                  prefixIcon: const Icon(Icons.location_on),
                                  onChanged: (p0) {
                                    _controller.validateFields();
                                    _controller.update();
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 12),
                                  child: CustomText(
                                    textName: AppStrings.addressLandmark,
                                    textColor: AppColors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                CustomTextField(
                                  controller: _controller.landmarkController,
                                  textCapitalization: true,
                                  hintText: AppStrings.landmark,
                                  errorText: controller.landmarkError,
                                  filled: true,
                                  prefixIcon: const Icon(Icons.location_city),
                                  fillColor: AppColors.white,
                                  onChanged: (p0) {
                                    _controller.validateFields();
                                    _controller.update();
                                  },
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, bottom: 10),
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
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: TextField(
                                        focusNode:
                                            _controller.focusNodes[index],
                                        controller: _controller
                                            .pincodeControllers[index],

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
                                  controller: _controller.cityController,
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
                                  controller: _controller.stateController,
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
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: CustomText(
                                    textName: AppStrings.residenceType,
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
                                      value: _controller.selectedResidenceType,
                                      decoration: InputDecoration(
                                          fillColor: AppColors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color : AppColors.logoBlueColor),
                                          ),
                                          
                                          hintText: AppStrings.select,
                                          labelStyle: const TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: _controller.recidentTypeError != null
                                                    ? AppColors
                                                        .logoRedColor 
                                                    : AppColors.black,
                                                width: 1 
                                                ),
                                          )),
                                      items: _controller.recidenceOptions
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      selectedItemBuilder:
                                          (BuildContext context) {
                                        return _controller.recidenceOptions
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
                                        _controller.selectedResidenceType =
                                            newValue;
                                        if (newValue != null) {
                                          _controller.recidentTypeError = null;
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
                                if (_controller.recidentTypeError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 10, top: 3),
                                    child: Text(
                                      _controller.recidentTypeError!,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(255, 201, 32, 20)),
                                    ),
                                  ),
                                   Padding(
                                  padding: const EdgeInsets.only(left: 15,top: 15),
                                  child: CustomText(
                                    textName: AppStrings.residingSince,
                                    textColor: AppColors.white,
                                  ),
                                ),
                                 CustomTextField(
                                  controller: _controller.residingSinceController,
                                  textCapitalization: true,
                                  hintText: AppStrings.select,
                                  readOnly: true,
                                  filled: true,
                                  suffixIcon: const Icon(Icons.calendar_month_outlined,color: AppColors.darkGrey,),
                                  errorText: _controller.residingSinceError,
                                  fillColor: AppColors.white,
                                  prefixIcon: const Icon(Icons.location_on),
                                   onTap: () {
                                        _controller.selectDate(context);
                                      },
                                      onChanged: (p0) {
                                        _controller.validateFields();
                                        _controller.update();
                                      },
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12, right: 12),
                                  child: _controller.isLoading?const Center(child:  CircularProgressIndicator(color: AppColors.white,),) :CustomButton(
                                    onPressed: () {
                                      _controller.validateFields();
                                      if (_controller.isValid) {
                                        _controller.updateAddress();
                                      } else {
                                        Get.snackbar(
                                            backgroundColor:
                                                AppColors.logoRedColor,
                                            colorText: AppColors.white,
                                            AppStrings.validationError,
                                            AppStrings.fillAllRequiredFields);
                                      }
                                    },
                                    textName:_controller.isUpdated?"UPDATE":AppStrings.submit,
                                    fontSize: 17,
                                    color:
                                        AppColors.lightOrange.withOpacity(0.9),
                                    textColor: AppColors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              }),
        )
      ]),
    );
  }
}
