
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class CustomText extends StatelessWidget{
  late String textName;
  double?fontSize;
   final String?fontFamily;
  Color? textColor;
  FontWeight?fontWeight;
  FontStyle?fontStyle;
  TextAlign?textAlign;
  int?maxLines;
  final TextDecoration?textDecoration;
  bool?softWrap;
  double? height;
  TextDecoration?decoration;
  TextOverflow?overflow;
   CustomText({
    super.key,
    required this.textName,
    this.decoration,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.overflow,
     this.fontFamily,
     this.height,
    this.softWrap,
    this.textAlign,
    this.fontStyle,
    this.textColor,
    this.textDecoration, 
  });

  @override
  Widget build(BuildContext context) {
   return Text(
    textName,
    textAlign: textAlign,
    softWrap: softWrap,
    overflow: overflow ?? TextOverflow.ellipsis,
    style: TextStyle(
      height: height,
    color: textColor,
    decoration: decoration,
    fontSize: fontSize,
    fontWeight: fontWeight,
        fontFamily: fontFamily
    ),
   );
  } 
}