import 'package:flutter/material.dart';

class ListTileItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool showChevron;

  const ListTileItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.showChevron = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 20,
                color: Colors.black54,
              ),
            ),
            const SizedBox(width: 16),
            // Title
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
            // Chevron
            if (showChevron)
              const Icon(
                Icons.chevron_right,
                color: Colors.black26,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}