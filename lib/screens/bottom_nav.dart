import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if dark mode is active to adjust colors
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Aesthetic colors inspired by the image and previous suggestions
    final Color barBackgroundColor = isDarkMode ? Color(0xFF1B1B1B) : Color(0xFF0F4C75); // Very dark for dark, deep blue for light
    final Color selectedItemColor = isDarkMode ? Colors.white : Colors.white; // White for selected icon/label
    final Color unselectedItemColor = isDarkMode ? Colors.grey[600]! : Color(0xFFBBE1FA); // Muted grey for unselected dark, light blue for light

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0), // Slightly more rounded corners for the bar
        topRight: Radius.circular(25.0),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed, // Ensures all items have the same width
        backgroundColor: barBackgroundColor,
        selectedItemColor: selectedItemColor,
        unselectedItemColor: unselectedItemColor,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: selectedItemColor, // Ensure label color matches icon color
        ),
        unselectedLabelStyle: TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 11,
          color: unselectedItemColor, // Ensure label color matches icon color
        ),
        showUnselectedLabels: false, // <-- Crucial: Hides labels for unselected items (like the image)
        showSelectedLabels: true,    // <-- Shows label for the selected item (default)
        elevation: 15.0, // Increased shadow for more depth
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 26),
            activeIcon: Icon(Icons.home_filled, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections_bookmark_outlined, size: 26),
            activeIcon: Icon(Icons.collections_bookmark_rounded, size: 28), // Changed to rounded for consistency
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_rounded, size: 26),
            activeIcon: Icon(Icons.person_rounded, size: 28),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}