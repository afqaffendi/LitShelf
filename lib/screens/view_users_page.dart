import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewUsersPage extends StatelessWidget {
  const ViewUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference users = FirebaseFirestore.instance.collection('users');
    final theme = Theme.of(context); // Access the current theme

    return Scaffold(
      // The Scaffold's default background color (theme.scaffoldBackgroundColor or theme.colorScheme.background)
      // will now be the main background, which is typically a subtle white/light grey or black/dark grey.
      appBar: AppBar(
        title: Text(
          'All Registered Users',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary, // Text color consistent with primary AppBar background
          ),
        ),
        centerTitle: true, // Center the title in the AppBar
        backgroundColor: theme.colorScheme.primary, // Solid primary color for AppBar
        elevation: 4, // Re-add a subtle shadow for AppBar to differentiate from body
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary), // Style for back button icon
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(), // No change to the stream
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error, // Error text color
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary, // Loading indicator color on background
              ),
            );
          }

          final userDocs = snapshot.data!.docs;

          if (userDocs.isEmpty) {
            return Center(
              child: Text(
                'No users found.',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onBackground, // Text color for empty state
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0), // Standard padding for the list
            itemCount: userDocs.length,
            itemBuilder: (context, index) {
              final userData = userDocs[index].data() as Map<String, dynamic>;
              // No changes to data extraction or logic here
              return Card( // Wrap ListTile in a Card for elevated effect
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                elevation: 4.0, // Add shadow to the card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0), // Rounded corners for the card
                ),
                color: theme.cardColor, // Use theme's card color
                child: InkWell( // Add InkWell for visual feedback on tap
                  borderRadius: BorderRadius.circular(16.0),
                  onTap: () {
                    // Original onTap behavior is preserved
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.person_rounded, // Use a rounded icon for modern look
                      color: theme.colorScheme.primary, // Icon color from theme
                    ),
                    title: Text(
                      userData['email'] ?? 'No Email',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface, // Text color from theme
                      ),
                    ),
                    subtitle: Text(
                      'Role: ${userData['role']}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7), // Subtitle color from theme
                      ),
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