// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/reusable_widgets/custom_button.dart';
import 'package:qualoan/reusable_widgets/custom_text_field.dart';
import '../../controller/registration_controller/income_information_controller.dart';
import '../../reusable_widgets/common_back_header.dart';
import '../../reusable_widgets/custom_text.dart';

class IncomeInformation extends StatelessWidget {
   IncomeInformation({super.key});
  final _controller = Get.put(IncomeInformationController());
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(children: [
          const CommonBackHeader(),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.2),
            child: GetBuilder<IncomeInformationController>(
                init: _controller,
                builder: (controller) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Center(
                            child: CustomText(
                          textName: AppStrings.incomeInformationCapital,
                          textColor: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 21,
                        )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 30),
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
                                    const SizedBox(height: 20),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: CustomText(
                                        textName: AppStrings.employeeType,
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

                                          value:
                                              _controller.selectedEmployeeType,
                                          decoration: InputDecoration(
                                              fillColor: AppColors.white,
                                              filled: true,
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                  color : AppColors.logoBlueColor, 
                                                )
                                              ),
                                              hintText: AppStrings.select,
                                              labelStyle: const TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
                                              // prefixIcon: Padding(
                                              //   padding: const EdgeInsets.all(7.0),
                                              //   child: SvgPicture.asset(
                                              //     AppImages.genderIcon,
                                              //     color: AppColors.orangeLogoColor,
                                              //     height: 5,
                                              //   ),
                                              // ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: _controller.selectedEmployeeTypeError != null
                                                        ? AppColors
                                                            .logoRedColor
                                                        : AppColors.black,
                                                    width: 1 
                                                    ),
                                              )),
                                          items: _controller.accountTypeOptions
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          selectedItemBuilder:
                                              (BuildContext context) {
                                            return _controller
                                                .accountTypeOptions
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
                                            _controller.selectedEmployeeType =
                                                newValue;
                                            _controller.validateFields();
                                            _controller.update();
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
                                    if (_controller.selectedEmployeeTypeError !=
                                        null)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 10, top: 3),
                                        child: Text(
                                          _controller
                                              .selectedEmployeeTypeError!,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 201, 32, 20)),
                                        ),
                                      ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: CustomText(
                                        textName: AppStrings.monthlyIncome,
                                        textColor: AppColors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    CustomTextField(
                                      controller: _controller.salaryController,
                                      hintText: AppStrings.salary,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter(
                                            RegExp("[0-9]"),
                                            allow: true)
                                      ],
                                      errorText: _controller.salaryError,
                                      filled: true,
                                      prefixIcon: const Icon(Icons.monetization_on_rounded),
                                      fillColor: AppColors.white,
                                      onChanged: (p0) {
                                        _controller.validateFields();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 20),
                                      child: CustomText(
                                        textName: AppStrings.obligation,
                                        fontSize: 14,
                                        textColor: AppColors.white,
                                      ),
                                    ),
                                    CustomTextField(
                                      controller:
                                          _controller.obligationController,
                                      textCapitalization: true,
                                      keyboardType: TextInputType.number,
                                      hintText: AppStrings.obligation,
                                      inputFormatters: [
                                        FilteringTextInputFormatter(
                                            RegExp("[0-9]"),
                                            allow: true)
                                      ],
                                      errorText: _controller.obligationError,
                                      filled: true,
                                      fillColor: AppColors.white,
                                      prefixIcon: const Icon(Icons.monetization_on_rounded),
                                      onChanged: (p0) {
                                        _controller.validateFields();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 20),
                                      child: CustomText(
                                        textName: AppStrings.nextSalaryDate,
                                        fontSize: 14,
                                        textColor: AppColors.white,
                                      ),
                                    ),
                                    CustomTextField(
                                      controller: _controller.nextSalaryController,
                                      filled: true,
                                      errorText: _controller.dobError,
                                      fillColor: AppColors.white,
                                      readOnly: true,
                                      prefixIcon: const Icon(
                                          Icons.calendar_month_rounded,
                                          color: AppColors.darkGrey),
                                      hintText: AppStrings.dateFormateType,
                                      onTap: () async{
                                      await  _controller.selectDate(context,firstDate: DateTime.now(),purpose: 'nextSalary',lastDate: DateTime.now().add( const Duration(days: 365)));
                                      },
                                      onChanged: (p0) {
                                        _controller.validateFields();
                                      },
                                    ),
                                    //working since 
                                     Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, top: 20),
                                      child: CustomText(
                                        textName: AppStrings.workingSinceDate,
                                        fontSize: 14,
                                        textColor: AppColors.white,
                                      ),
                                    ),
                                    CustomTextField(
                                      // enabled: false,
                                      controller: _controller.workingSinceController,
                                      filled: true,
                                      errorText: _controller.workingSinceError,
                                      fillColor: AppColors.white,
                                       readOnly: true,
                                      
                                      prefixIcon: const Icon(
                                          Icons.calendar_month_rounded,
                                          color: AppColors.darkGrey),

                                      hintText: AppStrings.dateFormateType,
                                      onTap: ()async {
                                       await _controller.selectDate(context ,firstDate: DateTime(1900),purpose: 'workingSince',lastDate: DateTime.now());
                                      },
                                      onChanged: (p0) {
                                        _controller.validateFields();
                                      },
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 13, top: 20),
                                      child: CustomText(
                                        textName: AppStrings.modeOfIncome,
                                        fontSize: 14,
                                        textColor: AppColors.white,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Radio(
                                            value: 'BANK',
                                            groupValue:
                                                _controller.selectedMode,
                                            activeColor: AppColors.white
                                                .withOpacity(0.8),
                                            onChanged: (value) {
                                              _controller.selectedMode = value;
                                              _controller.update();
                                            },
                                          ),
                                          CustomText(
                                            textName: AppStrings.bank,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppColors.white,
                                          ),
                                          Radio(
                                            value: 'CASH',
                                            groupValue:
                                                _controller.selectedMode,
                                            activeColor: AppColors.white
                                                .withOpacity(0.8),
                                            onChanged: (value) {
                                              _controller.selectedMode = value;
                                              _controller.update();
                                            },
                                          ),
                                          CustomText(
                                            textName: AppStrings.cash,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppColors.white,
                                          ),
                                          Radio(
                                            value: 'CHEQUE',
                                            groupValue:
                                                _controller.selectedMode,
                                            activeColor: AppColors.white
                                                .withOpacity(0.8),
                                            onChanged: (value) {
                                              _controller.selectedMode = value;
                                              _controller.update();
                                            },
                                          ),
                                          CustomText(
                                            textName: AppStrings.check,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            textColor: AppColors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (_controller.selectedModeError != null)
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 10, top: 3),
                                        child: Text(
                                          _controller.selectedModeError!,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 201, 32, 20)),
                                        ),
                                      ),
                                    const SizedBox(height: 35),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12, right: 12),
                                      child:_controller.isLoading? const Center(child: CircularProgressIndicator(color: AppColors.white)): CustomButton(
                                        onPressed: () {
                                          _controller.validateFields();
                                          if (_controller.isValid) {
                                            _controller.submitIncomeDetails();
                                          } else {
                                            Get.snackbar(
                                                backgroundColor:
                                                    AppColors.logoRedColor,
                                                colorText: AppColors.white,
                                                AppStrings.validationError,
                                                AppStrings.fillAllRequiredFields);
                                          }
                                        },
                                        textName:_controller.isUpdated?AppStrings.updateText:AppStrings.submit,
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
                      ]);
                }),
          )
        ]));
  }
}
