import 'package:flutter/material.dart';

// Assuming you have these pages defined elsewhere in your project
// import 'ebook_list_page.dart';
// import 'profile_page.dart';
// import 'manage_account_page.dart'; // For librarian role
// import 'view_users_page.dart'; // For librarian role

// We'll put the enhanced bottom navigation bar logic directly into a refactored
// _buildFloatingNavBar method within your DashboardPage, as that's where it's currently used.
// This avoids creating a separate widget if it's tightly coupled to the DashboardPage's state.

// However, if you want a standalone BottomNavBar widget (as per your prompt),
// here's how it would look with the improvements:

class EnhancedBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool isLibrarian; // New: to conditionally show "Accounts" item

  const EnhancedBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.isLibrarian = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    // Define items dynamically based on role
    final List<BottomNavigationBarItem> navItems = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_outlined),
        activeIcon: const Icon(Icons.home_rounded),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.explore_outlined),
        activeIcon: const Icon(Icons.explore_rounded),
        label: 'Discover',
      ),
      if (isLibrarian) // Conditionally add Accounts for librarians
        BottomNavigationBarItem(
          icon: const Icon(Icons.people_alt_outlined),
          activeIcon: const Icon(Icons.people_alt_rounded),
          label: 'Accounts',
        ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person_outline_rounded),
        activeIcon: const Icon(Icons.person_rounded),
        label: 'Profile',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20), // Add horizontal padding for a floating effect
      child: Material(
        color: colorScheme.surfaceContainerHigh, // Use a Material 3 container color
        borderRadius: BorderRadius.circular(28), // More rounded, modern capsule shape
        elevation: 8, // Subtle elevation
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            backgroundColor: Colors.transparent, // Important for Material color to show
            elevation: 0, // No default elevation, handled by Material parent
            type: BottomNavigationBarType.fixed, // Distribute space evenly

            // M3-inspired color scheme for bottom nav bar
            selectedItemColor: colorScheme.primary, // Strong primary accent for selected
            unselectedItemColor: colorScheme.onSurfaceVariant, // Muted for unselected

            // Styles for labels
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: colorScheme.primary, // Ensure label color matches icon
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 11,
              color: colorScheme.onSurfaceVariant, // Ensure label color matches icon
            ),

            // Show selected label only, for a cleaner look
            showSelectedLabels: true,
            showUnselectedLabels: false,

            // Adjust icon sizes for slight emphasis on active
            iconSize: 24, // Base size
            items: navItems.map((item) {
              return BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 2), // Slight lift for icons
                  child: item.icon,
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Transform.scale(
                    scale: 1.1, // Slightly larger active icon
                    child: item.activeIcon,
                  ),
                ),
                label: item.label,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}