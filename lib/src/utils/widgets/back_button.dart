import 'package:flutter/material.dart';
import '../styles/font_weight.dart';

Widget backButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.pop(context);
    },
    child: const Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios_new),
          SizedBox(width: 8),
          Text(
            "Back",
            style: TextStyle(
              fontSize: 14,
              fontWeight: CustomFontWeight.medium,
            ),
          ),
        ],
      ),
    ),
  );
}
