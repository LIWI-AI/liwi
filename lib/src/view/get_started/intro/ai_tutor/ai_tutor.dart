import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/widgets/base_widget.dart';
import 'package:sara_ai/src/view/get_started/intro/ai_tutor/ai_tutor_interest_selection.dart';
import 'package:sara_ai/src/view/get_started/intro/review/review_page.dart';
import '../../../../utils/colors/main.dart';
import '../../../../utils/styles/font_weight.dart';
import '../../../../utils/text/consts.dart';
import '../../../../utils/text/main.dart';
import '../../../../utils/widgets/progress_indicator.dart';
import '../../../../utils/widgets/text_button.dart';
import '../all_set_page.dart';
import 'ai_tutor_intro_page.dart';

class AiTutorPage extends StatefulWidget {
  const AiTutorPage({
    super.key,
    required this.pageIndex,
    this.selectedIndex,
  });
  final int pageIndex;
  final int? selectedIndex;

  @override
  State<AiTutorPage> createState() => _AiTutorPageState();
}

class _AiTutorPageState extends State<AiTutorPage> with SingleTickerProviderStateMixin {
  int? localSelectedIndex;
  late int currentPageIndex;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  final ScrollController _scrollController = ScrollController();

  final List<String> _questions = [
    "How would you rate your English skills on a scale of 1 to 4?",
    "Why do you want to speak better English?",
    "What's your main challenge in English?",
    "What do you like to do in your free time?",
    "What's your daily speaking goal?",
  ];

  final List<List<String>> _options = [
    [
      "Basic",
      "Intermediate",
      "Advanced",
      "Professional",
    ],
    [
      "Advance my career",
      "Learn new skills",
      "Support my education",
      "Prepare for travel",
      "To talk to new people",
      "Just for fun"
    ],
    [
      "Speaking fluently",
      "Understanding people",
      "Grammar and rules",
      "Finding words",
      "Feeling shy to speak",
    ],
    [
      "Listening to music",
      "Watching movies",
      "Reading books",
      "Playing games",
      "Walking or cooking",
    ],
    [
      "5 min / day",
      "10 min / day",
      "15 min / day",
      "20 min / day",
    ],
  ];

  final List<List<IconData>> _icons = [
    [],
    [
      CupertinoIcons.briefcase,
      Icons.lightbulb_outline_sharp,
      Icons.school_outlined,
      Icons.airplanemode_active,
      Icons.people_alt_outlined,
      Icons.sentiment_satisfied,
    ],
    [],
    [
      Icons.headset_outlined,
      Icons.ondemand_video_rounded,
      CupertinoIcons.book,
      CupertinoIcons.game_controller,
      Icons.restaurant_menu
    ],
    []
  ];

  @override
  void initState() {
    super.initState();
    localSelectedIndex = widget.selectedIndex;
    currentPageIndex = widget.pageIndex;
    
    // Setup animations for question bubble only
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    // Start animation
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void handleSelection(int index) {
    setState(() {
      localSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = AiTutorModel(
      question: _questions,
      options: _options,
      icons: _icons,
      selectedIndex: widget.selectedIndex ?? 0,
    );

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        print('Pop Worked');
        if (didPop && currentPageIndex > 0) {
          setState(() {
            currentPageIndex--;
          });
        }
      },
      child: BaseWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator with proper padding
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: progressIndicator(currentPageIndex + 1, context),
            ),
            const SizedBox(height: 20),
            
            // Tutor section with avatar and question bubble
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFEDE7FE),
                    child: Icon(
                      Icons.person,
                      size: 35,
                      color: Color(0xFF876CFE),
                    ),
                    // backgroundImage: AssetImage('assets/images/sara.png'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        TextUtils.capitalize(TextConsts.appName),
                        style: const TextStyle(
                          fontSize: 18, 
                          fontWeight: CustomFontWeight.medium,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Only animate the question bubble
                      AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Transform.scale(
                              scale: _scaleAnimation.value,
                              alignment: Alignment.topLeft,
                              child: enhancedBubble(
                                text: model.question[currentPageIndex],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // SCROLLABLE options container
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(model.options[currentPageIndex].length, (index) {
                    final isSelected = localSelectedIndex == index;
                    
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => handleSelection(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 18),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? AppColors.mainButtonLight
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: isSelected
                                    ? AppColors.mainButtonLight
                                    : const Color(0xFFEEEEEE),
                                width: 1.5),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? AppColors.mainButtonLight.withOpacity(0.3)
                                    : Colors.black.withOpacity(0.05),
                                offset: const Offset(0, 4),
                                blurRadius: isSelected ? 12 : 6,
                                spreadRadius: isSelected ? 1 : 0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              if (model.icons[currentPageIndex].length > index) ...[
                                Icon(
                                  model.icons[currentPageIndex][index],
                                  color: isSelected ? Colors.white : const Color(0xFF876CFE),
                                  size: 24,
                                ),
                                const SizedBox(width: 14),
                              ],
                              Expanded(
                                child: Text(
                                  model.options[currentPageIndex][index],
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black87,
                                    fontSize: 16,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 20,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            
            // Continue button with proper padding and shadow
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: textButton(
                context,
                text: 'Continue',
                onPressed: () {
                  print('Now current index = $currentPageIndex');
                  if (localSelectedIndex != null) {
                    if (currentPageIndex == 4) {
                      // All Set Page If currentPageIndex == 4
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PersonalizationFlow(),
                      ));
                    } else if (currentPageIndex == 3) {
                      print("selectedIndex : $localSelectedIndex");
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InterestSelectionPage(),
                      ));
                    } else if (currentPageIndex == 2) {
                      print("selectedIndex : $localSelectedIndex");
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ReviewPage(index: localSelectedIndex!),
                      ));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AiTutorPage(
                          pageIndex: currentPageIndex + 1,
                        ),
                      ));
                    }
                  }
                },
                color: localSelectedIndex != null
                    ? AppColors.mainButtonLight
                    : AppColors.disabledButton,
                withShadow: localSelectedIndex != null,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget enhancedBubble({required String text}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: CustomFontWeight.semiBold,
          fontFamily: 'Poppins',
          height: 1.3,
        ),
      ),
    );
  }
}