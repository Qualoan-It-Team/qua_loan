
// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';
import 'package:qualoan/controller/registration_controller/upload_bank_statement_controller.dart';
import 'package:qualoan/reusable_widgets/common_back_header.dart';
import 'package:qualoan/reusable_widgets/custom_button.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';

class UploadBankStatement extends StatelessWidget {
  UploadBankStatement({super.key});



final _controller = Get.put(UploadBankStatementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkGrey.withOpacity(0.9),
      body: Stack(
        children: [
          const CommonBackHeader(),
          Padding(
          padding: EdgeInsets.only(left: 10, right: 10,top: Get.height*0.23),
          child: GetBuilder<UploadBankStatementController>(
            init: _controller,
            builder: (controller) {
              return SingleChildScrollView(
              child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     
                    Center(
                        child: CustomText(
                      textName: "BANK STATEMENT",
                      fontSize: 20,
                      textColor: AppColors.white,
                      fontWeight: FontWeight.w400,
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    ListTile(
                        isThreeLine: false,
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(
                          AppImages.rightArrow,
                          
                          height: 40,
                        ),
                        title: CustomText(
                          textName: "We need your latest 3 months SALARY ACCOUNT bank statement to verify your income.",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          fontSize: 14,   
                          textColor: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                    ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: SvgPicture.asset(
                          AppImages.rightArrow,
                          height: 40,
                        ),
                        title: CustomText(
                          textName:
                              "Bank statement should be Bank generated in PDF format without any editing or merging.",
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          fontSize: 14,
                          textColor: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(
                      height: Get.height * 0.035,
                    ),              Center(
                      child: InkWell(
                        onTap: (){
                          _controller.pickPDF();
                           _controller. isBankStatementlipSelected = true;
                           _controller.update();
                        },
                        child: Container(
                          width: Get.width * 0.37,
                          height: Get.height * 0.19,
                          decoration: BoxDecoration(
                            border: (_controller.selectedFiles.isEmpty && _controller.isBankStatementlipSelected)? Border.all(color: AppColors.logoBlueColor
                            ) : const Border(
                                bottom: BorderSide(
                                    color: Color.fromARGB(255, 215, 215, 215),
                                    width: 4),
                                right: BorderSide(
                                    color: Color.fromARGB(255, 215, 215, 215),
                                    width: 4)),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SvgPicture.asset(
                              AppImages.pdfIcon,
                              height: 5,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: _controller.pickPDF,
                        child: const Text(
                          "Upload (PDF)",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: AppColors.orangeLogoColor,
                            fontSize: 18
                          ),
                        ),
                      ),
                    ),
                    if(_controller.selectedFiles.isNotEmpty)
               Padding(
                 padding:  const EdgeInsets.only(left: 25,bottom: 10),
                 child:   CustomText(textName:"Optional",textColor: AppColors.white,fontSize: 16,),
               ),
               if(_controller.selectedFiles.isNotEmpty)
               Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25,top: 5),
                    child: TextField(
                      style: const TextStyle(color: AppColors.white),
                      controller: _controller.bankPasswordController,
                      // obscureText: true, 
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: AppColors.white,fontSize: 13),
                        border: OutlineInputBorder(),
                        focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: AppColors.green))
                      ),
                    ),
                  ),

                    if (_controller.selectedFiles.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      const Padding(
                        padding:  EdgeInsets.only(left: 15,top: 10),
                        child:  Text(
                          "Uploaded Files",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: AppColors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: _controller.selectedFiles.map((file) {
                          return GestureDetector(
                            onTap: () async {
                              final result = await OpenFile.open(file.path);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                children: [
                                  Center(
                                    child: SvgPicture.asset(
                                      AppImages.pdfIcon,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      file.path.split('/').last,
                                      style: const TextStyle(fontSize: 10,color: AppColors.grey),
                                      textAlign: TextAlign.center,
                                      
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child:_controller.isLoading? const Center(
                              child: CircularProgressIndicator(
                              color: AppColors.white,
                            )): CustomButton(
                          onPressed: () async {
                            await _controller.uploadBankStatements();
                          },
                          textName: "Upload",
                          fontSize: 18,
                          textColor: AppColors.white,
                          color: AppColors.lightOrange),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            },
          ),
        ),
        ]
      ),
    );
  }
}
