import 'package:flutter/material.dart';

Widget text(BuildContext context, {required String text, TextStyle? style, TextAlign? textAlign}) {
  // Ensure the style always includes Poppins font
  final TextStyle finalStyle = (style ?? const TextStyle()).copyWith(
    fontFamily: 'Poppins',
  );
  
  return SizedBox(
    child: Text(
      text,
      style: finalStyle,
      textAlign: textAlign ?? TextAlign.center
    )
  );
}