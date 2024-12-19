
// ignore_for_file: unused_local_variable

import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/constants/app_images&icons.dart';
import 'package:app_here/controller/upload_salary_slip_controller.dart';
import 'package:app_here/reusable_widgets/custom_app_bar.dart';
import 'package:app_here/reusable_widgets/custom_button.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class UploadSalarySlipScreen extends StatelessWidget {
  UploadSalarySlipScreen({super.key});

  final _controller = Get.put(UploadSalarySlipController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        icon: Icons.arrow_back_ios,
        title: "Upload Salary Slip",
        leftPadding: 25,
        height: Get.height * 0.18,
      ),
      body: GetBuilder<UploadSalarySlipController>(
        init: _controller,
        builder: (controller) {
          return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: CustomText(
                  textName: "Salary Confirmation",
                  fontSize: 20,
                  textColor: AppColors.green,
                  fontWeight: FontWeight.bold,
                )),
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                    isThreeLine: false,
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset(
                      AppImages.rightArrow,
                      height: 40,
                    ),
                    title: CustomText(
                      textName:
                          "We need to verify your Salary Income Please UPLOAD your latest 3 month's Pay-Slip.",
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      fontSize: 15,                    textColor: Colors.black,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: Get.height * 0.025,
                ),              Center(
                  child: InkWell(
                    onTap: () {
                      _controller.pickPDF();
                      // setState(() {
                        _controller.isPayslipSelected = true;
                        _controller.update();
                      // });
                      
                      },
                    child: Container(
                      width: Get.width * 0.37,
                      height: Get.height * 0.19,
                      decoration:  BoxDecoration(
                        border:  (_controller.selectedFiles.isEmpty && _controller.isPayslipSelected)? Border.all(color: AppColors.logoBlueColor)  : const Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 215, 215, 215),
                                width: 4),
                            right: BorderSide(
                                color: Color.fromARGB(255, 215, 215, 215),
                                width: 4)),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                      ),
                      child: const Image(image: AssetImage(AppImages.paySlipPngIcon))
                    
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: GestureDetector(
                      onTap: _controller.pickPDF,
                      child: const Text(
                        "Upload (Salary Slip)",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.green,
                        ),
                      ),
                    ),
                ),
                 if(_controller.selectedFiles.isNotEmpty)
               Padding(
                 padding: const EdgeInsets.only(left: 20),
                 child: const  Text("Optional"),
               ),
               if(_controller.selectedFiles.isNotEmpty)
               Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25,top: 5),
                    child: TextField(
                      controller: _controller.salarySlipPasswordController,
                      obscureText: true, // Obscure the text
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                
        
                if (_controller.selectedFiles.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  const Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10),
                    child:  Text(
                      "Uploaded Files:",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 15),
                    child: Row(
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
                                    style: const TextStyle(fontSize: 10),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                  child: _controller.isLoading? const Center(
                          child: CircularProgressIndicator(
                          color: AppColors.black,
                        )): CustomButton(
                      onPressed: () async {
                        // Get.toNamed(MyAppRoutes.uploadSalarySlipScreen);
                        await _controller.slipDocumentsUpload();
                      },
                      textName: "Continue",
                      fontSize: 18,
                      textColor: AppColors.green,
                      color: AppColors.black),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
        }
      ),
    );
  }
}
