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

class _AiTutorPageState extends State<AiTutorPage> {
  int? localSelectedIndex;
  late int currentPageIndex;

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
      // MyFlutterApp.graduation_cap,
      Icons.school_outlined,
      Icons.airplanemode_active,
      Icons.people_alt_outlined,
      // MyFlutterApp.,
      Icons.sentiment_satisfied,
    ],
    [],
    [
      Icons.headset_outlined,
      Icons.ondemand_video_rounded,
      CupertinoIcons.book,
      CupertinoIcons.game_controller,
      // CupertinoIcons.
      Icons.restaurant_menu
    ],
    []
  ];

  @override
  void initState() {
    super.initState();
    localSelectedIndex = widget.selectedIndex;
    currentPageIndex = widget.pageIndex;
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
            progressIndicator(currentPageIndex + 1, context),
            const SizedBox(height: 10),
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
                        text: model.question[currentPageIndex],
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: CustomFontWeight.semiBold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            ...List.generate(model.options[currentPageIndex].length, (index) {
              final isSelected = localSelectedIndex == index;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: GestureDetector(
                  onTap: () => handleSelection(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 14),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppColors.border : AppColors.background,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: isSelected
                              ? AppColors.mainButtonLight
                              : Colors.white,
                          width: 1),
                    ),
                    child: Row(
                      children: [
                        if (model.icons[currentPageIndex].length > index) ...[
                          Icon(
                            model.icons[currentPageIndex][index],
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                          const SizedBox(width: 12),
                        ],
                        Expanded(
                          child: Text(
                            model.options[currentPageIndex][index],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            textButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
