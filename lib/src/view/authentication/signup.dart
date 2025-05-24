import 'package:flutter/cupertino.dart';
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
    
    // Check if keyboard is visible
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    
    return BaseWidget(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 
                       MediaQuery.of(context).padding.top - 
                       MediaQuery.of(context).padding.bottom,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                // Adjust top spacing when keyboard appears
                SizedBox(
                  height: keyboardVisible ? 40 : screenWidth * 0.3575,
                ),
                text(context,
                    text: 'Create an account',
                    style: const TextStyle(
                        fontSize: 26,
                        fontWeight: CustomFontWeight.bold,
                        color: AppColors.textPrimary,
                        fontFamily: 'Poppins')),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                          fontFamily: 'Poppins',
                        )),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text('Login',
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textPrimary,
                              fontWeight: CustomFontWeight.semiBold,
                              fontFamily: 'Poppins')),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                textInput(
                    hintText: "Email address",
                    hintStyle: const TextStyle(
                      fontSize: 14, 
                      color: AppColors.textPrimary,
                      fontFamily: 'Poppins',
                    ),
                    controller: emailController),
                const SizedBox(height: 20),
                textInput(
                    hintText: "Password",
                    isPassword: true,
                    suffixIcon: const Icon(Icons.visibility_off),
                    onChanged: (value) {},
                    hintStyle: const TextStyle(
                      fontSize: 14, 
                      color: AppColors.textPrimary,
                      fontFamily: 'Poppins',
                    ),
                    controller: passwordController),
                const SizedBox(height: 30),
                textButton(
                  context, 
                  text: 'Continue', 
                  onPressed: () {
                    // Hide keyboard
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LanguageSelectionScreen())
                    );
                  }, 
                  color: AppColors.mainButtonLight,
                  withShadow: true,
                ),
                
                // Only show these elements if keyboard is not visible
                if (!keyboardVisible) ...[
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1.5,
                          indent: 0,
                          endIndent: 10,
                        ),
                      ),
                      const Text(
                        'or sign up with',
                        style: TextStyle(
                          fontSize: 12, 
                          color: AppColors.textPrimary,
                          fontFamily: 'Poppins',
                        )
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 1.5,
                          indent: 10,
                          endIndent: 0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      signUpWith(context, const Icon(Icons.facebook), onPressed: () {}),
                      signUpWith(context, const Icon(Icons.apple), onPressed: () {}),
                      signUpWith(context, const Icon(Icons.g_mobiledata), onPressed: () {}),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    'By clicking create account you agree to recognises',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: AppColors.textPrimary,
                        fontFamily: 'Poppins'),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            // Navigate to Terms & Conditions page
                          },
                          child: const Text('Terms of use',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: AppColors.textPrimary,
                                decoration: TextDecoration.underline,
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.center)),
                      const Text(
                        ' and ',
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
                          child: const Text('Privacy policy',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: AppColors.textPrimary,
                                decoration: TextDecoration.underline,
                                fontFamily: 'Poppins',
                              ),
                              textAlign: TextAlign.center)),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                // Add padding at the bottom when keyboard is visible
                if (keyboardVisible)
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          ),
        ),
      ),
    );
  }
}