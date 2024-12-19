import 'package:app_here/constants/app_colors.dart';
import 'package:app_here/reusable_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;
  final double? leftPadding;
  final bool? forceMaterialTransparency;
  // final Color backgroundColor;
  final double height;
  CustomAppBar(
      {super.key,
      required this.title,
      this.height = 56.0,
      this.icon,
      this.leftPadding,
      this.forceMaterialTransparency});
  // final _controller = Get.put(MainDashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height),
        // Set this height
        child: Container(
          height: height,
          width: double.infinity,
          decoration: const BoxDecoration(
              // color: AppColors.logoBlueColor,
              color: AppColors.green,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
              border: Border(
                  bottom: BorderSide(
                      // color: Color.fromARGB(255, 196, 194, 194), width: 10),
                      // color: AppColors.logoRedColor,
                      color: AppColors.black,
                      width: 10))),
          child: Padding(
            padding: EdgeInsets.only(top: 25, left: leftPadding ?? 0.0),
            child: Row(
              
              children: [
                if (icon != null) // Show icon only if it's not null
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      icon,
                      color: AppColors.black,
                      weight: 15,
                    ),
                  ),
                if (icon != null) // Show SizedBox only if icon is present
                  const SizedBox(
                    width: 20,
                  ),
                  CustomText(
                    textName: title,
                    // textColor: Colors.white,
                    textColor: AppColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.center,
                  ),
                
              ],
            ),
          ),
          // child: Padding(
          //     padding:  EdgeInsets.only(top: 25, left: leftPadding ?? 0.0),
          //     child: Row(
          //       // mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         InkWell(
          //             onTap: () {
          //               Get.back();
          //             },
          //             child:  Icon(icon,color: AppColors.logoRedColor,weight: 15,),
          //         ),
          //             // const Icon(
          //             //   Icons.arrow_back_ios,
          //             //   color: AppColors.logoRedColor,
          //             //   weight: 15,
          //             // )),
          //         const SizedBox(
          //           width: 10,
          //         ),
          //         Expanded(
          //           child: CustomText(textName: title,
          //           textColor: Colors.white,
          //           fontSize: 20,
          //                 fontWeight: FontWeight.w600,
          //                 textAlign: TextAlign.center,
          //           ),
          //         ),
          //       ],
          //     )),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}



// class CustomAppBar extends StatelessWidget {
//   final String title;
//   final double? height;
//   final IconData? icon;
//   // final Color backgroundColor;
//   CustomAppBar({super.key, required this.title, this.height,this.icon});
//   // final _controller = Get.put(MainDashboardController());
//   @override
//   Widget build(BuildContext context) {
//     return 
// Container(
//       height: height,
//       width: Get.width,
//       decoration: const BoxDecoration(
//           color: AppColors.logoBlueColor,
//           borderRadius: BorderRadius.only(
//               bottomLeft: Radius.circular(60),
//               bottomRight: Radius.circular(60)),
//           border: Border(
//               bottom: BorderSide(
//                   // color: Color.fromARGB(255, 196, 194, 194), width: 10),
//                   color: AppColors.logoRedColor,
//                   width: 10))),
//       child: Padding(
//           padding: const EdgeInsets.only(top: 25, ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               InkWell(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.only(left: 10),
//                     child: Icon(icon,color: AppColors.logoRedColor,weight: 15,),
//                   ),
//               ),
//                   // const Icon(
//                   //   Icons.arrow_back_ios,
//                   //   color: AppColors.logoRedColor,
//                   //   weight: 15,
//                   // )),
//               const SizedBox(
//                 width: 15,
//               ),
//               CustomText(textName: title,
//               textColor: Colors.white,
//               fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                     textAlign: TextAlign.center,
//               ),
//             ],
//           )),
//     );
//   }
// }
