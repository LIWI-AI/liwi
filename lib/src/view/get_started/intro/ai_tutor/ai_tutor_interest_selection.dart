// import 'package:flutter/material.dart';
// import 'package:sara_ai/src/utils/widgets/base_widget.dart';
// import '../../../../utils/colors/main.dart';
// import '../../../../utils/styles/font_weight.dart';
// import '../../../../utils/text/consts.dart';
// import '../../../../utils/text/main.dart';
// import '../../../../utils/widgets/progress_indicator.dart';
// import '../../../../utils/widgets/text_button.dart';
// import 'ai_tutor_intro_page.dart';

// class AiTutorInterestsSelectionPage extends StatefulWidget {
//   const AiTutorInterestsSelectionPage({super.key});

//   @override
//   State<AiTutorInterestsSelectionPage> createState() =>
//       _AiTutorInterestsSelectionPageState();
// }

// class _AiTutorInterestsSelectionPageState
//     extends State<AiTutorInterestsSelectionPage> {
//   final String que = "Now, choose 3 or more interests";
//   List<String> selectedInterests = [];

//   @override
//   void initState() {
//     super.initState();
//   }

//   void handleSelection(int index) {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BaseWidget(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           progressIndicator(5, context),
//           const SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               const CircleAvatar(
//                 radius: 40,
//                 // backgroundImage: AssetImage('assets/images/sara.png'),
//               ),
//               const SizedBox(width: 10),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       TextUtils.capitalize(TextConsts.appName),
//                       style: TextStyle(
//                           fontSize: 20, fontWeight: CustomFontWeight.medium),
//                     ),
//                     const SizedBox(height: 4),
//                     bubble(
//                       text: que,
//                       style: TextStyle(
//                           fontSize: 14, fontWeight: CustomFontWeight.semiBold),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 50),
//           SizedBox(
//             height: MediaQuery.of(context).size.height * 0.59,
//             child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3),
//                 itemBuilder: (context, index) {
//                   return SizedBox(

//                   );
//                 }),
//           ),
//           const Spacer(),
//           textButton(
//             context,
//             text: 'Continue',
//             onPressed: () {},
//             color: selectedInterests.length <= 3
//                 ? AppColors.mainButtonLight
//                 : AppColors.disabledButton,
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/colors/main.dart';
import 'package:sara_ai/src/utils/widgets/base_widget.dart';
import 'package:sara_ai/src/utils/widgets/progress_indicator.dart';
import 'package:sara_ai/src/utils/widgets/text_button.dart';

import '../../../../utils/styles/font_weight.dart';
import '../../../../utils/text/consts.dart';
import '../../../../utils/text/main.dart';
import 'ai_tutor.dart';
import 'ai_tutor_intro_page.dart';

class InterestSelectionPage extends StatefulWidget {
  const InterestSelectionPage({Key? key}) : super(key: key);

  @override
  _InterestSelectionPageState createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> with SingleTickerProviderStateMixin {
  final List<Map<String, String>> interests = [
    {'icon': '🎨', 'label': 'Art & Design'},
    {'icon': '📖', 'label': 'Books'},
    {'icon': '💼', 'label': 'Business'},
    {'icon': '🏃', 'label': 'Career'},
    {'icon': '👨‍🍳', 'label': 'Cooking'},
    {'icon': '🎓', 'label': 'Education'},
    {'icon': '🌍', 'label': 'Nature'},
    {'icon': '🍔', 'label': 'Food'},
    {'icon': '🍿', 'label': 'Movies'},
    {'icon': '🎵', 'label': 'Music'},
    {'icon': '📰', 'label': 'News'},
    {'icon': '✈️', 'label': 'Travel'},
  ];
  
  final String question = "Now, choose 3 or more interests";
  final List<int> selectedIndices = [];
  
  // Animation controller
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controller
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
    
    _animationController.forward();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress indicator with proper padding
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: progressIndicator(4, context),
          ),
          
          const SizedBox(height: 20),
          
          // Tutor section
          Row(
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
                    enhancedBubble(
                      text: question,
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Interest grid with animation
          Expanded(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: interests.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.78, // Adjusted for better fit
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      bool isSelected = selectedIndices.contains(index);
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedIndices.remove(index);
                            } else {
                              selectedIndices.add(index);
                            }
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFFF1EBFF) : Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF876CFE)
                                      : const Color(0xFFEEEEEE),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: isSelected 
                                        ? const Color(0xFF876CFE).withOpacity(0.2)
                                        : Colors.black.withOpacity(0.03),
                                    spreadRadius: 0,
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  interests[index]['icon']!,
                                  style: const TextStyle(fontSize: 30),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              interests[index]['label']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          
          // Continue button with proper padding
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: textButton(
              context, 
              text: "Continue", 
              onPressed: () {
                if (selectedIndices.length >= 3) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AiTutorPage(pageIndex: 4),
                  ));
                }
              },
              color: selectedIndices.length >= 3 
                  ? AppColors.mainButtonLight
                  : AppColors.disabledButton,
              withShadow: selectedIndices.length >= 3,
            ),
          ),
        ],
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