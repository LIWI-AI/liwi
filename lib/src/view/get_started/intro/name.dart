import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/colors/main.dart';
import 'package:sara_ai/src/utils/styles/font_weight.dart';
import 'package:sara_ai/src/utils/widgets/base_widget.dart';
import 'package:sara_ai/src/utils/widgets/text_button.dart';
import 'package:sara_ai/src/utils/widgets/texts.dart';

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
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: BaseWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_new),
                  const SizedBox(width: 8),
                  const Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: CustomFontWeight.medium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            text(context,
                text: "Nice to meet you.",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: CustomFontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                )),
            text(context,
                text: "What's your name ?",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: CustomFontWeight.bold,
                  color: Theme.of(context).colorScheme.onBackground,
                )),
            const SizedBox(height: 30),
            TextField(
              controller: nameController,
              style: TextStyle(
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
                  borderSide: BorderSide(
                    color: AppColors.borderDark,
                  ),
                ),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              maxLines: 1,
              maxLength: 30,
              textCapitalization: TextCapitalization.words,
            ),
            const Spacer(),
            textButton(
              context,
              color: color,
              text: 'Next',
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  // Navigate to next page
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter your name'),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
