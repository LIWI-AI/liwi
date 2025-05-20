import 'package:flutter/material.dart';
import 'package:sara_ai/src/view/profile/widgets/stats_card.dart';

class ProgressTab extends StatelessWidget {
  const ProgressTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: StatsCard(
                  icon: Icons.flash_on,
                  iconColor: Colors.orange,
                  backgroundColor: Colors.orange.withOpacity(0.1),
                  value: '0',
                  label: 'Streak',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatsCard(
                  icon: Icons.diamond_outlined,
                  iconColor: Colors.purple,
                  backgroundColor: Colors.purple.withOpacity(0.1),
                  value: '0',
                  label: 'Gems',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: StatsCard(
                  icon: Icons.star_outline,
                  iconColor: Colors.amber,
                  backgroundColor: Colors.amber.withOpacity(0.1),
                  value: '0',
                  label: 'Stars',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Learning progress section
          const Text(
            'My learning progress',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 12),

          // Level card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your level',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    const Text(
                      'Beginner',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8273F0),
                      ),
                    ),
                  ],
                ),
                // Circle with level number
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF8273F0),
                      width: 2,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      '12',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8273F0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Words used card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  '30',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  'words used',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Daily lessons section
          const Text(
            'Daily lessons',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Daily lesson cards
          Row(
            children: [
              Expanded(
                child: _buildLessonCard(
                  context,
                  count: '5',
                  title: '5 Daily lessons',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildLessonCard(
                  context,
                  count: '15',
                  title: '15 Daily lessons',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildLessonCard(
                  context,
                  count: '30',
                  title: '30 Daily lessons',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Streaks section
          const Text(
            'Streaks',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // FIXED: Streak cards using Expanded to prevent overflow
          Row(
            children: [
              Expanded(
                child: _buildStreakCard(
                  days: '7',
                  title: '7-day streak',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStreakCard(
                  days: '14',
                  title: '14-day streak',
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildStreakCard(
                  days: '28',
                  title: '28-day streak',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(
    BuildContext context, {
    required String count,
    required String title,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Count with laurel
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.account_balance,
                size: 40,
                color: Colors.grey.withOpacity(0.3),
              ),
              Text(
                count,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FIXED: Simplified streak card that doesn't need width parameter
  Widget _buildStreakCard({
    required String days,
    required String title,
  }) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Trophy with days
          Icon(
            Icons.emoji_events_outlined,
            size: 40,
            color: Colors.grey.withOpacity(0.3),
          ),
          const SizedBox(height: 8),
          // Days number
          Text(
            days,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}