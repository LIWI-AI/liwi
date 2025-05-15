import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/colors/main.dart';
import 'package:sara_ai/src/utils/styles/font_weight.dart';
import 'package:sara_ai/src/utils/widgets/base_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/widgets/texts.dart';

class PersonalizationFlow extends StatefulWidget {
  const PersonalizationFlow({super.key});

  @override
  State<PersonalizationFlow> createState() => _PersonalizationFlowState();
}

class _PersonalizationFlowState extends State<PersonalizationFlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isDone = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    _animation = Tween<double>(begin: 0, end: 100).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward().whenComplete(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _isDone = true;
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        child: _isDone
            ? const DoneScreen()
            : ProgressScreen(progress: _animation.value),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final double progress;
  const ProgressScreen({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      key: const ValueKey("progress"),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        text(
          context,
          text: 'Sara is crafting your personalized journey...',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.topLeft,
          child: text(context,
              text: 'Personalization = Faster Progress!',
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  fontWeight: CustomFontWeight.semiBold),
              textAlign: TextAlign.start),
        ),
        SizedBox(height: size.height * 0.15, width: size.width),
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.mainButtonLight, width: 5),
            color: Colors.white,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                progress.toInt().toString(),
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
              ),
              const Text(
                "%",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.1),
        // const SizedBox(height: 40),
        const SkeletonLoader(isDone: false),
      ],
    );
  }
}

class DoneScreen extends StatelessWidget {
  const DoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      key: const ValueKey("progress"),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        Align(
          alignment: Alignment.topLeft,
          child: text(
            context,
            text: 'You are all set!',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(height: 65),
        SizedBox(height: size.height * 0.15, width: size.width),
        Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 5),
                color: Colors.transparent),
            alignment: Alignment.center,
            child: Center(
                child:
                    Icon(Icons.done_rounded, color: Colors.green, size: 60))),
        SizedBox(height: size.height * 0.1),
        // const SizedBox(height: 40),
        const SkeletonLoader(isDone: true),
      ],
    );
  }
}

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key, required this.isDone});
  final bool isDone;
  @override
  Widget build(BuildContext context) {
    List<String> list = [
      "Creating your profile",
      "Setting your journey goals",
      "Curating personalized content",
      "Turning the AI model",
      "Building your custom plan"
    ];
    return isDone
        ? Column(
            children: List.generate(
              list.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width * 0.7,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle,
                        color: Colors.green, size: 20),
                    const SizedBox(width: 8),
                    text(context,
                        text: list[index].toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: CustomFontWeight.semiBold),
                        textAlign: TextAlign.start),
                  ],
                ),
              ),
            ),
          )
        : Shimmer.fromColors(
            baseColor: Colors.white54,
            highlightColor: Colors.white10,
            child: Column(
              children: List.generate(
                5,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          );
  }
}
