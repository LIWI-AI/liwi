import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:ui';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  
  // Define the SVG paths for each tab - make sure these files exist
  final List<String> _iconPaths = [
    'assets/svg/home 1.svg',   
    'assets/svg/premiumm.svg',  
    'assets/svg/learn.svg',    
    'assets/svg/profile.svg',   
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
      });
      _animationController.reset();
      _animationController.forward();
    }
    // Handle navigation
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        // Gradient frosted glass effect
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.7),
            Colors.white.withOpacity(0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
        // Frosted glass border
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      // Apply backdrop filter for frosted glass effect
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) => Expanded(
              child: _buildNavItem(index, _getLabel(index)),
            )),
          ),
        ),
      ),
    );
  }
  
  // Helper method to get the right label based on index
  String _getLabel(int index) {
    switch (index) {
      case 0: return 'Home';
      case 1: return 'Pro';  // Shortened to save space
      case 2: return 'Learn';
      case 3: return 'Profile';
      default: return '';
    }
  }

  Widget _buildNavItem(int index, String label) {
    bool isSelected = _selectedIndex == index;
    
    // Brand colors with educational theme gradient
    List<Color> gradientColors = [
      const Color(0xFFC861FF), // Purple
      const Color(0xFF8273F0), // Light purple/blue
    ];
    
    Color inactiveColor = Colors.grey.shade600;
    
    // SVG widget with error handling
    Widget buildSvgIcon() {
      try {
        return SvgPicture.asset(
          _iconPaths[index],
          width: isSelected ? 28 : 24,
          height: isSelected ? 28 : 24,
          colorFilter: ColorFilter.mode(
            isSelected ? Colors.white : inactiveColor,
            BlendMode.srcIn,
          ),
        );
      } catch (e) {
        // Fallback to material icons if SVG fails
        IconData fallbackIcon;
        switch (index) {
          case 0: fallbackIcon = Icons.home_rounded; break;
          case 1: fallbackIcon = Icons.workspace_premium_rounded; break;
          case 2: fallbackIcon = Icons.school_rounded; break;
          case 3: fallbackIcon = Icons.person_rounded; break;
          default: fallbackIcon = Icons.circle; break;
        }
        return Icon(
          fallbackIcon,
          color: isSelected ? Colors.white : inactiveColor,
          size: isSelected ? 28 : 24,
        );
      }
    }
    
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with background when selected
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.all(8),
              decoration: isSelected
                  ? BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: gradientColors,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: gradientColors[0].withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ],
                    )
                  : null,
              child: buildSvgIcon(),
            ),
            
            // Text label
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? gradientColors[0] : inactiveColor,
                  fontSize: 10,
                  fontFamily: 'Poppins',
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

