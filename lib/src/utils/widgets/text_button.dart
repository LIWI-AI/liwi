import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/styles/font_weight.dart';
import '../colors/main.dart';

Widget textButton(
  BuildContext context, {
  required String text,
  required VoidCallback onPressed,
  Color? color,
  Color? textColor,
  bool withShadow = false,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: color ?? AppColors.mainButtonLight,
        borderRadius: BorderRadius.circular(40),
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: const Color(0x4099BFE6), // 25% opacity of 99BFE6
                  offset: const Offset(0, 16),
                  blurRadius: 40,
                  spreadRadius: 0,
                )
              ]
            : null,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 22,
            fontWeight: CustomFontWeight.semiBold,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    ),
  );
}