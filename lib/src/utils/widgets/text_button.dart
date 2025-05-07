import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/styles/font_weight.dart';

import '../colors/main.dart';

Widget textButton(BuildContext context, {required String text, required VoidCallback onPressed, Color? color, Color? textColor}) {
  // var screenWidth = MediaQuery.of(context).size.width;
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: 70,
      decoration: BoxDecoration(
          color: color ?? AppColors.mainButtonLight,
          borderRadius: BorderRadius.circular(40),
        ),
      child: Align(
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(color:textColor?? Colors.white, fontSize: 22, fontWeight: CustomFontWeight.semiBold),
          // textAlign: TextAlign.center,
          ),
        ),
    ),
  );
}
