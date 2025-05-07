import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/colors/main.dart';
import 'package:sara_ai/src/utils/widgets/base_widget.dart';
import 'package:sara_ai/src/utils/widgets/text_button.dart';
import 'package:sara_ai/src/utils/widgets/text_input.dart';
import 'package:sara_ai/src/utils/widgets/texts.dart';
import 'package:sara_ai/src/view/authentication/login.dart';
import '../../utils/styles/font_weight.dart';
import '../../utils/widgets/signup_options.dart';
import '../get_started/language_selector/language_selector.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BaseWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              // width: screenWidth * 0.5,
              height: screenWidth * 0.3575,
            ),
            text(context,
                text: 'Create an account',
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: CustomFontWeight.bold,
                    color: AppColors.textPrimary)),
            // const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? ',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textPrimary)),
                InkWell(
                  onTap: () {
                    // Navigate to Sign Up page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text('Login',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                          fontWeight: CustomFontWeight.semiBold)),
                )
              ],
            ),
            const SizedBox(height: 20),
            textInput(
                hintText: "Email address",
                hintStyle:
                    TextStyle(fontSize: 14, color: AppColors.textPrimary),
                controller: emailController),
            const SizedBox(height: 20),
            textInput(
                hintText: "Password",
                isPassword: true,
                suffixIcon: const Icon(Icons.visibility_off),
                onChanged: (value) {},
                hintStyle:
                    TextStyle(fontSize: 14, color: AppColors.textPrimary),
                controller: emailController),
            const SizedBox(height: 20),
            textButton(context,
                text: 'Continue',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageSelectorPage()));
                },
                color: AppColors.mainButtonLight),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.black,
                    thickness: 1.5,
                    // height: 10,
                    indent: screenWidth * 0.05,
                    endIndent: screenWidth * 0.02,
                  ),
                ),
                const Text('or sign up with',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textPrimary)),
                Expanded(
                  child: Divider(
                    color: Colors.black,
                    thickness: 1.5,
                    // height: 10,
                    indent: screenWidth * 0.02,
                    endIndent: screenWidth * 0.05,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                signUpWith(context, const Icon(Icons.facebook), onPressed: () {  }),
                signUpWith(context, const Icon(Icons.apple),onPressed: () {  }),
                signUpWith(context, const Icon(Icons.facebook),onPressed: () {  }),
              ],
            ),
            Spacer(),
            const Text(
              'By clicking create account you agree to recognises',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w300, color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      // Navigate to Terms & Conditions page
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
                    },
                    child: const Text('Terms of use',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textPrimary,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center)),
                const Text(
                  ' and ',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w300, color: AppColors.textPrimary),
                  textAlign: TextAlign.center,
                ),
                InkWell(
                    onTap: () {
                      // Navigate to Terms & Conditions page
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
                    },
                    child: const Text('Privacy policy',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: AppColors.textPrimary,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
