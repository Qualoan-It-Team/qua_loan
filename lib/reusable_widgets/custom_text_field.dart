
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qualoan/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? prefixText;
  final String? labelText;
  final TextAlign ?textAlign;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool? onTapReadOnly;
  final List<TextInputFormatter>? inputFormatters;
  final Function? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? obscureText;
  final Widget? label;
  final bool? readOnly;
  final bool? enabled;
  final Function? onSaved;
  final Function(String)? onChanged;
  final GestureTapCallback? onTap;
  final int? maxLength;
  final bool? textCapitalization;
  final Color? fillColor;
  final bool? filled;
  final int? textType;
  final bool? isError;
  final String? errorText;

  const CustomTextField(
      {super.key,
      this.controller,
      this.prefixText,
      this.onTap,
      this.labelText,
      this.hintText,
      this.onTapReadOnly,
      this.readOnly,
      this.enabled,
      this.textAlign,
      this.keyboardType,
      this.onFieldSubmitted,
      this.focusNode,
      this.suffixIcon,
      this.label,
      this.onChanged,
      this.obscureText,
      this.onSaved,
      this.prefixIcon,
      this.inputFormatters,
      this.validator,
      this.maxLength,
      this.textCapitalization,
      this.fillColor,
      this.filled,
      this.textType,
      this.isError,
      this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10,),
      child:  TextFormField(
          inputFormatters: inputFormatters, enabled: enabled,
          onTap: onTap,
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          focusNode: focusNode,
          readOnly: onTapReadOnly == null ? false : true,
          validator: validator,
          maxLength: maxLength,
          // textAlign: textAlign!,
          textCapitalization: 
          textCapitalization == null
              ? TextCapitalization.none
              : textCapitalization == false
                  ? TextCapitalization.characters
                  : TextCapitalization.words,
        
          // textCapitalization == 0? TextCapitalization.words :
          // textCapitalization == 1? TextCapitalization.characters : TextCapitalization.none,
          // textCapitalization == 2? TextCapitalization.sentences : TextCapitalization.none,
        
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  const BorderSide(color: AppColors.logoBlueColor, width: 1.5),
            ),
            // floatingLabelStyle: const TextStyle(
            //     // color: AppColors.logoBlueColor,
            //     color: AppColors.black,
            //     fontWeight: FontWeight.w400,
            //     fontSize: 15),
            // filled: true,
            
            label: label,
            contentPadding: const EdgeInsets.all(16),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            hintText: hintText,
            labelText: labelText,
            filled: filled,
            prefixText: prefixText,
            fillColor: fillColor,
            errorText: errorText,
            prefixStyle: TextStyle(
              color: AppColors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            
        
            // label: Text(hintText.toString(),),
            hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w400),
            labelStyle: TextStyle(
              // color: Color.fromARGB(255, 143, 148, 155),
              color: enabled == false ? Colors.grey : AppColors.black,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
            // this will decorate the validated input boxes with Red in color.
            // border: OutlineInputBorder(
            //   borderSide: BorderSide(color: isError!? AppColors.logoRedColor:Colors.grey),
            //   borderRadius: BorderRadius.circular(5),
            // ),
            // this will decorate the input boxes with sea green in color.
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.logoBlueColor,
                width: 1,
              ),
            ),
            errorBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.red, width: 1)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.black, width: 1),
              // const BorderSide(color: Colors.white, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                  color: Colors.red, width: 1), // Same as errorBorder
            ),
          ),
        ),
      
    );
  }
}
