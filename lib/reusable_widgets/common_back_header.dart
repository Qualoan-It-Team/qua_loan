import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qualoan/constants/app_colors.dart';
import 'package:qualoan/constants/app_images&icons.dart';

class CommonBackHeader extends StatelessWidget {
  const CommonBackHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(251, 197, 194, 194),
      height: 125,
      padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(
            builder: (context) {
              return  Padding(
                padding: const EdgeInsets.only(bottom: 10, left: 15),
                child: InkWell(
                  onTap: (){
                    Get.back();
                  } ,
                  // child: CircleAvatar(
                  //   backgroundColor: AppColors.lightOrange.withOpacity(0.8),
                  //   radius: 20,
                    child:  Center(child: Icon(Icons.arrow_back_ios,color: AppColors.lightOrange,size: 25,weight: 30,)),
                  // ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.012),
            child: SizedBox(
                height: 40, child: Image.asset(AppImages.quaHomeLogoPng)),
          ),
        ],
      ),
    );
  }
}
