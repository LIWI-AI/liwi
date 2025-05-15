import 'package:flutter/material.dart';
import '../../../utils/colors/main.dart';
import '../../../utils/styles/font_weight.dart';
import '../../../utils/widgets/back_button.dart';
import '../../../utils/widgets/base_widget.dart';
import '../../../utils/widgets/text_button.dart';
import '../../../utils/widgets/texts.dart';
import 'ai_tutor/ai_tutor_intro_page.dart';

class IntroNamePage extends StatefulWidget {
  const IntroNamePage({super.key});

  @override
  State<IntroNamePage> createState() => _IntroNamePageState();
}

class _IntroNamePageState extends State<IntroNamePage> {
  final TextEditingController nameController = TextEditingController();
  Color color = AppColors.disabledButton;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          backButton(context),
          const SizedBox(height: 20),
          text(
            context,
            text: "Nice to meet you.",
            style: TextStyle(
              fontSize: 26,
              fontWeight: CustomFontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          text(
            context,
            text: "What's your name?",
            style: TextStyle(
              fontSize: 26,
              fontWeight: CustomFontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 30),
          TextField(
            controller: nameController,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.textPrimary,
            ),
            onChanged: (value) {
              setState(() {
                color = value.isNotEmpty
                    ? AppColors.mainButtonLight
                    : AppColors.disabledButton;
              });
            },
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            decoration: InputDecoration(
                hintText: 'Enter your name (in English)',
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary.withOpacity(0.5),
                ),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.borderDark))),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            // maxLines: 1,
            // maxLength: 30,
            textCapitalization: TextCapitalization.words,
          ),
          Spacer(),
          textButton(
            context,
            color: color,
            text: 'Next',
            onPressed: () {
              if (nameController.text.isNotEmpty) {
             Navigator.push(context, MaterialPageRoute(builder: (context) => AiTutorIntroPage()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter your name'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
