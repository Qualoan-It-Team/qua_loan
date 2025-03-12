// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/loan_application/upload_all_document_controller.dart';
import 'package:qualoan/reusable_widgets/common_back_header.dart';
import 'package:qualoan/reusable_widgets/custom_button.dart';
import 'package:qualoan/reusable_widgets/custom_snackbar.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';

class UploadAllDocuments extends StatefulWidget {
  const UploadAllDocuments({super.key});

  @override
  _UploadAllDocumentsState createState() => _UploadAllDocumentsState();
}

class _UploadAllDocumentsState extends State<UploadAllDocuments> {
  final _controller = Get.put(UploadAllDocumentsController());
  @override
  Widget build(BuildContext context) {
     _controller.fetchDocumentList();
    _controller.salarySlips.clear();
    _controller.aadhaarFront.clear();
    _controller.aadhaarBack.clear();
    _controller.pancardList.clear();
    _controller.otherDocuments.clear();
    return Scaffold(
      body: Stack(children: [
        const CommonBackHeader(),
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.2, right: 10, left: 10),
          child: GetBuilder<UploadAllDocumentsController>(
            init: _controller,
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CustomText(
                        textName: "UPLOAD ALL REQUIRED DOCUMENTS",
                        height: 3,
                        fontSize: 17,
                        textColor: AppColors.darkGrey,
                        overflow: TextOverflow.fade,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: Get.width,
                      decoration: const BoxDecoration(
                        color: AppColors.darkGrey,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          //   if (controller.pancardList.isEmpty) ...[
                          //   buildDocumentUploadSection("Upload Salary Slip", 'salarySlips', requiredCount: 3),
                          //   buildDocumentUploadSection("Upload Aadhar Card (Front)", 'aadhaarFront'),
                          //   buildDocumentUploadSection("Upload Aadhar Card (Back)", 'aadhaarBack'),
                          //   buildDocumentUploadSection("Upload PAN Card", 'pancard'),
                          // ],
                          // // Show salary slip upload section if documents exist
                          // if (controller.pancardList.isNotEmpty) ...[
                          //   buildDocumentUploadSection("Upload Salary Slip", 'salarySlips', requiredCount: 1),
                          // ],
                          // // Always show the other document upload section
                          // buildOtherDocumentUploadSection(),
                           if (controller.hasOnlyBankStatements) ...[
                            buildDocumentUploadSection("Upload Salary Slip", 'salarySlips', requiredCount: 3),
                            buildDocumentUploadSection("Upload Aadhar Card (Front)", 'aadhaarFront'),
                            buildDocumentUploadSection("Upload Aadhar Card (Back)", 'aadhaarBack'),
                            buildDocumentUploadSection("Upload PAN Card", 'pancard'),
                          ] else if (controller.hasDocuments) ...[
                            // Show salary slip upload section if all required documents exist
                            buildDocumentUploadSection("Upload Salary Slip", 'salarySlips', requiredCount: 3),
                          ],
                          // Always show the other document upload section
                          buildOtherDocumentUploadSection(),
                            const SizedBox(height: 30),
                            SizedBox(
                              child: controller.isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: AppColors.white,
                                    ))
                                  : CustomButton(
                                      onPressed: () {
                                        if (controller.hasDocuments) {
                                      // If the user has uploaded documents, only validate the salary slips
                                      if (controller.salarySlips.length == 3) {
                                        controller.uploadDocuments();
                                      } else {
                                        showCustomSnackbar(
                                          AppStrings.error,
                                          "Please upload the latest salary slip.",
                                          backgroundColor: AppColors.logoRedColor,
                                          textColor: AppColors.white,
                                        );
                                      }
                                    } else {
                                      // If the user has not uploaded any documents, validate all required documents
                                      if (controller.salarySlips.length == 3 &&
                                          controller.aadhaarFront.isNotEmpty &&
                                          controller.aadhaarBack.isNotEmpty &&
                                          controller.pancardList.isNotEmpty) {
                                        controller.uploadDocuments();
                                      } else {
                                        showCustomSnackbar(
                                          AppStrings.error,
                                          "Please upload all required documents.",
                                          backgroundColor: AppColors.logoRedColor,
                                          textColor: AppColors.white,
                                        );
                                      }
                                    }
                                        //  if (controller.hasDocuments ) {
                                        //   // If the user has uploaded documents, only validate the salary slips
                                        //   if (controller.salarySlips.length ==
                                        //       1) {
                                        //     controller.uploadDocuments();
                                        //   } else {
                                        //     showCustomSnackbar(
                                        //       AppStrings.error,
                                        //       "Please upload the latest salary slip.",
                                        //       backgroundColor:
                                        //           AppColors.logoRedColor,
                                        //       textColor: AppColors.white,
                                        //     );
                                        //   }
                                        // } else {
                                        //   // If the user has not uploaded any documents, validate all required documents
                                        //   if (controller
                                        //               .salarySlips.length ==
                                        //           3 &&
                                        //       controller
                                        //           .aadhaarFront.isNotEmpty &&
                                        //       controller
                                        //           .aadhaarBack.isNotEmpty &&
                                        //       controller
                                        //           .pancardList.isNotEmpty) {
                                        //     controller.uploadDocuments();
                                        //   } else {
                                        //     showCustomSnackbar(
                                        //       AppStrings.error,
                                        //       "Please upload all required documents.",
                                        //       backgroundColor:
                                        //           AppColors.logoRedColor,
                                        //       textColor: AppColors.white,
                                        //     );
                                        //   }
                                        // }
                                        
                                      },
                                      textName: "Upload All Documents",
                                      color: AppColors.lightOrange,
                                      textColor: AppColors.white,
                                      fontSize: 16,
                                    ),
                            ),
                            // if (!controller.hasDocuments) ...[
                            //   buildDocumentUploadSection(
                            //       "Upload Salary Slip", 'salarySlips',
                            //       requiredCount: 3),
                            //   buildDocumentUploadSection(
                            //       "Upload Aadhar Card (Front)", 'aadhaarFront'),
                            //   buildDocumentUploadSection(
                            //       "Upload Aadhar Card (Back)", 'aadhaarBack'),
                            //   buildDocumentUploadSection(
                            //       "Upload PAN Card", 'pancard'),
                            // ],
                            // // Always show the other document upload section
                            // buildDocumentUploadSection(
                            //     "Upload Salary Slip", 'salarySlips',
                            //     requiredCount: 1),
                            // buildOtherDocumentUploadSection(),
                            // const SizedBox(height: 30),
                            // SizedBox(
                            //   child: controller.isLoading
                            //       ? const Center(
                            //           child: CircularProgressIndicator(
                            //           color: AppColors.white,
                            //         ))
                            //       : CustomButton(
                            //           onPressed: () {
                            //   if (controller.hasDocuments) {
                            //     // If the user has uploaded documents, only validate the salary slips
                            //     if (controller.salarySlips.length ==
                            //         1) {
                            //       controller.uploadDocuments();
                            //     } else {
                            //       showCustomSnackbar(
                            //         AppStrings.error,
                            //         "Please upload latest salary slips",
                            //         backgroundColor:
                            //             AppColors.logoRedColor,
                            //         textColor: AppColors.white,
                            //       );
                            //     }
                            //   } else {
                            //     // If the user has not uploaded any documents, validate all required documents
                            //     if (controller.salarySlips.length ==
                            //             3 &&
                            //         (controller.aadhaarFront
                            //                 .isNotEmpty &&
                            //             controller
                            //                 .aadhaarBack.isNotEmpty &&
                            //             controller.pancardList
                            //                 .isNotEmpty)) {
                            //       controller.uploadDocuments();
                            //     } else {
                            //       showCustomSnackbar(
                            //         AppStrings.error,
                            //         "Please upload all required documents",
                            //         backgroundColor:
                            //             AppColors.logoRedColor,
                            //         textColor: AppColors.white,
                            //       );
                            //     }
                            //   }
                            //   // if (controller.salarySlips.length == 3 &&
                            //   //     (controller.aadhaarFront.isNotEmpty &&
                            //   //      controller.aadhaarBack.isNotEmpty &&
                            //   //      controller.pancardList.isNotEmpty)) {
                            //   //   controller.uploadDocuments();
                            //   // } else {
                            //   //   showCustomSnackbar(AppStrings.error, "Please upload all required documents", backgroundColor: AppColors.logoRedColor, textColor: AppColors.white);
                            //   // }
                            // },
                            //           textName: "Upload All Documents",
                            //           color: AppColors.lightOrange,
                            //           textColor: AppColors.white,
                            //           fontSize: 16,
                            //         ),
                            // ),
                            // buildDocumentUploadSection(
                            //     "Upload Salary Slip", 'salarySlips',
                            //     requiredCount:3),
                            // buildDocumentUploadSection(
                            //     "Upload Aadhar Card (Front)", 'aadhaarFront'),
                            // buildDocumentUploadSection(
                            //     "Upload Aadhar Card (Back)", 'aadhaarBack'),
                            // buildDocumentUploadSection(
                            //     "Upload PAN Card", 'pancard'),
                            // buildOtherDocumentUploadSection(),
                            // const SizedBox(height: 30),
                            // SizedBox(
                            //   child:_controller.isLoading?const Center(child: CircularProgressIndicator(color: AppColors.white,),) :CustomButton(
                            //     onPressed: () {
                            //       if (_controller.salarySlips.length == 3 &&
                            //           (_controller.aadhaarFront.isNotEmpty &&
                            //              _controller. aadhaarBack.isNotEmpty &&
                            //               _controller.pancardList.isNotEmpty
                            //               // && _controller.otherDocuments.isNotEmpty
                            //               )) {
                            //         _controller.uploadDocuments();
                            //       } else {
                            //         showCustomSnackbar(AppStrings.error, "Please upload all required documents",backgroundColor: AppColors.logoRedColor,textColor: AppColors.white);
                            //       //  Please upload 3 salary slips and at least one other document
                            //       }
                            //     },
                            //     textName:  "Upload All Documents",
                            //     color: AppColors.lightOrange,
                            //     textColor: AppColors.white,
                            //     fontSize: 16,
                            //   ),
                            // ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget buildDocumentUploadSection(String title, String type,
      {int requiredCount = 1}) {
    List<String> documents;
    TextEditingController remarksController;
    switch (type) {
      case 'salarySlips':
        documents = _controller.salarySlips;
        remarksController = _controller.salarySlipRemarksController;
        break;
      case 'aadhaarFront':
        documents = _controller.aadhaarFront;
        remarksController = _controller.frontAadhaarRemarksController;
        break;
      case 'aadhaarBack':
        documents = _controller.aadhaarBack;
        remarksController = _controller.backAadhaarRemarksController;
        break;
      case 'pancard':
        documents = _controller.pancardList;
        remarksController = _controller.panRemarksController;
        break;
      default:
        documents = [];
        remarksController = TextEditingController();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 3, top: 15),
          child: CustomText(
            textName: title,
            fontSize: 15,
            height: 3,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
          ),
        ),
        GestureDetector(
          onTap: () =>
              _controller.pickDocument(type, requiredCount: requiredCount),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: Get.width,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  textName: "Pick from gallery",
                  fontSize: 15,
                  height: 3,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.black,
                ),
                const Icon(Icons.arrow_drop_down, color: AppColors.grey),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: CustomText(
                  textName: "Remarks:",
                  textColor: AppColors.white,
                ),
              ),
              TextField(
                controller:
                    remarksController, // Use the corresponding controller
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLines: 2, // Allow multiple lines
              ),
            ],
          ),
        ),
        if (documents.isNotEmpty) ...[
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: documents.map((doc) {
                return GestureDetector(
                  onTap: () => _controller.openDocument(doc),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: Get.height * 0.1,
                      width: Get.width * 0.2,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.lightOrange),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.picture_as_pdf,
                              color: AppColors.lightOrange),
                          CustomText(
                            textName: doc.split('/').last,
                            fontSize: 12,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }

  Widget buildOtherDocumentUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, top: 15),
          child: CustomText(
            textName: "Select Other Document (Optional)",
            fontSize: 15,
            height: 3,
            fontWeight: FontWeight.w400,
            textColor: AppColors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 0, right: 0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.black),
              borderRadius: BorderRadius.circular(10),
            ),
            height: 53,
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: Container(),
                    icon: const SizedBox.shrink(),
                    value: _controller.selectedDocumentType,
                    hint: CustomText(
                      textName: "Select Document Type",
                      fontSize: 15,
                      textColor: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    items: _controller.documentTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      // setState(() {
                      _controller.selectedDocumentType = newValue;
                      if (newValue != null) {
                        _controller.pickDocument('otherDocuments');
                      }
                      _controller.update();
                      // });
                    },
                  ),
                ),
                const Icon(Icons.arrow_drop_down, color: AppColors.grey),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: CustomText(
                  textName: "Remarks:",
                  textColor: AppColors.white,
                ),
              ),
              TextField(
                controller: _controller.otherRemarksController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                maxLines: 2, // Allow multiple lines
              ),
            ],
          ),
        ),
        if (_controller.otherDocuments.isNotEmpty) ...[
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _controller.otherDocuments.map((doc) {
                return GestureDetector(
                  onTap: () => _controller.openDocument(doc),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: Get.height * 0.1,
                      width: Get.width * 0.2,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.lightOrange),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(Icons.picture_as_pdf,
                              color: AppColors.lightOrange),
                          CustomText(
                            textName: doc.split('/').last,
                            fontSize: 12,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
