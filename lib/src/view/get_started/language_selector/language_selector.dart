import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sara_ai/src/utils/widgets/texts.dart';
import '../../../utils/colors/main.dart';
import '../../../utils/providers/language_list_provider.dart';
import '../../../utils/styles/font_weight.dart';
import '../../../utils/widgets/base_widget.dart';
import '../../../utils/widgets/text_button.dart';
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
    
    // Get screen size for responsive design
    final size = MediaQuery.of(context).size;
    final viewInsets = MediaQuery.of(context).viewInsets;
    final isKeyboardOpen = viewInsets.bottom > 0;

    return BaseWidget(
      child: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isKeyboardOpen ? 20 : 30),
                  text(
                    context,
                    text: "What's your native language?",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: CustomFontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  text(
                    context,
                    text:
                        "You'll get feedback and assistance in your native language.",
                    style: const TextStyle(
                      fontSize: 14, 
                      color: Colors.black54,
                      fontFamily: 'Poppins',
                    ),
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
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  ...popularLanguages.map(_languageTile),
                  const SizedBox(height: 20),
                  text(
                    context,
                    text: "All languages",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: CustomFontWeight.medium,
                      color: AppColors.textSecondary,
                      fontFamily: 'Poppins',
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 10),
                  ...allLanguages.map(_languageTile),
                  // Add bottom padding to ensure last item is visible when scrolled
                  SizedBox(height: 20 + (isKeyboardOpen ? viewInsets.bottom : 0)),
                ],
              ),
            ),
          ),
          // Fixed bottom button
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: textButton(
              context,
              text: "Continue",
              onPressed: () {
                // If Language is selected
                if (selectedLanguage != null) {
                  // Navigate to Intro Name Page
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => IntroNamePage()));
                }
              },
              color: selectedLanguage != null
                  ? AppColors.mainButtonLight
                  : AppColors.textSecondary,
              withShadow: selectedLanguage != null,
            ),
          ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEDE7FE) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF876CFE) : const Color(0xFFEEEEEE),
            width: 1.5,
          ),
          boxShadow: isSelected 
              ? [
                  BoxShadow(
                    color: const Color(0x1A876CFE),
                    offset: const Offset(0, 4),
                    blurRadius: 8,
                  )
                ] 
              : null,
        ),
        child: Text(
          language,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? const Color(0xFF876CFE) : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}