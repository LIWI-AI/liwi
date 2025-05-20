import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sara_ai/src/utils/widgets/base_widget.dart';
import 'package:sara_ai/src/view/chat/screens/lesson_chat_screen.dart';
import 'package:sara_ai/src/view/home/widgets/bottom_nav_bar.dart';
import 'package:sara_ai/src/view/home/widgets/locked_lesson_card.dart';
import 'package:sara_ai/src/view/profile/screens/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      child: Stack(
        children: [
          // Main content column
          Column(
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              // Main content area with ScrollView
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildLessonPath(context),
                      // Add space at bottom to ensure content isn't hidden behind the chat button
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
              
              // Add space for bottom navigation bar
              const SizedBox(height: 90),
            ],
          ),
          
          // Chat button - fixed position that doesn't scroll with content
          Positioned(
            right: 20,
            bottom: 100, // Position above bottom nav bar
            child: _buildAIChatButton(context),
          ),
          
          // Bottom navigation bar positioned at the bottom - MOVED OUTSIDE THE COLUMN
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavigationBar(
              initialSelectedIndex: 0, // Set home tab (index 0) as selected
              onNavigate: (index) {
                // Don't do anything if home tab is tapped (already on home)
                if (index == 0) return;
                
                // Navigate based on tab index
                if (index == 3) { // Profile tab
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                } else if (index == 1) { // Pro tab
                  // Pro screen not built yet
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => const ProScreen(),
                  //   ),
                  // );
                } else if (index == 2) { // Learn tab
                  // Learn screen not built yet
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(
                  //     builder: (context) => const LearnScreen(),
                  //   ),
                  // );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Streak counter with fire icon
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/Vector.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFFF9500), // Orange for fire icon
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '0',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Hearts counter with heart icon
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/diamond icon.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFC861FF), // Purple heart icon
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '0',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Stars counter with star icon
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/star icon.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFFFCC00), // Yellow for star icon
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '0',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Crown icon
          SvgPicture.asset(
            'assets/svg/premiumicon.svg',
            width: 28,
            height: 28,
            colorFilter: const ColorFilter.mode(
              Color(0xFFC861FF), // Purple crown
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonPath(BuildContext context) {
    return GamePathLessons(
      unlockedLevel: 0, // The first lesson is unlocked
      totalLevels: 2,   // Only 2 locked lessons as requested
      onStartLearning: () {
        // Navigate to the chat screen when Start Learning is tapped
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const LessonChatScreen(
              lessonId: 'lesson_1',
              lessonTitle: 'First lesson',
            ),
          ),
        );
      },
    );
  }

  Widget _buildAIChatButton(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          // Soft shadow
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            offset: const Offset(0, 3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
          // More pronounced shadow for depth
          BoxShadow(
            color: const Color(0xFFC861FF).withOpacity(0.15),
            offset: const Offset(0, 6),
            blurRadius: 12,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {
            // Navigate to chat screen when the chat button is tapped
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const LessonChatScreen(
                  lessonId: 'quick_chat',
                  lessonTitle: 'Quick Chat',
                ),
              ),
            );
          },
          child: Center(
            child: Builder(
              builder: (context) {
                try {
                  return SvgPicture.asset(
                    'assets/svg/Icons.svg', 
                    width: 35,
                    height: 35,
                    // Using your existing SVG without color filter as in your code
                  );
                } catch (e) {
                  // Fallback to using a Material icon if SVG fails to load
                  return const Icon(
                    Icons.chat_bubble_rounded,
                    color: Color(0xFFC861FF),
                    size: 28,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}