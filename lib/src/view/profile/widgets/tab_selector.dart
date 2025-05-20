import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final List<String> tabTitles;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const TabSelector({
    Key? key,
    required this.tabTitles,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44, // Perfect height for touch and aesthetics
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          tabTitles.length,
          (index) => Expanded(
            child: _buildTabItem(index),
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem(int index) {
    final bool isSelected = index == selectedIndex;
    
    return GestureDetector(
      onTap: () => onTabSelected(index),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected 
            ? const Color(0xFF8273F0) 
            : Colors.transparent,
          borderRadius: BorderRadius.circular(18),
          boxShadow: isSelected 
            ? [
                BoxShadow(
                  color: const Color(0xFF8273F0).withOpacity(0.25),
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ] 
            : null,
        ),
        child: Center(
          child: Text(
            tabTitles[index],
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected 
                ? Colors.white 
                : const Color(0xFF8273F0),
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}