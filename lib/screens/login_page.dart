import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginSuccess;
  // Added a new callback for navigating to a registration page
  final VoidCallback? onRegisterTap;
  final VoidCallback? onForgotPasswordTap; // Added for forgot password

  const LoginPage({
    super.key,
    required this.onLoginSuccess,
    this.onRegisterTap, // Made optional, but highly recommended
    this.onForgotPasswordTap, // Made optional
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _error;
  bool _isPasswordVisible = false; // State to toggle password visibility

  Future<void> _handleLogin() async {
    setState(() {
      _isLoading = true;
      _error = null; // Clear previous errors
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      // Successfully logged in and saved state, now trigger success callback
      widget.onLoginSuccess();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      // Provide more user-friendly messages for common Firebase errors
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided. Please check your credentials.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is not valid.';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'This account has been disabled. Please contact support.';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Too many login attempts. Please try again later.';
      } else {
        errorMessage = e.message ?? 'An unknown authentication error occurred.';
      }
      setState(() {
        _error = errorMessage;
      });
    } catch (e) {
      // Catch any other unexpected errors
      setState(() {
        _error = 'An unexpected error occurred: ${e.toString()}. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withOpacity(0.1),
              theme.colorScheme.background,
              theme.colorScheme.surfaceContainerHigh,
            ],
            stops: const [0.1, 0.5, 0.9],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 12, // Increased elevation
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)), // More rounded corners
              margin: const EdgeInsets.symmetric(horizontal: 16), // Ensures card doesn't touch edges
              child: Padding(
                padding: const EdgeInsets.all(32), // Increased padding inside the card
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App Icon / Logo
                    Icon(
                      Icons.menu_book_rounded, // A friendly book icon
                      size: 80,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Library App', // App Name
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 24), // Increased spacing
                    Text(
                      'Welcome Back!',
                      style: theme.textTheme.headlineMedium?.copyWith( // Slightly larger header
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 24), // Consistent spacing
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next, // Move to next field on "enter"
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'your.email@example.com',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)), // More rounded
                        filled: true,
                        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3), // Subtle filled color
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible, // Toggles obscurity
                      textInputAction: TextInputAction.done, // "Done" action on keyboard
                      onSubmitted: (_) => _isLoading ? null : _handleLogin(), // Allow submitting with Enter
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)), // More rounded
                        filled: true,
                        fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.3), // Subtle filled color
                        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _isLoading || widget.onForgotPasswordTap == null ? null : widget.onForgotPasswordTap,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                      ),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.errorContainer, // Material 3 error background
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.colorScheme.error.withOpacity(0.5)),
                        ),
                        child: Text(
                          _error!,
                          style: TextStyle(
                            color: theme.colorScheme.onErrorContainer, // Material 3 error text color
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon( // Changed to FilledButton for Material 3 look
                        icon: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Ensure white on primary
                                ),
                              )
                            : const Icon(Icons.login_rounded),
                        label: Text(
                          _isLoading ? 'Logging in...' : 'Login',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16), // Larger tap target
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // More rounded
                          backgroundColor: theme.colorScheme.primary, // Use primary color
                          foregroundColor: theme.colorScheme.onPrimary, // Text color on primary
                        ),
                        onPressed: _isLoading ? null : _handleLogin,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: _isLoading || widget.onRegisterTap == null ? null : widget.onRegisterTap,
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                          color: theme.colorScheme.secondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}