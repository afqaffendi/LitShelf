import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:litshelf2/screens/book_management_page.dart';
import 'package:litshelf2/screens/view_users_page.dart';
import 'package:litshelf2/screens/login_page.dart';

class ManageAccountPage extends StatelessWidget {
  const ManageAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Access color scheme directly

    return Scaffold(
      // Use theme's background color (usually surface or background)
      backgroundColor: colorScheme.background, // A common choice for Scaffold background

      appBar: AppBar(
        title: Text(
          'Admin Dashboard', // More descriptive title for the admin page
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimaryContainer, // Consistent with primaryContainer AppBar background
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primaryContainer, // Use theme's primaryContainer
        foregroundColor: colorScheme.onPrimaryContainer, // Ensures back button and other icons match onPrimaryContainer
        elevation: 0, // AppBar typically has no elevation in M3 when scrolled to top
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Admin Icon and Title Section
              Icon(
                Icons.admin_panel_settings_rounded,
                size: 90, // Slightly larger for more presence
                color: colorScheme.primary, // Use primary color for main icon
              ),
              const SizedBox(height: 24),
              Text(
                'Welcome, Administrator!', // More welcoming title
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onBackground, // Use onBackground for main text
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Manage your application\'s users and book collection.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onBackground.withOpacity(0.7), // Subtler text color
                ),
              ),
              const SizedBox(height: 48), // Increased spacing for better visual separation

              // --- Action Cards ---
              _buildActionCard(
                context: context,
                icon: Icons.people_alt_rounded,
                iconColor: colorScheme.primary, // Consistent icon color from primary
                title: 'Manage Users',
                subtitle: 'View, edit, and oversee all user accounts.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ViewUsersPage()),
                  );
                },
              ),
              const SizedBox(height: 20), // Spacing between cards

              _buildActionCard(
                context: context,
                icon: Icons.library_books_rounded,
                iconColor: colorScheme.secondary, // Use secondary for a different but harmonious look
                title: 'Manage Books',
                subtitle: 'Add, update, or remove books from the library.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ManageBooksPage()),
                  );
                },
              ),
              const SizedBox(height: 48), // Spacing before the logout button

              // Logout Button
              OutlinedButton.icon( // Changed to OutlinedButton for a softer, modern look
                icon: const Icon(Icons.logout_rounded), // Slightly more modern icon
                label: const Text('Logout'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16), // Slightly larger tap target
                  foregroundColor: colorScheme.error, // Error color for logout
                  side: BorderSide(color: colorScheme.error), // Border in error color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // More rounded corners
                  ),
                  textStyle: theme.textTheme.titleMedium, // Apply text style
                ),
                onPressed: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        'Confirm Logout',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: Text(
                        'Are you sure you want to log out?',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          style: TextButton.styleFrom(foregroundColor: colorScheme.primary),
                          child: const Text('Cancel'),
                        ),
                        FilledButton( // Use FilledButton for the primary action in the dialog
                          onPressed: () => Navigator.pop(context, true),
                          style: FilledButton.styleFrom(
                            backgroundColor: colorScheme.error, // Consistent logout color
                            foregroundColor: colorScheme.onError,
                          ),
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  );

                  if (shouldLogout == true) {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) { // Ensure context is still valid after async operation
                      // Use pushAndRemoveUntil to clear the navigation stack
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => LoginPage(onLoginSuccess: () {})),
                        (route) => false,
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build consistent action cards
  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 4, // A standard elevation for cards (M3 recommends 1-4)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24), // Even more rounded corners
      ),
      color: colorScheme.surfaceContainerHigh, // Use surfaceContainerHigh for cards
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0), // More vertical padding and slightly adjusted horizontal
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 56, // Larger icons for emphasis
                color: iconColor,
              ),
              const SizedBox(height: 16), // Increased spacing
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge?.copyWith( // Larger title for cards
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface, // Text color from theme
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith( // Consistent body medium for subtitles
                  color: colorScheme.onSurfaceVariant, // Subtitle color from theme
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}