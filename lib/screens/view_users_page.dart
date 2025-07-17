import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:litshelf2/screens/edit_user_page.dart';
import 'package:shimmer/shimmer.dart';


class ViewUsersPage extends StatelessWidget {
  const ViewUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference users = FirebaseFirestore.instance.collection('users');
    final ThemeData theme = Theme.of(context); // Access the current theme
    final ColorScheme colorScheme = theme.colorScheme; // Access color scheme directly

    // Determine if the current theme is dark based on background color
    // This is a simple heuristic; a better way is to check theme.brightness

    return Scaffold(
      // Scaffold background should ideally be surface, background, or onSurface depending on context
      // Using surface for a typical content background
      backgroundColor: colorScheme.surface, // Use theme's surface color for background
      appBar: AppBar(
        title: Text(
          'All Registered Users',
          style: theme.textTheme.headlineSmall?.copyWith( // Use headlineSmall for AppBar title for M3 feel
            fontWeight: FontWeight.bold,
            // Title color should be onPrimaryContainer if AppBar is primaryContainer
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        centerTitle: true, // Center the title in the AppBar
        backgroundColor: colorScheme.primaryContainer, // Reverted to theme's primaryContainer
        elevation: 0, // AppBar typically has no elevation in M3 when scrolled to top
        // Ensures back button and other icons match onPrimaryContainer
        foregroundColor: colorScheme.onPrimaryContainer, // Reverted to theme's onPrimaryContainer
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(), // No change to the stream
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load users. Please try again later.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.error, // Error text color
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Error: ${snapshot.error}', // More detailed error for debugging
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.6), // Use onSurface for text
                    ),
                  ),
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return _UsersShimmerLoader(theme: theme); // Use a shimmer loader for better UX
          }

          final userDocs = snapshot.data!.docs;

          if (userDocs.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.group_off_rounded, // Icon indicating no users
                    size: 48,
                    color: colorScheme.onSurfaceVariant, // Use onSurfaceVariant for muted icon
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No users found.',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface, // Text color for empty state
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'There are no registered users to display yet.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface.withOpacity(0.7), // Adjust for theme
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0), // Standard padding for the list
            itemCount: userDocs.length,
            itemBuilder: (context, index) {
              final userData = userDocs[index].data() as Map<String, dynamic>;
              final String userDocId = userDocs[index].id; // Get the document ID

              // Default values for robustness
              final String email = userData['email'] ?? 'No Email';
              final String role = userData['role'] ?? 'Unknown Role';
              final String userName = userData['name'] ?? email.split('@')[0]; // Use name if available, else part of email

              return Card( // Wrap ListTile in a Card for elevated effect
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4.0, // Increased elevation for a more prominent card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0), // Slightly more rounded corners
                ),
                color: colorScheme.surfaceContainerHigh, // Use surfaceContainerHigh for card background
                child: InkWell( // Add InkWell for visual feedback on tap
                  borderRadius: BorderRadius.circular(16.0),
                  onTap: () {
                    // Navigate to EditUserPage when a user card is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditUserPage(
                          userData: userData,
                          userDocId: userDocId,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0), // Increased padding
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: colorScheme.primary, // Use primary color for avatar background
                          foregroundColor: colorScheme.onPrimary, // Text color on primary
                          radius: 28, // Slightly larger avatar
                          child: Text(
                            userName[0].toUpperCase(), // First letter of name/email
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18), // Increased spacing
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSurface, // Text color from theme
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                email,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurfaceVariant, // Subtitle color from theme
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // Display role with a chip for better visual distinction
                        const SizedBox(width: 10),
                        Chip(
                          label: Text(
                            role.toUpperCase(), // Display role in uppercase
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              // Use onSecondaryContainer/onTertiaryContainer for text on respective chips
                              color: role.toLowerCase() == 'librarian' ? colorScheme.onSecondaryContainer : colorScheme.onTertiaryContainer,
                            ),
                          ),
                          // Use secondaryContainer/tertiaryContainer for chip background
                          backgroundColor: role.toLowerCase() == 'librarian' ? colorScheme.secondaryContainer : colorScheme.tertiaryContainer,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), // Adjusted padding
                          side: BorderSide.none, // No border for solid chip
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Rounded corners for chips
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Helper widget for shimmer loading effect
class _UsersShimmerLoader extends StatelessWidget {
  final ThemeData theme;
  const _UsersShimmerLoader({required this.theme});

  @override
  Widget build(BuildContext context) {
    // Shimmer colors should adapt to the theme's surface colors
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceContainer.withOpacity(0.5), // Base color for shimmer
      highlightColor: theme.colorScheme.surfaceContainerHighest, // Highlight color for shimmer
      period: const Duration(milliseconds: 1200),
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5, // Show 5 shimmer items
        itemBuilder: (_, __) => Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          color: theme.colorScheme.surfaceContainerHigh, // Use card color for shimmer background
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.surfaceContainerHighest, // Shimmer effect on avatar
                  radius: 28,
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 18, // Slightly larger height for shimmer text
                        color: theme.colorScheme.surfaceContainerHighest, // Shimmer effect on text lines
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 180, // Longer shimmer line for email
                        height: 16,
                        color: theme.colorScheme.surfaceContainerHighest,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 80, // Shimmer effect for the role chip
                  height: 28, // Slightly larger height for shimmer chip
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}