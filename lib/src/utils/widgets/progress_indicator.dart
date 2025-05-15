import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/widgets/back_button.dart';
// import 'package:sara_ai/src/utils/widgets/texts.dart';

import '../colors/main.dart';

Widget progressIndicator(int value, BuildContext context) {
  var v = (value + 1) / 12;
  return Column(
    children: [
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: LinearProgressIndicator(
              value: v,
              backgroundColor: Colors.white,
              color: AppColors.mainButtonLight,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4))),
      // const SizedBox(height: 5),
      // text(context, text: v.toString()),
      backButton(context)
    ],
  );
}
