import 'package:flutter/material.dart';
import 'package:sara_ai/src/utils/widgets/list_tile_item.dart';
import 'package:sara_ai/src/utils/widgets/section_container.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 24), // Reduced horizontal padding for wider containers
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Account section
          _buildSectionTitle('Account'),
          SectionContainer(
            child: Column(
              children: [
                ListTileItem(
                  title: 'Notifications',
                  icon: Icons.notifications_outlined,
                  onTap: () {
                    // Navigate to notifications settings
                  },
                ),
                const Divider(height: 1),
                ListTileItem(
                  title: 'Learning goals',
                  icon: Icons.flag_outlined,
                  onTap: () {
                    // Navigate to learning goals
                  },
                ),
                const Divider(height: 1),
                ListTileItem(
                  title: 'Refresh content',
                  icon: Icons.refresh,
                  onTap: () {
                    // Refresh content
                  },
                ),
                const Divider(height: 1),
                ListTileItem(
                  title: 'Logout',
                  icon: Icons.logout,
                  onTap: () {
                    // Handle logout
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Help & Support section
          _buildSectionTitle('Help & Support'),
          SectionContainer(
            child: Column(
              children: [
                ListTileItem(
                  title: 'FAQ',
                  icon: Icons.help_outline,
                  onTap: () {
                    // Navigate to FAQ
                  },
                ),
                const Divider(height: 1),
                ListTileItem(
                  title: 'Terms',
                  icon: Icons.description_outlined,
                  onTap: () {
                    // Navigate to terms
                  },
                ),
                const Divider(height: 1),
                ListTileItem(
                  title: 'Privacy Policy',
                  icon: Icons.shield_outlined,
                  onTap: () {
                    // Navigate to privacy policy
                  },
                ),
                const Divider(height: 1),
                ListTileItem(
                  title: 'Reach out to us',
                  icon: Icons.mail_outline,
                  onTap: () {
                    // Contact support
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // App information
          Center(
            child: Text(
              'App version 1.0.0',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
  
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Logout',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8273F0),
            ),
            onPressed: () {
              // Handle logout logic
              Navigator.of(context).pop();
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}