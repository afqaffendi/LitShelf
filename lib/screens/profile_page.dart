import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart'; // Make sure to import your login page

// 1. Change to StatefulWidget
class ProfilePage extends StatefulWidget {
  final bool isDarkMode;
  final void Function(bool) onToggleDarkMode;

  const ProfilePage({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // 2. Add a TextEditingController for the name input
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current user's display name
    // If displayName is null, default to an empty string.
    _nameController = TextEditingController(text: _auth.currentUser?.displayName ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose(); // Dispose the controller to prevent memory leaks
    super.dispose();
  }

  // Method to handle user logout (remains unchanged)
  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Assuming you use this key

    // Navigate to LoginPage and remove all previous routes
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => LoginPage(onLoginSuccess: () {}),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  // 3. New method to change the user's display name
  Future<void> _changeDisplayName(BuildContext context) async {
    final user = _auth.currentUser;
    if (user == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: User not logged in.')),
        );
      }
      return;
    }

    final newName = _nameController.text.trim(); // Get the new name from the text field
    if (newName.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name cannot be empty.')),
        );
      }
      return;
    }

    // Check if the new name is actually different from the current one
    if (newName == user.displayName) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name is already the same.')),
        );
      }
      return;
    }

    try {
      await user.updateDisplayName(newName);
      // Reload the user to get the updated display name immediately
      await user.reload();
      // Force a UI rebuild to reflect the new name
      setState(() {});

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name updated successfully!')),
        );
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Error updating display name: ${e.code} - ${e.message}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update name: ${e.message}')),
        );
      }
    } catch (e) {
      debugPrint('An unexpected error occurred: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An unexpected error occurred.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = _auth.currentUser; // Get current user here to ensure it's up-to-date

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          // User Info Section
          if (user != null)
            Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  child: Icon(Icons.person, size: 50),
                ),
                const SizedBox(height: 16),
                // Display current name, which will update after _changeDisplayName
                Text(
                  user.displayName ?? 'Anonymous User',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  user.email ?? 'No email available',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                ),
              ],
            ),
          const SizedBox(height: 32),

          // 4. Name Change Input Field and Button
          Card(
            margin: EdgeInsets.zero, // Remove default card margin
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Change Display Name',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'New Display Name',
                      hintText: 'Enter your desired name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      prefixIcon: const Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: () => _changeDisplayName(context),
                      icon: const Icon(Icons.save_rounded),
                      label: const Text('Save Name'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24), // Space between name change card and other settings

          // Settings Section
          // Removed: Original "Edit Profile" ListTile as it's replaced by the name change section
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: widget.isDarkMode, // Use widget.isDarkMode since it's in the State class
            onChanged: widget.onToggleDarkMode, // Use widget.onToggleDarkMode
            secondary: Icon(
              widget.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
            ),
          ),
          // 5. Removed: The "About" ListTile
          // ListTile(
          //   leading: const Icon(Icons.info_outline),
          //   title: const Text('About'),
          //   trailing: const Icon(Icons.arrow_forward_ios),
          //   onTap: () {
          //     // TODO: Navigate to an about screen
          //   },
          // ),

          const SizedBox(height: 32),

          // Logout Button (remains unchanged)
          ElevatedButton.icon(
            icon: const Icon(Icons.logout_rounded),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Theme.of(context).colorScheme.onError,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => _logout(context),
          ),
        ],
      ),
    );
  }
}