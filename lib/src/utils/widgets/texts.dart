import 'package:flutter/material.dart';

Widget text(BuildContext context, {required String text, TextStyle? style, TextAlign? textAlign}) {
  // var screenWidth = MediaQuery.of(context).size.width;
  return SizedBox(
      // width: screenWidth * 0.8,
      child:  Text(text,
          style: style,
          textAlign:textAlign ?? TextAlign.center));
}
