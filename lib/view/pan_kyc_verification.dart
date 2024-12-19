// ignore_for_file: deprecated_member_use
import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_images&icons.dart';
import 'package:app_here/controller/pan_kyc_verification_controller.dart';
import 'package:app_here/reusable_widgets/custom_app_bar.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:app_here/reusable_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../reusable_widgets/custom_button.dart';

class PanKycVerification extends StatelessWidget {
  PanKycVerification({super.key});
  final _controller = Get.put(PanKycVerificationController());

  @override
  Widget build(BuildContext context) {
    // final _controller = Get.put(PanKycVerificationController());
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: " PAN KYC Verification",
        forceMaterialTransparency: true,
        icon: Icons.arrow_back_ios,
        leftPadding: 25,
        height: Get.height * 0.18,
      ),
      body: GetBuilder(
        init: _controller,
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 10),
                  child: Text(
                    "For the Loan your income profile should be salaried! let's confirm whether we have any offers on your PAN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
                  child: Container(
                    // width: Get.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 76, 76, 76),
                          spreadRadius: 0.5,
                          blurRadius: 3,
                          offset: Offset(0, 1),
                        ),
                      ],
                      color: Colors.white,
                      // color: AppColors.logoBlueColor
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15, right: 15, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextField(
                            textCapitalization: false,
                            controller: _controller.panController,
                            errorText: _controller.panError,
                            labelText: "PAN Card",
                            filled: true,
                            enabled: _controller.isVerified ? false : true,
                            fillColor: Colors.white,
                            prefixIcon: SvgPicture.asset(
                              AppImages.panCardIcon,
                              height: 5,
                            ),
                            // const Icon(Icons.card_travel_rounded,
                            //     color: AppColors.green),
                            onChanged: (value) {
                              if (value.length == 10) {
                                //   // Assuming PAN is 10 characters
                                // _controller.fetchPanDetails();
                              }
                              _controller.validateInputs();
                              // _controller.update();
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            textCapitalization: false,
                            // enabled: false,
                            enabled: _controller.isVerified ? false : true,
                            controller: _controller.firstNameController,
                            errorText: _controller.firstNameError,
                            inputFormatters: [
                              FilteringTextInputFormatter(RegExp("[a-z A-Z]"),
                                  allow: true)
                            ],
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                AppImages.personIcon,
                                height: 5,
                              ),
                            ),
                            labelText: "First Name",
                            onChanged: (value) {
                              _controller.validateInputs();
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            textCapitalization: false,
                            // enabled: false,
                            controller: _controller.lastNameController,
                            // errorText: _controller.lastNameError,
                            enabled: _controller.isVerified ? false : true,
                            inputFormatters: [
                              FilteringTextInputFormatter(RegExp("[a-z A-Z]"),
                                  allow: true)
                            ],
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                AppImages.personIcon,
                                height: 5,
                              ),
                            ),
                            labelText: "Last Name",
                            onChanged: (value) {
                              _controller.validateInputs();
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),

                          ///gender drop down
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8, right: 15, left: 15),
                            child: SizedBox(
                              height: 50,
                              child: DropdownButtonFormField<String>(
                                value: controller.selectedGender,
                                decoration: InputDecoration(
                                    enabled: !_controller
                                        .isVerified, // Enable or disable based on verification
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: _controller.genderError != null
                                              ? AppColors.logoRedColor
                                              : AppColors
                                                  .logoBlueColor), // Border color
                                    ),
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.logoBlueColor,
                                          width:
                                              1.5), // Border color when focused
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: _controller.genderError != null
                                              ? AppColors
                                                  .logoRedColor // Error color
                                              : AppColors
                                                  .logoBlueColor, // Border color when focused
                                        )),
                                    labelText: "Select Gender",
                                    labelStyle: const TextStyle(
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: SvgPicture.asset(
                                        AppImages.genderIcon,
                                        height: 5,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: _controller.genderError != null
                                              ? AppColors
                                                  .logoRedColor // Error color
                                              : AppColors.logoBlueColor,
                                          width: 1 // Border color when enabled
                                          ),
                                    )),
                                items: controller.genderOptions
                                    .map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: _controller.isVerified
                                    ? null
                                    : (String? newValue) {
                                        controller.selectedGender = newValue;
                                        controller.update();

                                        _controller.validateInputs();
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
                          if (_controller.genderError != null)
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 18, right: 10, top: 3),
                              child: Text(
                                _controller.genderError,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 201, 32, 20)),
                              ),
                            ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            // enabled: false,
                            controller: _controller.dobController,
                            errorText: _controller.dobError,
                            enabled: _controller.isVerified ? false : true,
                            prefixIcon: const Icon(Icons.calendar_month_rounded,
                                color: AppColors.green),
                            labelText: "DOB(As in Aadhaar)",
                            hintText: "dd/mm/yyyy",
                            onTap: () {
                              _controller.selectDate(context);
                            },
                            onChanged: (value) {
                              _controller.validateInputs();
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter(RegExp("[0-9]"),
                                  allow: true)
                            ],
                            controller: _controller.monthlyIncomeController,
                            enabled: _controller.isVerified ? false : true,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                AppImages.monthlyIncomeIcon,
                                height: 5,
                              ),
                            ),
                            labelText: "Monthly Income",
                            filled: true,
                            fillColor: Colors.white,
                            errorText: _controller.incomeError,
                            onChanged: (value) {
                              _controller.validateInputs();
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            keyboardType: TextInputType.number,
                            controller: _controller.loanAmountController,
                            enabled: _controller.isVerified ? false : true,
                            inputFormatters: [
                              FilteringTextInputFormatter(RegExp("[0-9]"),
                                  allow: true)
                            ],
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(7.0),
                              child: SvgPicture.asset(
                                AppImages.loanAmountIcon,
                                height: 5,
                              ),
                            ),
                            labelText: "Loan Amount ",
                            filled: true,
                            fillColor: Colors.white,
                            errorText: _controller.loanError,
                            onChanged: (value) {
                              _controller.validateInputs();
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            controller: _controller.emailController,
                            enabled: _controller.isVerified ? false : true,
                            prefixIcon:
                                const Icon(Icons.email, color: AppColors.green),
                            labelText: "Email(Personal)",
                            filled: true,
                            fillColor: Colors.white,
                            errorText: _controller.emailError,
                            onChanged: (value) {
                              _controller.validateInputs();
                            },
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (_controller.isLoading)
                  const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.black,
                  ))
                else
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: CustomButton(
                      onPressed: () {
                        if (_controller.isVerified) {
                          _controller.submitLoanApplication();
                        } else {
                          _controller.validateInputs();
                          if (_controller.panError == null &&
                              _controller.emailError == null &&
                              _controller.loanError == null &&
                              _controller.incomeError == null &&
                              _controller.firstNameError == null &&
                              _controller.genderError == null && 
                              _controller.dobError == null) {
                            _controller.fetchPanDetails();
                          }
                        }
                      },
                      textName:
                          _controller.isVerified ? "Submit" : "Verify Details",
                      fontSize: 18,
                      color: AppColors.black,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.green,
                    ),
                  ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          // backgroundColor: AppColors.logoBlueColor,
          // backgroundColor: Colors.green,
          backgroundColor: AppColors.green,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: AppColors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
                context: context,
                builder: (BuildContext context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: Get.height * 0.2,
                        width: Get.width,
                        decoration: const BoxDecoration(
                            // color: AppColors.logoBlueColor,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(60),
                                bottomRight: Radius.circular(60)),
                            border: Border(
                                bottom: BorderSide(
                                    color: AppColors.black, width: 10))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 30),
                          child: CustomText(
                            textName:
                                'Call/Whatsapp us regarding your queries also you can share the videos and photos on whatsapp where you are getting stuck',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            softWrap: true,
                            textColor: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.2,
                        child: Center(
                            child:
                                Image.asset(AppImages.welcomeSalary4sureText)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, left: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                _controller.whatsApp();
                              },
                              child: SvgPicture.asset(
                                  height: 55, AppImages.whatsappIcon),
                            ),
                            CustomText(
                              textName: "Contact Us",
                              textColor: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            InkWell(
                                onTap: () => launch('tel://8800858959'),
                                child: const Icon(Icons.call,
                                    color: Colors.black, size: 55)),
                          ],
                        ),
                      ),
                      //  ),
                    ],
                  );
                });
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage(AppImages.helpIcon))),
          )),
    );
  }
}
