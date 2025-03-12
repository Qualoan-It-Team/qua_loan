// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/loan_application/loan_application_controller.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/routes/app_routes.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/view/loan_application/employment_information.dart';
import 'package:qualoan/view/loan_application/upload_all_documents.dart';
import 'package:qualoan/view/loan_application/upload_bank_statement.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_images&icons.dart';

class LoanApplicationScreen extends StatelessWidget {
  LoanApplicationScreen({super.key});

  final _controller = Get.put(LoanApplicationController());

  @override
  Widget build(BuildContext context) {
    _controller. fetchDashboardDetails();
    _controller. getProgressPercentage();
    return Scaffold(
        backgroundColor: AppColors.white,
        body: Stack(children: [
          //  if(_controller.applicationUnderProcess=="REJECTED" || _controller.applicationSenction=="REJECTED" ||_controller.applicationDisbursed=="REJECTED")
          //   CommonBackHeader(),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: GetBuilder<LoanApplicationController>(
              init: _controller,
              builder: (controller) {
                double progress = controller.getProgressPercentage(); 
                return SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              
                              SizedBox(
                               height: Get.height * 0.042,
                              ),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.lightOrange.withOpacity(0.8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 10, right: 20, bottom: 10),
                                    child: CustomText(
                                      // textName: AppStrings.beginAJourneyText,
                                      textName: "Welcome to our Loan Application",
                                      fontSize: 18,
                                      // textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                      overflow: TextOverflow.fade,
                                      textColor: AppColors.white,
                                    ),
                                  ),
                                ),
                              ),
                               Padding(
                                    padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
                                    child: CustomText(
                                      textName: "Here, you can fill your information at your convenience. Please note that you can update your details at any time until you submit your bank information. Once submitted, your data will be processed securely.",
                                      fontSize: 15,
                                      overflow: TextOverflow.fade,
                                      ),
                                  ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 20, right: 20, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                         Center(
                                          child: CustomText(
                                            textName: "Application Status",
                                            fontSize: 19,
                                            fontWeight: FontWeight.w700,
                                            overflow: TextOverflow.fade,
                                            textColor: AppColors.black,
                                          ),
                                        ),
                                      // ),
                                      const SizedBox(width: 10),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: CircularProgressIndicator(
                                              value: progress/100,
                                              strokeWidth: 7,
                                              color: AppColors.green,
                                            ),
                                          ),
                                           Text(
                                           '${progress.toStringAsFixed(0)}%',
                                            style:const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              
                              SizedBox(
                                  height: Get.height * 0.3,
                                  child: const Image(
                                      image: AssetImage(
                                          AppImages.registrationVideo))),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 20),
                                child: Row(
                                  children: [
                                     CircleAvatar(
                                        radius: 22,
                                        backgroundColor: AppColors.black,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(Icons.check_circle,
                                              size: 30,
                                              color:_controller.isLoanCalculated?AppColors.green.withOpacity(0.8) :AppColors.white
                                                  .withOpacity(0.8)),                                        )),
                                    SizedBox(
                                      width: Get.width * 0.05,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                    
                                        onTap: () {
                                          Get.toNamed(
                                              MyAppRoutes.loanCalculatorScreen);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: CustomText(
                                                    overflow: TextOverflow.fade,
                                                    softWrap: true,
                                                    height: 1.7,
                                                    fontSize: 16,
                                                    maxLines: 1,
                                                    fontWeight: FontWeight.w400,
                                                    textColor: AppColors.white,
                                                    textName: AppStrings
                                                        .openLoanCalculator)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.06,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: VerticalDivider(
                                    color: AppColors.black,
                                    indent: 2,
                                    endIndent: 2,
                                    thickness: 3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 22,
                                        backgroundColor: AppColors.black,
                                        child: Padding(
                                          padding:const  EdgeInsets.all(2.0),
                                          child: Icon(Icons.check_circle,
                                              size: 30,
                                              color: _controller.isEmployInformation?AppColors.green.withOpacity(0.8) :AppColors.white
                                                  .withOpacity(0.8)),
                                        )),
                                    SizedBox(
                                      width: Get.width * 0.05,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap:  _controller.isLoanCalculated
                                        ? (){ Get.to(EmploymentInformation());}
                                        : () {
                                            showCustomSnackbar(AppStrings.error,
                                                AppStrings.employeeVerificationStep,
                                                backgroundColor:
                                                    AppColors.logoRedColor,
                                                textColor: AppColors.white);

                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: AppColors.white
                                            //     .withOpacity(0.9),
                                            color: AppColors.darkGrey
                                                .withOpacity(0.9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: CustomText(
                                                  overflow: TextOverflow.fade,
                                                  softWrap: true,
                                                  height: 1.7,
                                                  fontSize: 17,
                                                  maxLines: 1,
                                                  fontWeight: FontWeight.w400,
                                                  // textColor: AppColors.black,
                                                  textColor: AppColors.white,
                                                  textName: AppStrings
                                                      .employmentInformation),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.06,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: VerticalDivider(
                                    color: AppColors.black,
                                    indent: 2,
                                    endIndent: 2,
                                    thickness: 3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 22,
                                        backgroundColor: AppColors.black,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(Icons.check_circle,
                                              size: 30,
                                              color:_controller.isUploadBankStatements?AppColors.green.withOpacity(0.8) :AppColors.white
                                                  .withOpacity(0.8)),
                                          // ),
                                        )),
                                    SizedBox(
                                      width: Get.width * 0.05,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                         onTap: 
                                          _controller.isEmployInformation
                                        ? () { Get.to(UploadBankStatement());}
                                        : () {
                                            showCustomSnackbar(AppStrings.error,
                                                AppStrings.uploadBankStatementsStep,
                                                backgroundColor:
                                                    AppColors.logoRedColor,
                                                textColor: AppColors.white);
                                          },
                                        
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.darkGrey
                                                .withOpacity(0.9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                                child: CustomText(
                                                    overflow: TextOverflow.fade,
                                                    softWrap: true,
                                                    height: 1.7,
                                                    fontSize: 17,
                                                    maxLines: 1,
                                                    fontWeight: FontWeight.w400,
                                                    textColor: AppColors.white,
                                                    textName: AppStrings
                                                        .uploadBankStatements)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.06,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: VerticalDivider(
                                    color: AppColors.black,
                                    indent: 2,
                                    endIndent: 2,
                                    // width: 2,
                                    thickness: 3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 22,
                                        backgroundColor: AppColors.black,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(Icons.check_circle,
                                              size: 30,
                                              color: _controller.isShowDocuments?AppColors.green.withOpacity(0.8) :AppColors.white
                                                  .withOpacity(0.8)),
                                        )),
                                    SizedBox(
                                      width: Get.width * 0.05,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                         onTap: _controller.isUploadBankStatements
                                        ?  (){Get.to(const UploadAllDocuments());}
                                        : () {
                                            showCustomSnackbar(AppStrings.error,
                                                AppStrings.shareDocumentsStep,
                                                backgroundColor:
                                                    AppColors.logoRedColor,
                                                textColor: AppColors.white);
                                          },
                                         
                                        
                                       
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: AppColors.white
                                            //     .withOpacity(0.9),
                                            color: AppColors.darkGrey
                                                .withOpacity(0.9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: CustomText(
                                                  overflow: TextOverflow.fade,
                                                  softWrap: true,
                                                  height: 1.7,
                                                  fontSize: 17,
                                                  maxLines: 1,
                                                  fontWeight: FontWeight.w400,
                                                  textColor: AppColors.white,
                                                  textName: AppStrings
                                                      .shareDocuments),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.06,
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: VerticalDivider(
                                    color: AppColors.black,
                                    indent: 2,
                                    endIndent: 2,
                                    thickness: 3,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                        radius: 22,
                                        backgroundColor: AppColors.black,
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(Icons.check_circle,
                                              size: 30,
                                              color:_controller.isBankDetails?AppColors.green.withOpacity(0.8) :AppColors.white
                                                  .withOpacity(0.8)),
                                          // ),
                                        )),
                                    SizedBox(
                                      width: Get.width * 0.05,
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap:  _controller.isShowDocuments
                                        ? (){  Get.toNamed(MyAppRoutes.bankDetails);}
                                        : () {
                                            showCustomSnackbar(AppStrings.error,
                                                AppStrings.bankDetailsStep,
                                                backgroundColor:
                                                    AppColors.logoRedColor,
                                                textColor: AppColors.white);
                                          },
                                         
                                        
                                        // onTap: () {
                                        //   Get.to(BankDetailsVerification());
                                        // },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: AppColors.white
                                            //     .withOpacity(0.9),
                                            color: AppColors.darkGrey
                                                .withOpacity(0.9),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: CustomText(
                                                  overflow: TextOverflow.fade,
                                                  softWrap: true,
                                                  height: 1.7,
                                                  fontSize: 17,
                                                  maxLines: 1,
                                                  fontWeight: FontWeight.w400,
                                                  textColor: AppColors.white,
                                                  textName:
                                                      AppStrings.bankDetails),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 40),
                              // Padding(
                              //   padding: const EdgeInsets.only(left: 8,right: 8,bottom: 20),
                              //   child: CustomButton(onPressed: (){},textName: "Go Proceed for loan",textColor: AppColors.white, color: AppColors.lightOrange,fontSize: 18,),
                              // )
                            ])));
              },
            ),
          ),
        ]));
  }
}
