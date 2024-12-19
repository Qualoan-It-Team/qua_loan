import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomListTile extends StatelessWidget {
  final String? subTitleTextName;
  final Color? subTitleTextColor;
  final FontWeight? subTitleFontweight;
  final double? subTitleFontSize;
  final String titleTextName;
  final Color? titleTextColor;
  final FontWeight? titleFontweight;
  final double? titleFontSize;
  final Widget? trailing;
  final Widget? leading;
  final bool? isThreeLine;
  final TextOverflow?overflow;
  final int?maxLines;
  final bool?softWrap;

  const CustomListTile(
      {super.key,
      this.subTitleTextName,
      this.subTitleTextColor,
      this.subTitleFontweight,
      this.subTitleFontSize,
      required this.titleTextName,
      this.titleTextColor,
      this.titleFontSize,
      this.titleFontweight,
      this.trailing,
      this.leading,
      this.isThreeLine,
      this.overflow,
      this.maxLines,
      this.softWrap
      });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        isThreeLine: isThreeLine!,
        contentPadding: const EdgeInsets.only(left: 30, right: 30),
        title: CustomText(
          textName: titleTextName,
          textColor: titleTextColor,
          fontWeight: titleFontweight,
          fontSize: titleFontSize,
        ),
        subtitle: CustomText(
            textName: subTitleTextName!,
            fontSize: 12,
            textColor: subTitleTextColor,
            overflow: TextOverflow.fade,
            maxLines: 3,
            softWrap: true),
        trailing: trailing,
        leading: leading);
  }
}
