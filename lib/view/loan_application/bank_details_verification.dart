// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/controller/loan_application/bank_details_controller.dart';
import 'package:qualoan/reusable_widgets/common_back_header.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/reusable_widgets/custom_text_field.dart';
import '../../reusable_widgets/custom_button.dart';

class BankDetailsVerification extends StatelessWidget {
  BankDetailsVerification({super.key});

  final _controller = Get.put(BankDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        const Positioned(top: 0, left: 0, right: 0, child: CommonBackHeader()),
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.2),
          child: GetBuilder<BankDetailsController>(
            init: _controller,
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                      child: CustomText(
                    textName: "BANK DETAILS",
                    textColor: AppColors.darkGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  )),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: CustomText(
                      textName: "Share your all Bank details",
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
                                  textName: "Account Holder Name",
                                  overflow: TextOverflow.fade,
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                textCapitalization: true,
                                controller:
                                    _controller.accountHolderNameController,
                                errorText: _controller.accountHolderNameError,
                                filled: true,
                                fillColor: AppColors.white,
                                inputFormatters: [
                                  FilteringTextInputFormatter(
                                      RegExp("[a-z A-z]"),
                                      allow: true)
                                ],
                                keyboardType: TextInputType.name,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    AppImages.personIcon,
                                    color: AppColors.grey,
                                    height: 5,
                                  ),
                                ),
                                hintText: "Account Holder Name",
                                onChanged: (value) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Account Number",
                                  overflow: TextOverflow.fade,
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.accountNumberController,
                                errorText: _controller.accountNumberError,
                                filled: true,
                                fillColor: AppColors.white,
                                inputFormatters: [
                                  FilteringTextInputFormatter(RegExp("[0-9]"),
                                      allow: true),
                                      LengthLimitingTextInputFormatter(14),
                                ],
                                keyboardType: TextInputType.number,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    AppImages.accountNumbertIcon,
                                    height: 5,
                                    color: AppColors.grey,
                                  ),
                                ),
                                hintText: "Account Number",
                                onChanged: (value) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: " Confirm Account Number",
                                  overflow: TextOverflow.fade,
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                controller: _controller.confirmNumberController,
                                errorText: _controller.confirmAccountNumberError,
                                filled: true,
                                fillColor: AppColors.white,
                                inputFormatters: [
                                  FilteringTextInputFormatter(RegExp("[0-9]"),
                                      allow: true),
                                      LengthLimitingTextInputFormatter(14),
                                ],
                                keyboardType: TextInputType.number,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    AppImages.accountNumbertIcon,
                                    height: 5,
                                    color: AppColors.grey,
                                  ),
                                ),
                                // prefixIcon: const Icon(Icons.person_2_rounded,
                                // color: AppColors.logoRedColor),
                                hintText: "Account Number",
                                onChanged: (value) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "IFSC Code",
                                  overflow: TextOverflow.fade,
                                  textColor: AppColors.white,
                                ),
                              ),

                              CustomTextField(
                                textCapitalization: false,
                                controller: _controller.ifscCodeController,
                                filled: true,
                                fillColor: AppColors.white,
                                errorText: _controller.ifscCodeError,
                                inputFormatters: [
                                  FilteringTextInputFormatter(
                                      RegExp("[0-9A-Z]"),
                                      allow: true),
                                       LengthLimitingTextInputFormatter(11),
                                ],
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    AppImages.ifscCodeIcon,
                                    color: AppColors.grey,
                                    height: 5,
                                  ),
                                ),
                                hintText: "IFSC Code",
                                onChanged: (value) {
                                  _controller.fetchBankDetails(value);
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              const SizedBox(height: 10),

                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Bank Name",
                                  overflow: TextOverflow.fade,
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                enabled: false,
                                controller: _controller.bankNameController,
                                errorText: _controller.bankNameError,
                                textCapitalization: true,
                                keyboardType: TextInputType.name,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    AppImages.bankIcon,
                                    height: 5,
                                    color: AppColors.grey,
                                  ),
                                ),
                                filled: true,
                                // onTapReadOnly: false,
                                // readOnly: true,
                                fillColor: AppColors.white,
                                hintText: "Bank Name",
                                onChanged: (value) {
                                  _controller.validateFields();
                                   _controller.update();
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Branch Name",
                                  overflow: TextOverflow.fade,
                                  textColor: AppColors.white,
                                ),
                              ),
                              CustomTextField(
                                enabled: false,
                                controller: _controller.branchNameController,
                                errorText: _controller.branchNameError,
                                keyboardType: TextInputType.name,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset(
                                    AppImages.ifscCodeIcon,
                                    height: 15,
                                    color: AppColors.grey,
                                  ),
                                ),
                                // onTapReadOnly: false,
                                // readOnly: true,
                                hintText: "Branch Name",
                                filled: true,
                                fillColor: AppColors.white,
                                onChanged: (value) {
                                  _controller.validateFields();
                                  _controller.update();
                                },
                              ),
                              const SizedBox(height: 15),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, top: 20),
                                child: CustomText(
                                  textName: "Select Account Type",
                                  overflow: TextOverflow.fade,
                                  textColor: AppColors.white,
                                ),
                              ),

                              // drop down
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, right: 15, left: 15),
                                child: SizedBox(
                                  height: 50,
                                  child: DropdownButtonFormField<String>(
                                    value: controller.selecteAccountType,
                                    decoration: InputDecoration(
                                      fillColor: AppColors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: AppColors.logoBlueColor),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: AppColors.logoBlueColor,
                                            width: 1.5),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                            color: AppColors.logoBlueColor),
                                      ),
                                      hintText: "Select Account Type",
                                      hintStyle: const TextStyle(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                      prefixIcon: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SvgPicture.asset(
                                            AppImages.accountTypeIcon,
                                            color: AppColors.grey,
                                            height: 5,
                                          )),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:  BorderSide(
                                            color: _controller.accountTypeError != null ? AppColors.logoRedColor
                                                        : AppColors.black,
                                                    width: 1),
                                      ),
                                    ),
                                    items: controller.accountTypeOptions
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                     onChanged: (value) {
                                            _controller.selecteAccountType =
                                                value;
                                            _controller.validateFields();
                                            _controller.update();
                                          },
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      color: AppColors.black,
                                    ),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                               if (_controller.accountTypeError != null)
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 10, top: 3),
                                  child: Text(
                                    _controller.accountTypeError,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color:
                                            Color.fromARGB(255, 201, 32, 20)),
                                  ),
                                ),
                              const SizedBox(
                                height: 35,
                              ),
                              // if (_controller.isLoading)
                              //   const Center(
                              //       child: CircularProgressIndicator(
                              //     color: AppColors.black,
                              //   ))
                              // else
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15),
                                  child:_controller.isLoading?Center(child:CircularProgressIndicator(color: AppColors.white)): CustomButton(
                                    onPressed: () {
                                      _controller.validateFields();
                                      _controller.update();
                                      if (_controller.isValid) {
                                        _controller.submitBankDetails();
                                      } else {
                                        Get.snackbar(
                                            backgroundColor:
                                                AppColors.logoRedColor,
                                            colorText: AppColors.white,
                                            "Validation Error",
                                            "Please fill all required fields correctly.");
                                      }
                                    },
                                    textName: "Submit",
                                    fontSize: 18,
                                    color:
                                        AppColors.lightOrange.withOpacity(0.8),
                                    textColor: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
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
