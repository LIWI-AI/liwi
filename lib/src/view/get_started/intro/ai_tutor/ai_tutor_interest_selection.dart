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
  @override
  _InterestSelectionPageState createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> {
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
  final String que = "Now, choose 3 or more interests";
  final List<int> selectedIndices = [];

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        children: [
          progressIndicator(4, context),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 40,
                // backgroundImage: AssetImage('assets/images/sara.png'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TextUtils.capitalize(TextConsts.appName),
                      style: TextStyle(
                          fontSize: 20, fontWeight: CustomFontWeight.medium),
                    ),
                    const SizedBox(height: 4),
                    bubble(
                      text: que,
                      style: TextStyle(
                          fontSize: 14, fontWeight: CustomFontWeight.semiBold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 35),
          Expanded(
            child: GridView.builder(
              itemCount: interests.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              physics: FixedExtentScrollPhysics(),
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
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Colors.deepPurple
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            interests[index]['icon']!,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        interests[index]['label']!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          textButton(context, text: "Continue", onPressed: () {
            selectedIndices.length >= 3
                ? Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AiTutorPage(pageIndex: 4),
                  ))
                : null;
          },
          color: selectedIndices.length >= 3 ? AppColors.mainButtonLight:AppColors.disabledButton
          ),
        ],
      ),
    );
  }
}
