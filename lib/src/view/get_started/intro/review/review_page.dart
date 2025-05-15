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

class _ReviewPageState extends State<ReviewPage> {
  var appName = TextUtils.capitalize(TextConsts.appName);
  // This widget has Title, Subtitle, and Review Card
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
    _subtitles = [
      "Not pressure! We'll have friendly conversations every day, and step by step, you'll speak smoothly. **Let's do it with $appName!**",
      "But with real conversation practice, it gets easier. Let's tune your ears to English, **with $appName by your side.**",
      "we'll learn it in a fun, simple way. No boring lessons — just real talk. **We'll master it together with $appName.**",
      "we'll learn and use new words naturally in our daily chats. **We've got this, with $appName!**",
      "We'll take small, safe steps together. With daily chats and kind support, you'll gain confidence — **with $appName cheering you on!**"
    ];
  }

  @override
  Widget build(BuildContext context) {
    print("index T: ${widget.index}");
    return BaseWidget(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Progress indicator
      progressIndicator(widget.index, context),
      // const SizedBox(height: 10),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: text(
          context,
          text: _titles[widget.index],
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 26,
            fontWeight: CustomFontWeight.semiBold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      SizedBox(height: 10),
      _subTitle(
          text: _subtitles[widget.index],
          style: TextStyle(
            fontWeight: CustomFontWeight.semiBold,
            fontSize: 18,
            color: AppColors.textSecondary,
          )),
      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
      // Review card
      ReviewBox(
        model: ReviewModel(
            title: 'I love',
            description:
                "I love this app! It corrects you, suggests answers, and improves your basic English by offering better word choices",
            name: "Thomas P",
            stars: 4),
      ),
      Spacer(),
      textButton(context, text: "Continue", onPressed: () {
        print("From Review = 3");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AiTutorPage(pageIndex: 3)));
      })
    ]));
  }
}

class ReviewBox extends StatelessWidget {
  const ReviewBox({super.key, required this.model});
  final ReviewModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(20),
      height: 206,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: AppColors.textSecondary, blurRadius: 3)],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // height: 30,
              child: Row(
                children: List.generate(model.stars, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, top: 10),
                    child: SvgPicture.asset('assets/image/star.svg',
                        height: 20,
                        width: 20,
                        colorFilter: ColorFilter.mode(
                            Colors.amberAccent, BlendMode.values[5])),
                  );
                }),
              ),
            ),
            const SizedBox(height: 10),
            text(context,
                text: model.title,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: CustomFontWeight.bold,
                    color: AppColors.textPrimary)),
            // const SizedBox(height: 5),
            text(context,
                text: model.description,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: CustomFontWeight.bold,
                    color: AppColors.textSecondary)),
            const SizedBox(height: 15),
            text(context,
                text: model.name,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: CustomFontWeight.bold,
                    color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}

Widget _subTitle({required String text, TextStyle? style}) {
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
          fontWeight: CustomFontWeight.semiBold, color: AppColors.textPrimary),
    ));
    start = match.end;
  }

  if (start < text.length) {
    spans.add(TextSpan(text: text.substring(start)));
  }

  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Text.rich(
        TextSpan(
          children: spans,
          style: style ?? const TextStyle(fontSize: 16),
        ),
      ));
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
