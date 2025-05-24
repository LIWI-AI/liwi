import 'package:flutter/material.dart';
import '../../../../utils/colors/main.dart';
import '../../../../utils/widgets/base_widget.dart';
import '../../../../utils/widgets/text_button.dart';
import '../../../../utils/text/consts.dart';
import '../../../../utils/text/main.dart';
import '../../../../utils/widgets/progress_indicator.dart';
import '../review/review_page.dart';
import 'ai_tutor.dart';

class AiTutorIntroPage extends StatefulWidget {
  const AiTutorIntroPage({super.key});

  @override
  State<AiTutorIntroPage> createState() => _AiTutorIntroPageState();
}

class _AiTutorIntroPageState extends State<AiTutorIntroPage> with SingleTickerProviderStateMixin {
  // Animation controllers
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation1;
  late Animation<double> _fadeAnimation2;
  late Animation<double> _scaleAnimation1;
  late Animation<double> _scaleAnimation2;
  
  bool _firstBubbleVisible = false;
  bool _secondBubbleVisible = false;

  @override
  void initState() {
    super.initState();
    
    // Set up animations with longer duration (2.5 seconds instead of 1.5 seconds)
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 3500), // Increased duration
      vsync: this,
    );
    
    // First bubble animations with more spacing between them
    _fadeAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut), // Reduced interval
      ),
    );
    
    _scaleAnimation1 = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut), // Reduced interval
      ),
    );
    
    // Second bubble animations with more delay
    _fadeAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut), // Added more gap between animations
      ),
    );
    
    _scaleAnimation2 = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.5, 0.8, curve: Curves.easeOut), // Added more gap between animations
      ),
    );
    
    // Add listener to handle visibility states
    _animationController.addListener(() {
      if (_fadeAnimation1.value > 0 && !_firstBubbleVisible) {
        setState(() {
          _firstBubbleVisible = true;
        });
      }
      if (_fadeAnimation2.value > 0 && !_secondBubbleVisible) {
        setState(() {
          _secondBubbleVisible = true;
        });
      }
    });
    
    // Start animation after a longer delay
    Future.delayed(const Duration(milliseconds: 800), () { // Increased delay
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void goToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AiTutorPage(
          pageIndex: 0, 
          selectedIndex: null
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress indicator with better padding
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: progressIndicator(0, context),
          ),
          
          // Properly sized spacer
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          
          // Avatar with shadow for better visual presence
          Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.mainButtonLight.withOpacity(0.2),
                child: Icon(
                  Icons.person,
                  size: 70,
                  color: AppColors.mainButtonLight,
                ),
                // Use your actual avatar image when available
                // backgroundImage: AssetImage('assets/images/sara.png')
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          
          // Animated speech bubbles
          if (_firstBubbleVisible)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation1.value,
                  child: Transform.scale(
                    scale: _scaleAnimation1.value,
                    alignment: Alignment.topLeft,
                    child: animatedBubble(
                      text: "Hi, I'm **${TextUtils.capitalize(TextConsts.appName)}**, your Tutor!",
                    ),
                  ),
                );
              },
            ),
          
          const SizedBox(height: 12),
          
          if (_secondBubbleVisible)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation2.value,
                  child: Transform.scale(
                    scale: _scaleAnimation2.value,
                    alignment: Alignment.topLeft,
                    child: animatedBubble(
                      text: "Just **5 questions** before you start your first lesson!",
                    ),
                  ),
                );
              },
            ),
          
          const Spacer(),
          
          // Button with proper spacing and shadow
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: textButton(
              context,
              text: 'Continue',
              color: AppColors.mainButtonLight,
              onPressed: () => goToNextPage(),
              withShadow: true,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget animatedBubble({required String text}) {
    return bubble(text: text, style: const TextStyle(
      fontSize: 16,
      fontFamily: 'Poppins',
    ));
  }
}

Widget bubble({required String text, TextStyle? style}) {
  final spans = <InlineSpan>[];
  final regex = RegExp(r'\*\*(.*?)\*\*');
  int start = 0;

  for (final match in regex.allMatches(text)) {
    if (match.start > start) {
      spans.add(TextSpan(text: text.substring(start, match.start)));
    }
    spans.add(TextSpan(
      text: match.group(1),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontFamily: 'Poppins',
      ),
    ));
    start = match.end;
  }

  if (start < text.length) {
    spans.add(TextSpan(text: text.substring(start)));
  }

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000), // 5% shadow
            offset: Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Text.rich(
        TextSpan(
          children: spans,
          style: style ?? const TextStyle(
            fontSize: 16, 
            fontFamily: 'Poppins',
          ),
        ),
      ),
    )
  );
}

class AiTutorModel {
  final List<String> question;
  final List<List<String>> options;
  final List<List<IconData>> icons;
  final int selectedIndex;

  AiTutorModel({
    required this.question,
    required this.options,
    required this.icons,
    required this.selectedIndex,
  });
}