import 'package:flutter/material.dart';

class AchievementsTab extends StatelessWidget {
  const AchievementsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of achievements with their descriptions
    final List<Map<String, dynamic>> achievements = [
      {
        'title': 'First Steps',
        'description': 'Complete your first lesson',
        'icon': Icons.emoji_events_outlined,
        'isUnlocked': true,
      },
      {
        'title': 'Consistent Learner',
        'description': 'Complete 7 days streak',
        'icon': Icons.calendar_today_outlined,
        'isUnlocked': false,
      },
      {
        'title': 'Vocabulary Master',
        'description': 'Learn 100 new words',
        'icon': Icons.menu_book_outlined,
        'isUnlocked': false,
      },
      {
        'title': 'Conversation Pro',
        'description': 'Complete 10 conversation lessons',
        'icon': Icons.chat_bubble_outline,
        'isUnlocked': false,
      },
      {
        'title': 'Grammar Ninja',
        'description': 'Get 5 perfect scores in grammar exercises',
        'icon': Icons.spellcheck,
        'isUnlocked': false,
      },
      {
        'title': 'Pronunciation Expert',
        'description': 'Practice pronunciation for 30 minutes',
        'icon': Icons.record_voice_over_outlined,
        'isUnlocked': false,
      },
      {
        'title': 'Dedication Award',
        'description': 'Study for 30 consecutive days',
        'icon': Icons.military_tech_outlined,
        'isUnlocked': false,
      },
    ];

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 24), // Reduced horizontal padding for wider containers
      itemCount: achievements.length + 1, // +1 for the header
      itemBuilder: (context, index) {
        if (index == 0) {
          // Header section with summary stats
          return _buildAchievementHeader(context, achievements);
        }
        final achievement = achievements[index - 1]; // -1 because of header
        return _buildAchievementCard(
          context,
          title: achievement['title'],
          description: achievement['description'],
          icon: achievement['icon'],
          isUnlocked: achievement['isUnlocked'],
        );
      },
    );
  }

  // New achievement header with stats
  Widget _buildAchievementHeader(BuildContext context, List<Map<String, dynamic>> achievements) {
    int unlockedCount = achievements.where((a) => a['isUnlocked'] == true).length;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Achievements',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem(unlockedCount.toString(), 'Unlocked'),
              _buildStatItem((achievements.length - unlockedCount).toString(), 'Locked'),
              _buildStatItem(
                '${(unlockedCount / achievements.length * 100).toInt()}%', 
                'Completed'
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Progress bar
          LinearProgressIndicator(
            value: unlockedCount / achievements.length,
            backgroundColor: Colors.grey.withOpacity(0.1),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8273F0)),
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8273F0),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required bool isUnlocked,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: isUnlocked 
                ? const Color(0xFF8273F0).withOpacity(0.1)
                : Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isUnlocked ? const Color(0xFF8273F0) : Colors.grey,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isUnlocked ? Colors.black87 : Colors.black54,
          ),
        ),
        subtitle: Text(
          description,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.black.withOpacity(0.6),
          ),
        ),
        trailing: isUnlocked
            ? const Icon(
                Icons.check_circle,
                color: Color(0xFF8273F0),
                size: 24,
              )
            : Icon(
                Icons.lock_outline,
                color: Colors.grey.withOpacity(0.5),
                size: 24,
              ),
      ),
    );
  }
}