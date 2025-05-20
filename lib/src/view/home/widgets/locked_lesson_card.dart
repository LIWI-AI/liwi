import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GamePathLessons extends StatelessWidget {
  final int unlockedLevel;
  final VoidCallback onStartLearning;
  final int totalLevels;

  const GamePathLessons({
    Key? key, 
    required this.unlockedLevel,
    required this.onStartLearning,
    this.totalLevels = 2, // Default to 2 locked levels as requested
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fixed heights for better control
    final double firstPathHeight = 60;  // First connecting path
    final double longPathHeight = 130; // Fixed height for the longer connecting path
    
    return Column(
      children: [
        // First card - Start Learning
        _buildStartLearningCard(),
        
        // First Connection path - now with the same spacing as the second path
        _buildDashedConnectingPath(
          isUnlocked: unlockedLevel >= 0,
          height: firstPathHeight,
          dashHeight: 8,  // Larger dashes - matching second path
          gapHeight: 10,  // Larger gaps - matching second path
        ),
        
        // First lock (fully visible) - bigger size
        _buildLockIcon(0),
        
        // Long connection path with decreased opacity
        _buildDashedConnectingPath(
          isUnlocked: false, 
          opacity: 0.7,
          height: longPathHeight, // Fixed height connecting path
          dashHeight: 8,  // Larger dashes
          gapHeight: 10,  // Larger gaps between dashes
        ),
        
        // Second lock (decreased visibility)
        _buildLockIcon(1),
        
        // Add some space before bottom nav bar
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildStartLearningCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFD896FF), // Light purple
            Color(0xFF88BFFF), // Light blue
          ],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFC861FF).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'First lesson for you',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: 24,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Let\'s kick off your personalized journey toward confident English fluency.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.normal,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onStartLearning,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFC861FF),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Start Learning',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockIcon(int index) {
    // Vertical space adjusted based on index
    final double verticalSpace = index == 0 ? 5.0 : 5.0;
    
    // Calculate opacity based on index
    // First lock is fully visible, second lock has decreased visibility
    double opacity = index == 0 ? 1.0 : 0.8;
    
    // Keep container size the same but drastically increase the icon size
    final double containerSize = 80.0;
    final double iconSize =100.0;  
    
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalSpace),
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 201, 199, 199).withOpacity(0.3), // Lighter background to make the lock stand out
            borderRadius: BorderRadius.circular(20),
            // Add subtle glow to first lock
            boxShadow: index == 0 ? [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 3,
              ),
            ] : [],
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/svg/lock 1.svg',
              width: iconSize, // Much larger lock icon that almost fills the container
              height: iconSize,
              colorFilter: ColorFilter.mode(
                // Darker color for first lock, lighter for second
                index == 0 ? Colors.grey.shade700 : Colors.grey.shade400,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashedConnectingPath({
    required bool isUnlocked, 
    double opacity = 1.0, 
    double height = 40.0,
    double dashHeight = 5.0,
    double gapHeight = 3.0,
  }) {
    return Opacity(
      opacity: opacity,
      child: Container(
        height: height, // Variable height based on parameter
        width: 3,      // Slightly thicker line for better visibility
        child: CustomPaint(
          painter: DashedLinePainter(
            color: isUnlocked ? const Color(0xFFC861FF) : Colors.grey.withOpacity(0.5),
            dashHeight: dashHeight,
            gapHeight: gapHeight,
            strokeWidth: 3, // Thicker stroke
            isGlowing: isUnlocked,
            glowColor: isUnlocked ? const Color(0xFFC861FF).withOpacity(0.3) : Colors.transparent,
          ),
        ),
      ),
    );
  }
}

// Custom painter for drawing dashed/dotted lines
class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashHeight;
  final double gapHeight;
  final double strokeWidth;
  final bool isGlowing;
  final Color glowColor;

  DashedLinePainter({
    required this.color,
    required this.dashHeight,
    required this.gapHeight,
    required this.strokeWidth,
    this.isGlowing = false,
    this.glowColor = Colors.transparent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
      
    if (isGlowing) {
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);
    }

    double startY = 0;
    while (startY < size.height) {
      // Draw a dash
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      // Move past the dash and the gap
      startY += dashHeight + gapHeight;
    }
  }

  @override
  bool shouldRepaint(DashedLinePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.dashHeight != dashHeight ||
        oldDelegate.gapHeight != gapHeight ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.isGlowing != isGlowing;
  }
}