import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_strings.dart';
import 'package:qualoan/controller/dashboard_controller/dashboard_controller.dart';
import 'package:qualoan/controller/dashboard_controller/show_loan_details_controller.dart';
import 'package:qualoan/reusable_widgets/common_back_header.dart';
import 'package:qualoan/reusable_widgets/custom_button.dart';
import 'package:qualoan/reusable_widgets/custom_text.dart';
import 'package:qualoan/view/dashboard/dashboard_screen.dart';

class ShowLoanDetails extends StatelessWidget {
  ShowLoanDetails({super.key});
  final _controller = Get.put(ShowLoanDetailsController());

  @override
  Widget build(BuildContext context) {
    _controller.showLoanDetails();
    _controller.fetchDashboardDetails();
    return Scaffold(
      body: Stack(
        children: [
          const CommonBackHeader(),
          GetBuilder<ShowLoanDetailsController>(
            init: _controller,
            builder: (controller) {
              return Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: Get.height * 0.2),
                child: _controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.lightOrange,
                        ),
                      )
                    : _controller.showLoanDetailsResponse == null ||
                            _controller
                                .showLoanDetailsResponse!.loanList.isEmpty
                        ? Center(
                            child: CustomText(
                              textName: AppStrings.noLoanDetailsFound,
                              textColor: AppColors.lightOrange,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Table(
                                          columnWidths: const {
                                            0: FixedColumnWidth(100),
                                            1: FixedColumnWidth(150),
                                            2: FixedColumnWidth(150),
                                            3: FixedColumnWidth(180),
                                            4: FixedColumnWidth(120),
                                            5: FixedColumnWidth(150),
                                          },
                                          children: [
                                            TableRow(
                                              children: [
                                                _buildHeaderCell(
                                                    AppStrings.serialNo),
                                                _buildHeaderCell(
                                                    AppStrings.loanNo),
                                                _buildHeaderCell(
                                                    AppStrings.payableAmount),
                                                _buildHeaderCell(
                                                    AppStrings.repaymentAmount),
                                                _buildHeaderCell(
                                                    AppStrings.panCaps),
                                                _buildHeaderCell(
                                                    AppStrings.repaymentDate),
                                              ],
                                            ),
                                            ...controller
                                                .showLoanDetailsResponse!
                                                .loanList
                                                .map((loan) {
                                              return TableRow(
                                                children: [
                                                  _buildDataCell((controller
                                                              .showLoanDetailsResponse!
                                                              .loanList
                                                              .indexOf(loan) +
                                                          1)
                                                      .toString()),
                                                  _buildDataCell(loan.loanNo ??
                                                      AppStrings.emptyString),
                                                  _buildDataCell(loan
                                                          .outstandingAmount
                                                          .toString() ??
                                                      AppStrings.emptyString),
                                                  _buildDataCell(loan
                                                          .repaymentAmount
                                                          .toString() ??
                                                      AppStrings.emptyString),
                                                  _buildDataCell(loan.pan ??
                                                      AppStrings.emptyString),
                                                  _buildDataCell(_controller
                                                          .formatDate(loan
                                                              .repaymentDate) ??
                                                      AppStrings.emptyString),
                                                ],
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.3,
                                      child: Column(
                                        children: [
                                          _buildHeaderCell(
                                              AppStrings.statusText),
                                          ...controller
                                              .showLoanDetailsResponse!.loanList
                                              .map((loan) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top:15,
                                                  right: 5,
                                                  left: 8,
                                                  bottom: 5),
                                              child: loan.isClosed
                                                  ? CustomText(
                                                      textName:
                                                          AppStrings.closed,
                                                      fontSize: 15,
                                                      textColor:
                                                          AppColors.darkGrey,
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        _controller
                                                            .payNowApiMethod(
                                                                loan.loanNo);
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .lightOrange,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        height: 40,
                                                        width: Get.width * 0.2,
                                                        child: Center(
                                                            child: CustomText(
                                                          textName:
                                                              AppStrings.rePay,
                                                          textColor:
                                                              AppColors.white,
                                                        )),
                                                      ),
                                                    ),
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    ),

                                    // SizedBox(
                                    //   width: Get.width * 0.25,
                                    //   child: Column(
                                    //     children: [
                                    //       _buildHeaderCell(AppStrings.statusText),
                                    //       SizedBox(
                                    //           child: _controller
                                    //                   .showLoanDetailsResponse!
                                    //                   .loanList[0]
                                    //                   .isClosed
                                    //               ? Padding(
                                    //                   padding:
                                    //                       const EdgeInsets.only(
                                    //                           top: 20,
                                    //                           right: 5,
                                    //                           left: 8,
                                    //                           bottom: 5),
                                    //                   child: CustomText(
                                    //                     textName: AppStrings.closed,
                                    //                     fontSize: 15,
                                    //                     textColor:
                                    //                         AppColors.darkGrey,
                                    //                   ),
                                    //                 )
                                    //               : Padding(
                                    //                   padding:
                                    //                       const EdgeInsets.only(
                                    //                           top: 15,
                                    //                           right: 5,
                                    //                           left: 8,
                                    //                           bottom: 5),
                                    //                   child: GestureDetector(
                                    //                     onTap: () {
                                    //                       _controller
                                    //                           .payNowApiMethod();
                                    //                     },
                                    //                     child: Container(
                                    //                       decoration: BoxDecoration(
                                    //                           color: AppColors
                                    //                               .lightOrange,
                                    //                           borderRadius:
                                    //                               BorderRadius
                                    //                                   .circular(
                                    //                                       10)),
                                    //                       height: 40,
                                    //                       width: Get.width * 0.2,
                                    //                       child: Center(
                                    //                           child: CustomText(
                                    //                         textName: AppStrings.rePay,
                                    //                         textColor:
                                    //                             AppColors.white,
                                    //                       )),
                                    //                     ),
                                    //                   )))
                                    //     ],
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                Center(
                                  child: (_controller
                                              .showLoanDetailsResponse!.loanList
                                              .any((loan) => loan.isClosed) &&
                                          _controller.isLoanApply == false)
                                      ? SizedBox(
                                          height: 45,
                                          width: Get.width * 0.4,
                                          child: CustomButton(
                                            onPressed: () {
                                              Get.to(DashboardScreen());
                                              Get.find<
                                                      DashboardScreenController>()
                                                  .onItemTapped(1);
                                            },
                                            textName: AppStrings.reLoan,
                                            color: AppColors.lightOrange,
                                            textColor: AppColors.white,
                                            fontSize: 16,
                                          ),
                                        )
                                      : const SizedBox(),
                                ),
                               const SizedBox(
                                  height: 20,
                                ),

                                InkWell(
                                    onTap: () {
                                      _controller.showLoanDetails();
                                      _controller.fetchDashboardDetails();
                                    },
                                    child: const Icon(
                                      Icons.refresh,
                                      size: 30,
                                    )),

                                // Center(
                                //   child: (_controller.isClosed==true) ? SizedBox(
                                //       height: 45,
                                //       width: Get.width * 0.4,
                                //       child: CustomButton(
                                //         onPressed: () {
                                //           Get.to(DashboardScreen());
                                //           Get.find<DashboardScreenController>().onItemTapped(1);
                                //         },
                                //         textName: AppStrings.reLoan,
                                //         color: AppColors.lightOrange,
                                //         textColor: AppColors.white,
                                //         fontSize: 16,
                                //       )): const SizedBox(),
                                // )
                              ],
                            ),
                          ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.darkGrey, width: 2)),
      ),
      child: CustomText(
        textName: title,
        textColor: AppColors.lightOrange,
        fontSize: 15,
        overflow: TextOverflow.fade,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDataCell(String data) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
      child: CustomText(
        textName: data,
        overflow: TextOverflow.fade,
        textColor: AppColors.darkGrey,
        fontSize: 14,
      ),
    );
  }
}
