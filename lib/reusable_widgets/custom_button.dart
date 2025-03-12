
import 'package:flutter/material.dart';
import 'package:qualoan/constants/app_colors.dart';

import 'custom_text.dart';
class CustomButton extends StatelessWidget {
  final Widget? child;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final String textName;
  final Widget? prefixIcon;
  final Color color;
  final Color? textColor;
  final FontWeight?fontWeight;
  final double? fontSize;
  const CustomButton(
      {super.key,
      required this.onPressed,
      this.child,
      this.prefixIcon,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      this.gradient,
      required this.textName,
     required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(color),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                      // side: const BorderSide(
                      //     width: 1,
                      //     color: AppColors.orangeLogoColor
                      //     )
                  )
                          )),
          onPressed: onPressed,
          
          child: CustomText(
            textName: textName,
            fontSize: fontSize,
            fontWeight: fontWeight,
            // textColor:Colors.white ,
            textColor:textColor,
          ),
        ),
      ),
    );
  }
}
