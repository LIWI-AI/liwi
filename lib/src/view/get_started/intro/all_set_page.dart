import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sara_ai/src/utils/colors/main.dart';
import 'package:sara_ai/src/utils/widgets/base_widget.dart';
import 'package:sara_ai/src/view/home/screens/home_page.dart';

class PersonalizationFlow extends StatefulWidget {
  const PersonalizationFlow({super.key});

  @override
  State<PersonalizationFlow> createState() => _PersonalizationFlowState();
}

class _PersonalizationFlowState extends State<PersonalizationFlow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  late Animation<double> _rotationAnimation;
  bool _isCompleted = false;
  
  final List<String> _tasks = [
    "Creating your profile",
    "Setting your journey goals",
    "Curating personalized content",
    "Tuning the AI model",
    "Building your custom plan"
  ];
  
  int _currentTaskIndex = 0;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 6000),
      vsync: this,
    );
    
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {
        // Update current task based on progress
        _currentTaskIndex = (_progressAnimation.value * _tasks.length).floor();
        if (_currentTaskIndex >= _tasks.length) {
          _currentTaskIndex = _tasks.length - 1;
        }
      });
    });
    
    _rotationAnimation = Tween<double>(begin: 0, end: 3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );
    
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        HapticFeedback.mediumImpact();
        Future.delayed(const Duration(milliseconds: 400), () {
          setState(() {
            _isCompleted = true;
          });
        });
      }
    });
    
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToHome() {
    if (_isCompleted) {
      HapticFeedback.lightImpact();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToHome,
      child: BaseWidget(
        child: SafeArea(
          child: _isCompleted 
              ? CompletedView(tasks: _tasks, onTap: _navigateToHome)
              : LoadingView(
                  progress: _progressAnimation.value,
                  rotationValue: _rotationAnimation.value,
                  currentTaskIndex: _currentTaskIndex,
                  tasks: _tasks,
                ),
        ),
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  final double progress;
  final double rotationValue;
  final int currentTaskIndex;
  final List<String> tasks;
  
  const LoadingView({
    Key? key,
    required this.progress,
    required this.rotationValue,
    required this.currentTaskIndex,
    required this.tasks,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final progressPercent = (progress * 100).toInt();
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Added flexible spacer to push content down
          SizedBox(height: screenSize.height * 0.07),
          
          // Header section
          const Text(
            'Personalizing Your Learning',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins',
              height: 1.3,
            ),
          ),
          
          const SizedBox(height: 8),
          
          const Text(
            'Creating your customized learning plan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
              fontFamily: 'Poppins',
            ),
          ),
          
          SizedBox(height: screenSize.height * 0.06),
          
          // Progress circle
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Rotating circle
                RotationTransition(
                  turns: AlwaysStoppedAnimation(rotationValue),
                  child: Container(
                    width: screenSize.width * 0.5,
                    height: screenSize.width * 0.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.transparent,
                        width: 4,
                      ),
                      gradient: SweepGradient(
                        colors: [
                          AppColors.mainButtonLight.withOpacity(0.2),
                          AppColors.mainButtonLight,
                        ],
                        stops: const [0.0, 1.0],
                      ),
                    ),
                  ),
                ),
                
                // Inner circle - white background
                Container(
                  width: screenSize.width * 0.45,
                  height: screenSize.width * 0.45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  // Progress text
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$progressPercent',
                            style: const TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              '%',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Personalizing",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: screenSize.height * 0.06),
          
          // Current task indicator
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.mainButtonLight.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.mainButtonLight,
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.mainButtonLight),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    currentTaskIndex < tasks.length 
                        ? tasks[currentTaskIndex]
                        : tasks.last,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Completed tasks list - scrollable
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  currentTaskIndex,
                  (index) => Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.green.shade400,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            tasks[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Instructions
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                "Please wait while we set up your experience",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompletedView extends StatelessWidget {
  final List<String> tasks;
  final VoidCallback onTap;
  
  const CompletedView({
    Key? key,
    required this.tasks,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Added flexible spacer to push content down
          SizedBox(height: screenSize.height * 0.07),
          
          // Header with animations
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "You're All Set!",  // Fixed apostrophe
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your personalized learning journey awaits',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: screenSize.height * 0.06),
          
          // Success check animation
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green.shade50,
                      border: Border.all(
                        color: Colors.green,
                        width: 4,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.2),
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 70,
                    ),
                  ),
                );
              },
            ),
          ),
          
          SizedBox(height: screenSize.height * 0.05),
          
          // Completed tasks in a scrollable list
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(
                  tasks.length,
                  (index) => TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 400 + (index * 150)),
                    curve: Curves.easeOutCubic,
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(30 * (1 - value), 0),
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.green.shade400,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    tasks[index],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          
          // Start button
          GestureDetector(
            onTap: onTap,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, 40 * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.mainButtonLight,
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mainButtonLight.withOpacity(0.4),
                            offset: const Offset(0, 4),
                            blurRadius: 12,
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          "Start Learning",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}