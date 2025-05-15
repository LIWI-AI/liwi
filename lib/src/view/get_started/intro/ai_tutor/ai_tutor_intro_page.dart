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

class _AiTutorIntroPageState extends State<AiTutorIntroPage> {

  // @override
  // void initState() {
  //   super.initState();
  //   currentValue = widget.value;
  // }

  void goToNextPage() {
    // if (currentValue == 3) {
    //   print("Last page reached");
    //   // Navigate to summary page or whatever next
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => ReviewPage(index: currentValue)));
    // } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AiTutorPage(
                  pageIndex: 0, selectedIndex: null)));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          progressIndicator(0, context),
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          // Avatar
          Center(
              child: CircleAvatar(
            radius: 60,     
            // backgroundImage: AssetImage('assets/images/sara.png')
          )),
          const SizedBox(height: 30),
          // Speech bubbles
          bubble(
              text:
                  "Hi, I'm **${TextUtils.capitalize(TextConsts.appName)}**, your Tutor!"),
          const SizedBox(height: 12),
          bubble(
              text: "Just **5 questions** before you start your first lesson!"),
          Spacer(),
          textButton(
            context,
            text: 'Continue',
            color: AppColors.mainButtonLight,
            onPressed: () => goToNextPage(),
          ),
        ],
      ),
    );
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
      style: const TextStyle(fontWeight: FontWeight.bold),
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
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            )),
        child: Text.rich(
          TextSpan(
            children: spans,
            style: style ?? const TextStyle(fontSize: 16),
          ),
        ),
      ));
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
