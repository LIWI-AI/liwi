
import 'package:flutter/material.dart';

import '../colors/main.dart';

Widget signUpWith(BuildContext context, Widget icon, {required VoidCallback onPressed}) {
  var screenWidth = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: screenWidth * 0.27,
      height: 50,
      decoration: BoxDecoration(
        // color: AppColors.mainButtonLight,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1.3,color: AppColors.transparent),
      ),
      child: Align(
        alignment: Alignment.center,
        child: icon,
      ),
    ),
  );
}
