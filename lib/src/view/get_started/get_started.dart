import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/widgets/base_widget.dart';
import 'package:sara_ai/src/utils/widgets/text_button.dart';
import 'package:sara_ai/src/utils/widgets/texts.dart';
import 'package:sara_ai/src/view/authentication/signup.dart';
import '../../utils/colors/main.dart';
import '../authentication/login.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          text(context,
              text: 'Your Journey to Fluent English Starts Here!',
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontFamily: 'Poppins')),
          const SizedBox(height: 20),
          text(context,
              text:
                  'Take the first step toward mastering English with personalized lessons and real-world communication skills.',
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textSecondary,
                  fontFamily: 'Poppins')),
          const SizedBox(height: 40),
          textButton(
            context, 
            text: 'Get Started', 
            onPressed: () {
              // Navigate to SignUp Page
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SignUpPage()));
            }, 
            color: AppColors.mainButtonLight,
            withShadow: true,
          ),
          const SizedBox(height: 16),
          textButton(
            context,
            text: 'I already have an account',
            onPressed: () {
              // Navigate to Login Page
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
            color: AppColors.secondaryButton,
            textColor: AppColors.textPrimary,
            withShadow: true,
          ),
          const SizedBox(height: 24),
          const Text(
            'By continuing, you agree to our',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColors.textPrimary,
                fontFamily: 'Poppins'),
            textAlign: TextAlign.center,
          ),
          InkWell(
            onTap: () {
              // Navigate to Terms & Conditions page
            },
            child: const Text(
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                color: AppColors.textPrimary,
                decoration: TextDecoration.underline,
                fontFamily: 'Poppins',
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}