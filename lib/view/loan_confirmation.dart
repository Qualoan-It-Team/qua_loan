import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:app_here/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';

class LoanConfirmation extends StatelessWidget {
  const LoanConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: Get.height * 0.3),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CustomText(
                    textName: "Thanks For Applying Loan ",
                    fontSize: 25,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    textColor: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              Center(
                child: CustomText(
                    textName: "Congratulation!",
                    fontSize: 25,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    textColor: AppColors.green,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: CustomText(
                    textName:
                        "All verification have completed successfully we will contact you soon.",
                    fontSize: 20,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    textColor: AppColors.black,
                    fontWeight: FontWeight.w300),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: Get.height*0.12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.4,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          border:
                              Border.all(color: AppColors.green, width: 2.0),
                          borderRadius: BorderRadius.circular(10)),
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.black)),
                          onPressed: () {
                            Get.toNamed(MyAppRoutes.dashboardScreen);
                          },
                          child: CustomText(
                            textName: "Back to app",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.green,
                          )),
                    ),
                    Container(
                      height: Get.height * 0.05,
                      width: Get.width * 0.35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.black,
                        border: Border.all(color: AppColors.green, width: 2.0),
                      ),
                      child: ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(AppColors.black)),
                          onPressed: () {
                            SystemNavigator.pop();
                          },
                          child: CustomText(
                            textName: "Exit",
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.green,
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
