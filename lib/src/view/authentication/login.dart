import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/colors/main.dart';
import 'package:sara_ai/src/utils/text/consts.dart';
import 'package:sara_ai/src/utils/widgets/base_widget.dart';
import 'package:sara_ai/src/utils/widgets/text_button.dart';
import 'package:sara_ai/src/utils/widgets/text_input.dart';
import 'package:sara_ai/src/utils/widgets/texts.dart';

import '../../utils/styles/font_weight.dart';
import '../../utils/text/main.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              height: screenWidth * 0.4,
            ),
            text(context,
                text:
                    'Welcome back to ${TextUtils.capitalize(TextConsts.appName)}',
                style: const TextStyle(
                    fontSize: 26,
                    fontWeight: CustomFontWeight.bold,
                    color: AppColors.textPrimary)),
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
            // const SizedBox(height: 10),
            // remember me with a checkbox and forgot password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                      activeColor: AppColors.mainButtonLight,
                    ),
                    Text(
                      'Remember me',
                      style:
                          TextStyle(fontSize: 14, color: AppColors.textPrimary),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Text('Forgot password?',
                      style: const TextStyle(
                          fontSize: 14, color: AppColors.textPrimary)),
                ),
              ],
            ),
            textButton(context, text: 'Login', onPressed: () {
              // Navigate to Home page
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const HomePage()));
            }, color: AppColors.mainButtonLight),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New to ${TextConsts.appName}? ',
                    style:
                        TextStyle(fontSize: 12, color: AppColors.textPrimary)),
                InkWell(
                  onTap: () {
                    // Navigate to Sign Up page
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: const Text('Sign up',
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                          fontWeight: CustomFontWeight.semiBold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
