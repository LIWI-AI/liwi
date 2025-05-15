import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_ai/src/utils/widgets/texts.dart';
import '../../../utils/colors/main.dart';
import '../../../utils/providers/language_list_provider.dart';
import '../../../utils/styles/font_weight.dart';
import '../../../utils/widgets/base_widget.dart';
import '../intro/name.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final languageProvider =
        Provider.of<LanguageListProvider>(context, listen: false);
    final popularLanguages = languageProvider.popularLanguages;
    final allLanguages = languageProvider.allLanguages;

    return BaseWidget(
      child: Column(
        children: [
          // Scrollable content
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.82,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  text(
                    context,
                    text: "What's your native language?",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: CustomFontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  text(
                    context,
                    text:
                        "You'll get feedback and assistance in your native language.",
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 30),
                  text(
                    context,
                    text: "Popular",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: CustomFontWeight.medium,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  ...popularLanguages.map(_languageTile),
                  const SizedBox(height: 10),
                  text(
                    context,
                    text: "All languages",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: CustomFontWeight.medium,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  ...allLanguages.map(_languageTile),
                  // const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
            // Navigate to Next page
          _continueButton(context, false),
          // ),
        ],
      ),
    );
  }

  Widget _languageTile(String language) {
    final isSelected = selectedLanguage == language;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = language;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEDE7FE) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF876CFE) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          language,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? const Color(0xFF876CFE) : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _continueButton(BuildContext context, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: GestureDetector(
        onTap: () {
          // If Language is selected
          if (selectedLanguage != null) {
            // Navigate to Intro Name Page
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => IntroNamePage()));
          }
        },
        child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: selectedLanguage != null
                ? AppColors.mainButtonLight
                : AppColors.textSecondary,
            borderRadius: BorderRadius.circular(40),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Continue",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
