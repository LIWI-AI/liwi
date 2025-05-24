import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sara_ai/src/utils/widgets/text_button.dart';
import '../../../../utils/colors/main.dart';
import '../../../../utils/styles/font_weight.dart';
import '../../../../utils/text/consts.dart';
import '../../../../utils/text/main.dart';
import '../../../../utils/widgets/base_widget.dart';
import '../../../../utils/widgets/progress_indicator.dart';
import '../../../../utils/widgets/texts.dart';
import '../ai_tutor/ai_tutor.dart';

class ReviewPage extends StatefulWidget {
  final int index;

  const ReviewPage({super.key, required this.index});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> with SingleTickerProviderStateMixin {
  var appName = TextUtils.capitalize(TextConsts.appName);
  // Animation controller
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  // Content lists
  final List<String> _titles = [
    "Fluency grows with practice.",
    "Listening can be hard at first.",
    "Grammar? Don't worry.",
    "Building vocabulary takes time. But no worries",
    "It's okay to feel shy."
  ];
  late final List<String> _subtitles;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    _slideAnimation = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    _animationController.forward();
    
    _subtitles = [
      "Not pressure! We'll have friendly conversations every day, and step by step, you'll speak smoothly. **Let's do it with $appName!**",
      "But with real conversation practice, it gets easier. Let's tune your ears to English, **with $appName by your side.**",
      "we'll learn it in a fun, simple way. No boring lessons — just real talk. **We'll master it together with $appName.**",
      "we'll learn and use new words naturally in our daily chats. **We've got this, with $appName!**",
      "We'll take small, safe steps together. With daily chats and kind support, you'll gain confidence — **with $appName cheering you on!**"
    ];
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("index T: ${widget.index}");
    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          // Progress indicator with proper padding
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: progressIndicator(widget.index, context),
          ),
          
          const SizedBox(height: 24),
          
          // Title with animation
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: text(
                    context,
                    text: _titles[widget.index],
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: CustomFontWeight.semiBold,
                      color: AppColors.textPrimary,
                      fontFamily: 'Poppins',
                      height: 1.3,
                    ),
                  ),
                ),
              );
            },
          ),
          
          const SizedBox(height: 16),
          
          // Subtitle with animation
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: enhancedSubtitle(
                      text: _subtitles[widget.index],
                      style: const TextStyle(
                        fontWeight: FontWeight.w400, // Using standard FontWeight instead
                        fontSize: 16,
                        color: AppColors.textSecondary,
                        fontFamily: 'Poppins',
                        height: 1.4,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          
          // Review card with animation
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.translate(
                  offset: Offset(0, _slideAnimation.value),
                  child: ReviewBox(
                    model: ReviewModel(
                      title: 'I love',
                      description:
                          "I love this app! It corrects you, suggests answers, and improves your basic English by offering better word choices",
                      name: "Thomas P",
                      stars: 4
                    ),
                  ),
                ),
              );
            },
          ),
          
          const Spacer(),
          
          // Continue button with proper padding
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: textButton(
              context, 
              text: "Continue", 
              onPressed: () {
                print("From Review = 3");
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AiTutorPage(pageIndex: 3))
                );
              },
              withShadow: true,
              color: AppColors.mainButtonLight,
            ),
          ),
        ],
      )
    );
  }
}

class ReviewBox extends StatelessWidget {
  const ReviewBox({super.key, required this.model});
  final ReviewModel model;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Star rating
            Row(
              children: [
                ...List.generate(model.stars, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: SvgPicture.asset(
                      'assets/image/star.svg',
                      height: 20,
                      width: 20,
                      colorFilter: const ColorFilter.mode(
                        Colors.amber, 
                        BlendMode.srcIn
                      ),
                    ),
                  );
                }),
                ...List.generate(5 - model.stars, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: SvgPicture.asset(
                      'assets/image/star.svg',
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        Colors.grey.shade300, 
                        BlendMode.srcIn
                      ),
                    ),
                  );
                }),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Title
            Text(
              model.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: CustomFontWeight.bold,
                color: AppColors.textPrimary,
                fontFamily: 'Poppins',
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Description
            Text(
              model.description,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400, // Using standard FontWeight instead
                color: AppColors.textSecondary,
                fontFamily: 'Poppins',
                height: 1.4,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Reviewer name
            Text(
              model.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: CustomFontWeight.medium,
                color: AppColors.textPrimary.withOpacity(0.7),
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget enhancedSubtitle({required String text, TextStyle? style}) {
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
        fontWeight: CustomFontWeight.bold, 
        color: AppColors.textPrimary,
        fontFamily: 'Poppins',
      ),
    ));
    start = match.end;
  }

  if (start < text.length) {
    spans.add(TextSpan(text: text.substring(start)));
  }

  return Text.rich(
    TextSpan(
      children: spans,
      style: style ?? const TextStyle(
        fontSize: 16,
        fontFamily: 'Poppins',
      ),
    ),
  );
}

class ReviewModel {
  String title;
  String description;
  String name;
  int stars;

  ReviewModel({
    required this.title,
    required this.description,
    required this.name,
    required this.stars,
  });
}