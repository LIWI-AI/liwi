import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/colors/main.dart';
import 'package:sara_ai/src/utils/widgets/base_widget.dart';
import 'package:sara_ai/src/utils/widgets/texts.dart';
import '../../../utils/styles/font_weight.dart';
import '../../../utils/widgets/text_button.dart';
import '../intro/name.dart';
import 'widget/all.dart';
import 'widget/popular.dart';

class LanguageSelectorPage extends StatelessWidget {
  const LanguageSelectorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: BaseWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.8,
              child: ListView(
                children: [
                  SizedBox(height: height * 0.1),
                  text(context,
                      text: "What's your native language?",
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: CustomFontWeight.semiBold,
                          color: Colors.black),
                      textAlign: TextAlign.start),
                  text(context,
                      text:
                          "You'll get feedback and assistance in your native language.",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: CustomFontWeight.semiBold,
                          color: AppColors.textPrimary)),
                  const SizedBox(height: 20),
                  // Popular Language options
                  const PopularLanguageOptions(),
                  const SizedBox(height: 20),
                  const AllLanguageOptions(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Continue button
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: textButton(context,
                  text: 'Continue',
                  onPressed: () {
                    // Navigate to Sign Up page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IntroNamePage()));
                  },
                  color: AppColors.mainButtonLight),
            ),
          ],
        ),
      ),
      );
  }
}