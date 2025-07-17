import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditUserPage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String userDocId;

  const EditUserPage({
    super.key,
    required this.userData,
    required this.userDocId,
  });

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late String _selectedRole;
  bool _isLoading = false;

  final List<String> _roles = ['user', 'librarian'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData['name'] ?? '');
    _emailController = TextEditingController(text: widget.userData['email'] ?? '');
    _selectedRole = widget.userData['role'] ?? 'user';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // --- Function to update user data ---
  Future<void> _updateUserData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userDocId)
          .update({
        'name': _nameController.text.trim(),
        'role': _selectedRole,
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('User "${_nameController.text.trim()}" updated successfully!'),
            backgroundColor: Theme.of(context).colorScheme.primary, // Themed
            behavior: SnackBarBehavior.floating, // Make it floating
          ),
        );
        Navigator.pop(context);
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update user: ${e.message}'),
            backgroundColor: Theme.of(context).colorScheme.error, // Themed
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: $e'),
            backgroundColor: Theme.of(context).colorScheme.error, // Themed
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // --- Function to send password reset email ---
  Future<void> _sendPasswordResetEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('User email is required to send a password reset link.'),
            backgroundColor: Theme.of(context).colorScheme.error, // Themed
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirm Password Reset',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to send a password reset link to $email? This will allow the user to set a new password.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: colorScheme.primary), // Themed
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.primary, // Themed
              foregroundColor: colorScheme.onPrimary, // Themed
            ),
            child: const Text('Send Link'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password reset link sent to $email.'),
              backgroundColor: Theme.of(context).colorScheme.primary, // Themed
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Failed to send password reset link.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email address associated with a Firebase account.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'The provided email address is not valid.';
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$errorMessage: ${e.message}'),
              backgroundColor: Theme.of(context).colorScheme.error, // Themed
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An unexpected error occurred: $e'),
              backgroundColor: Theme.of(context).colorScheme.error, // Themed
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  // --- Function to confirm and delete user ---
  Future<void> _confirmAndDeleteUser() async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Confirm Deletion?',
          style: theme.textTheme.titleLarge?.copyWith(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you absolutely sure you want to delete "${_nameController.text.trim()}" (${_emailController.text.trim()})?\n\nThis action is irreversible and will remove the user\'s data.',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: colorScheme.primary), // Themed
            ),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: colorScheme.error, // Themed
              foregroundColor: colorScheme.onError, // Themed
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _isLoading = true;
      });
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.userDocId)
            .delete();

        // Important Note: Deleting the Firebase Authentication user record
        // cannot be done directly from the client-side for other users.
        // It requires a trusted environment (like a Cloud Function or your own backend)
        // using the Firebase Admin SDK.
        // If you need to delete the Auth user as well, implement a Cloud Function
        // that gets triggered (e.g., via an HTTP request or a Firestore trigger)
        // and uses the Admin SDK to delete the user by their UID.

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User "${_nameController.text.trim()}" deleted successfully.'),
              backgroundColor: Theme.of(context).colorScheme.primary, // Themed
              behavior: SnackBarBehavior.floating,
            ),
          );
          Navigator.pop(context);
        }
      } on FirebaseException catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to delete user: ${e.message}'),
              backgroundColor: Theme.of(context).colorScheme.error, // Themed
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('An unexpected error occurred: $e'),
              backgroundColor: Theme.of(context).colorScheme.error, // Themed
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background, // Themed background
      appBar: AppBar(
        title: Text(
          'Edit User',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onPrimaryContainer, // Themed for AppBar title
          ),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.primaryContainer, // Themed AppBar background
        foregroundColor: colorScheme.onPrimaryContainer, // Themed for back button and other icons
        elevation: 0, // Material 3 apps often have 0 elevation for app bars by default
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: colorScheme.primary, // Themed loading indicator
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // User Avatar/Icon Section
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: colorScheme.secondaryContainer, // Themed
                        foregroundColor: colorScheme.onSecondaryContainer, // Themed
                        child: Text(
                          _nameController.text.isNotEmpty
                              ? _nameController.text[0].toUpperCase()
                              : (_emailController.text.isNotEmpty
                                  ? _emailController.text[0].toUpperCase()
                                  : '?'),
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSecondaryContainer, // Ensure text contrasts with secondaryContainer
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Manage User Information',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface, // Themed
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Divider(height: 48, thickness: 1, color: colorScheme.outlineVariant), // Themed divider

                    // --- Name Field ---
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'User Name',
                        hintText: 'Enter user\'s full name',
                        prefixIcon: Icon(Icons.person_rounded, color: colorScheme.primary), // Themed
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colorScheme.outline), // Themed
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colorScheme.primary, width: 2), // Themed
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest, // Themed
                        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant), // Themed label
                        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant.withOpacity(0.6)), // Themed hint
                      ),
                      style: TextStyle(color: colorScheme.onSurface), // Themed text input
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Name cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // --- Email Field (Read-only) ---
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true, // Email is the Auth identifier, not directly editable here
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email_rounded, color: colorScheme.onSurfaceVariant), // Themed
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colorScheme.outlineVariant), // Themed lighter border for readOnly
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colorScheme.outlineVariant, width: 2), // Themed
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest, // Themed
                        helperText: 'Email cannot be changed directly here.', // Informative helper text
                        helperStyle: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant, // Themed
                        ),
                        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant), // Themed label
                        hintStyle: TextStyle(color: colorScheme.onSurfaceVariant.withOpacity(0.6)), // Themed hint
                      ),
                      style: TextStyle(color: colorScheme.onSurface), // Themed text input
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email cannot be empty';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // --- Role Dropdown ---
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      decoration: InputDecoration(
                        labelText: 'User Role',
                        prefixIcon: Icon(Icons.shield_rounded, color: colorScheme.primary), // Themed
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colorScheme.outline), // Themed
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: colorScheme.primary, width: 2), // Themed
                        ),
                        filled: true,
                        fillColor: colorScheme.surfaceContainerHighest, // Themed
                        labelStyle: TextStyle(color: colorScheme.onSurfaceVariant), // Themed label
                      ),
                      dropdownColor: colorScheme.surfaceContainerHigh, // Themed dropdown background
                      style: theme.textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface), // Themed selected item text
                      items: _roles.map((role) {
                        return DropdownMenuItem(
                          value: role,
                          child: Text(
                            role.toUpperCase(),
                            style: TextStyle(color: colorScheme.onSurface), // Themed dropdown item text
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedRole = newValue;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a role';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),

                    // --- Save Changes Button ---
                    FilledButton.icon(
                      onPressed: _updateUserData,
                      icon: const Icon(Icons.save_rounded),
                      label: const Text('Save Changes'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: colorScheme.primary, // Themed
                        foregroundColor: colorScheme.onPrimary, // Themed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 24), // Increased spacing

                    // --- Password Reset Button ---
                    OutlinedButton.icon(
                      onPressed: _sendPasswordResetEmail,
                      icon: const Icon(Icons.lock_reset_rounded),
                      label: const Text('Send Password Reset Link'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        foregroundColor: colorScheme.primary, // Themed
                        side: BorderSide(color: colorScheme.primary), // Themed border
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: theme.textTheme.titleMedium,
                      ),
                    ),
                    const SizedBox(height: 24), // Increased spacing

                    // --- Delete User Button ---
                    FilledButton.icon(
                      onPressed: _confirmAndDeleteUser,
                      icon: const Icon(Icons.delete_forever_rounded),
                      label: const Text('Delete User'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: colorScheme.error, // Themed
                        foregroundColor: colorScheme.onError, // Themed
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        textStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}