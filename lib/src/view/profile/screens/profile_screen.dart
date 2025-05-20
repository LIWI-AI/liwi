import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/colors/main.dart';
import 'package:sara_ai/src/view/home/screens/home_page.dart';
import 'package:sara_ai/src/view/home/widgets/bottom_nav_bar.dart';
import 'package:sara_ai/src/view/profile/widgets/achievements_tab.dart';
import 'package:sara_ai/src/view/profile/widgets/profile_header.dart';
import 'package:sara_ai/src/view/profile/widgets/progress_tab.dart';
import 'package:sara_ai/src/view/profile/widgets/settings_tab.dart';
import 'package:sara_ai/src/view/profile/widgets/tab_selector.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedTabIndex = 0;
  
  // Tab content widgets - FIXED HEIGHT for ListView tabs
  late final List<Widget> _tabContents;
  
  // Tab titles
  final List<String> _tabTitles = [
    'Progress',
    'Achievements',
    'Settings',
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize tab contents with fixed height constraints
    _tabContents = [
      const ProgressTab(),
      SizedBox(
        height: 300, // Fixed height for AchievementsTab to make it visible
        child: const AchievementsTab(),
      ),
      const SettingsTab(),
    ];
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.backgroundGradient,
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              // Main content with wider horizontal padding for full-width content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16), // Reduced padding for wider content
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile header section
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 16, left: 4),
                        child: Text(
                          'Profile',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black.withOpacity(0.8),
                          ),
                        ),
                      ),
                      
                      // Profile header with consistent width and styling
                      const ProfileHeader(),
                      
                      const SizedBox(height: 20),
                      
                      // Simple plan widget matching the image
                      const PlanWidget(),
                      
                      const SizedBox(height: 20),
                      
                      // Tab selector with perfect alignment
                      TabSelector(
                        tabTitles: _tabTitles,
                        selectedIndex: _selectedTabIndex,
                        onTabSelected: _onTabSelected,
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Tab content container - INCREASED WIDTH
                      Container(
                        width: MediaQuery.of(context).size.width, // Use full screen width
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.25),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              offset: const Offset(0, 3),
                              blurRadius: 12,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        // Reduced horizontal padding inside tab content to give more space for cards
                        padding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                        child: _tabContents[_selectedTabIndex],
                      ),
                      
                      // Space for bottom navigation bar
                      const SizedBox(height: 90),
                    ],
                  ),
                ),
              ),
              
              // Position bottom navigation bar at the bottom
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CustomBottomNavigationBar(
                    initialSelectedIndex: 3, // Set profile tab (index 3) as selected
                    onNavigate: (index) {
                      // Don't do anything if profile tab is tapped (already on profile)
                      if (index == 3) return;
                      
                      // Navigate based on tab index
                      if (index == 0) { // Home tab
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      } else if (index == 1) { // Pro tab
                        // Pro screen not built yet
                      } else if (index == 2) { // Learn tab
                        // Learn screen not built yet
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}