import 'package:flutter/material.dart';
import '../colors/main.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, required this.child});
  final Widget child;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: false, // Prevents auto-resizing which can cause issues with gradients
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: GestureDetector(
            onTap: () {
              // Hide keyboard when tapping outside of text fields
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}