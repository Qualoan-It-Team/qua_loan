// ignore_for_file: deprecated_member_use

import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_images&icons.dart';
import 'package:app_here/controller/bank_details_controller.dart';
import 'package:app_here/reusable_widgets/custom_app_bar.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:app_here/reusable_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../reusable_widgets/custom_button.dart';

class BankDetailsVerification extends StatelessWidget {
  BankDetailsVerification({super.key});
  final _controller = Get.put(BankDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Bank Details",
          forceMaterialTransparency: true,
          icon: Icons.arrow_back_ios,
          leftPadding: 25,
          height: Get.height * 0.18,
        ),
        body: GetBuilder<BankDetailsController>(
            init: BankDetailsController(),
            builder: (controller) {
              return SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: CustomText(
                          textName:
                              "Enter your IFSC code so we can fetch your Bank name and Branch type and also fill your Account Number and Account Holder Name",
                          overflow: TextOverflow.fade,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          textColor: AppColors.black,
                        ),
                      ),
                      const SizedBox(height: 15),
                      
                      CustomTextField(
                        textCapitalization: false,
                        controller: _controller.ifscCodeController,
                        errorText: _controller.ifscCodeError,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp("[0-9A-Z]"),
                              allow: true)
                        ],
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppImages.ifscCodeIcon,
                            height: 5,
                          ),
                        ),
                        labelText: "IFSC Code",
                        enabled: controller.isVerified ? false : true,
                        onChanged: (value) {
                          _controller.fetchBankDetails(value);
                          _controller.validateFields();
                        },
                      ),
                      const SizedBox(height: 15),
                      // drop down for bank
                      if (controller.ifscCodeSuggestions.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(left: 15,right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.logoBlueColor)
                            ),
                            height: 100, // Set a fixed height for the dropdown
                            child: ListView.builder(
                              itemCount: controller.ifscCodeSuggestions.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title:
                                      Text(controller.ifscCodeSuggestions[index]),
                                  onTap: () {
                                    _controller.ifscCodeController.text =
                                        controller.ifscCodeSuggestions[index];
                          
                                    // Find the selected bank details based on the selected IFSC code
                                    var selectedBankDetails =
                                        controller.bankDetailsList.firstWhere(
                                            (item) =>
                                                item['bank_ifsc'] ==
                                                controller
                                                    .ifscCodeSuggestions[index],
                                            orElse: () =>
                                                {} // Provide a default value to avoid errors
                                            );
                          
                                    // Check if selectedBankDetails is not empty
                                    if (selectedBankDetails.isNotEmpty) {
                                      _controller.bankNameController.text =
                                          selectedBankDetails['bank_name'] ?? '';
                                      _controller.branchNameController.text =
                                          selectedBankDetails['bank_branch'] ??
                                              '';
                                    } else {
                                      _controller.bankNameController.clear();
                                      _controller.branchNameController.clear();
                                    }
                          
                                    _controller.ifscCodeSuggestions.clear();
                                    _controller.update();
                                  },
                                );
                              },
                            ),
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
                          ),
                        ),
                        // const Icon(Icons.person_2_rounded,
                        // color: AppColors.logoRedColor),
                        filled: true,
                        onTapReadOnly: false,
                        readOnly: true,
                        fillColor: const Color.fromARGB(255, 239, 237, 237),
                        labelText: "Bank Name",
                        onChanged: (value) {
                          _controller.validateFields();
                        },
                        // onTapReadOnly: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        enabled: false,
                        controller: _controller.branchNameController,
                        errorText: _controller.branchNameError,
                        keyboardType: TextInputType.name,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppImages.branchNameIcon,
                            height: 15,
                          ),
                        ),
                        onTapReadOnly: false,
                        readOnly: true,
                        labelText: "Branch Name",
                        filled: true,
                        fillColor: const Color.fromARGB(255, 239, 237, 237),
                        onChanged: (value) {
                          _controller.validateFields();
                        },
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        controller: _controller.accountNumberController,
                        errorText: _controller.accountNumberError,
                        enabled: controller.isVerified ? false : true,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp("[0-9]"),
                              allow: true)
                        ],
                        keyboardType: TextInputType.number,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppImages.accountNumbertIcon,
                            height: 5,
                            color: AppColors.green,
                          ),
                        ),
                        // prefixIcon: const Icon(Icons.person_2_rounded,
                        // color: AppColors.logoRedColor),
                        labelText: "Bank Account Number",
                        onChanged: (value) {
                          _controller.validateFields();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        textCapitalization: true,
                        controller: _controller.accountHolderNameController,
                        enabled: controller.isVerified ? false : true,
                        errorText: _controller.accountHolderNameError,
                        inputFormatters: [
                          FilteringTextInputFormatter(RegExp("[a-z A-z]"),
                              allow: true)
                        ],
                        keyboardType: TextInputType.name,
                        prefixIcon:  Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppImages.personIcon,
                            height: 5,
                          ),
                        ),
                        labelText: "Account Holder Name",
                        onChanged: (value) {
                          _controller.validateFields();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // drop down
                      Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 15, left: 15),
                            child: SizedBox(
                              height: 50,
                              child: DropdownButtonFormField<String>(
                                value: controller.selecteAccountType,
                                decoration: InputDecoration(
                                  enabled: !_controller
                                      .isVerified, // Enable or disable based on verification
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors
                                            .logoBlueColor), // Border color
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors
                                            .logoBlueColor,width: 1.5), // Border color when focused
                                  ) ,
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors
                                            .logoBlueColor), // Border color when focused
                                  ),
                                  labelText: "Select Account Type",
                                  labelStyle: const TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                  ),
                                  prefixIcon: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SvgPicture.asset(
                            AppImages.accountTypeIcon,
                            height: 5,
                          )),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.logoBlueColor,
                                        width: 1), // Border color when enabled
                                  ),
                                ),
                                items:
                                    controller.accountTypeOptions.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: _controller.isVerified
                                    ? null
                                    : (String? newValue) {
                                        controller.selecteAccountType = newValue;
                                        controller
                                            .update(); // Update the controller
                                      },
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.green,
                                ),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                      // CustomTextField(
                      //   textCapitalization: true,
                      //   controller: _controller.accountTypeController,
                      //   enabled: controller.isVerified ? false : true,
                      //   inputFormatters: [
                      //     FilteringTextInputFormatter(RegExp("[a-zA-z]"),
                      //         allow: true)
                      //   ],
                      //   keyboardType: TextInputType.name,
                      //   errorText: _controller.accountTypeError,
                      //   prefixIcon: SvgPicture.asset(
                      //     AppImages.accountTypeIcon,
                      //     height: 5,
                      //     color: AppColors.green,
                      //   ),
                      //   labelText: "Account Type:",
                      //   onChanged: (value) {
                      //     _controller.validateFields();
                      //   },
                      // ),
                      const SizedBox(
                        height: 35,
                      ),
                      if (_controller.isLoading)
                        const Center(
                            child: CircularProgressIndicator(
                          color: AppColors.black,
                        ))
                      else
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: CustomButton(
                            onPressed: () {
                              if (_controller.isVerified) {
                                // Call the submit method if verified
                                _controller.submitBankDetails();
                              } else {
                                _controller.validateFields();
                                if (_controller.bankNameError == null &&
                                    _controller.accountNumberError == null &&
                                    _controller.accountHolderNameError ==
                                        null &&
                                    _controller.branchNameError == null &&
                                    _controller.ifscCodeError == null &&
                                    _controller.accountTypeError == null) {
                                  _controller.verifyBankAccount();
                                }
                              }
                            },
                            textName: controller.isVerified
                                ? "Submit"
                                : "Verify Bank Details",
                            fontSize: 18,
                            color: AppColors.black,
                            textColor: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ]),
              ));
            }));
  }
}
