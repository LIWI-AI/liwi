import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/colors/main.dart';

Widget textInput( {
  required String hintText,
  TextStyle? hintStyle,
  required TextEditingController controller,
  Function(String)? onChanged,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool isPassword = false,
}) {

  return Builder(builder: (context) {
    return Container(
      // width: screenWidth * 0.9,
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.textInput,
        borderRadius: BorderRadius.circular(40),
      ),
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(fontSize: 16, color: AppColors.textPrimary),
        onTapOutside: (_) => FocusScope.of(context).unfocus(),
        onChanged: onChanged,
        cursorColor: AppColors.textPrimary,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixIcon ?? prefixIcon,
          hintStyle: hintStyle ??
              const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          suffixIcon: suffixIcon ?? suffixIcon,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 23),
        ),
      ),
    );
  });
}
