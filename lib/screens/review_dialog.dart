import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firestore_service.dart'; // Ensure this path is correct

class ReviewDialog extends StatefulWidget {
  final String ebookId;
  final String title;

  const ReviewDialog({
    Key? key,
    required this.ebookId,
    required this.title,
  }) : super(key: key);

  @override
  _ReviewDialogState createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 3.0;
  bool _isSubmitting = false;

  final FirestoreService _firestoreService = FirestoreService();
  final User? _currentUser = FirebaseAuth.instance.currentUser; // Get current user once

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // --- AlertDialog Styling ---
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh, // A slightly elevated background
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint, // Material 3 tinting
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // Rounded corners
      titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 0), // Adjust title padding
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0), // Adjust content padding
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 16), // Adjust actions padding

      title: Text(
        'Review: ${widget.title}',
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
        textAlign: TextAlign.center, // Center the title
      ),
      content: _isSubmitting
          ? SizedBox(
              height: 150, // Give more space for the loading indicator
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Submitting review...',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
                  children: [
                    // ⭐ Rating selector
                    Text(
                      'Your Rating:',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 8),
                    // Star rating system
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return IconButton(
                          padding: EdgeInsets.zero, // Remove default padding
                          constraints: const BoxConstraints(), // Remove extra constraints
                          icon: Icon(
                            index < _rating.round() // Simple round for full stars
                                ? Icons.star_rounded // Filled star
                                : Icons.star_border_rounded, // Empty star
                            color: Colors.amber[700], // Consistent gold color for stars
                            size: 38, // Slightly larger stars
                          ),
                          onPressed: () {
                            setState(() {
                              _rating = (index + 1).toDouble();
                            });
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    Center( // Center the rating text
                      child: Text(
                        '${_rating.toStringAsFixed(1)} / 5',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ⭐ Review text
                    TextFormField(
                      controller: _reviewController,
                      maxLines: 4,
                      minLines: 2, // Allow for at least two lines of text
                      keyboardType: TextInputType.multiline, // Enable multiline input
                      textCapitalization: TextCapitalization.sentences, // Capitalize sentences
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.5)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
                        ),
                        hintText: 'Share your thoughts about this book...',
                        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
                            ),
                        contentPadding: const EdgeInsets.all(16), // Padding inside the input
                        fillColor: Theme.of(context).colorScheme.surface, // Background for the input field
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your review';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
      actions: [
        TextButton(
          onPressed: _isSubmitting ? null : () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSurfaceVariant, // Text color
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSubmitting ? null : _submitReview,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary, // Primary button color
            foregroundColor: Theme.of(context).colorScheme.onPrimary, // Text color on primary
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Rounded corners
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Button padding
            elevation: 2, // Slight shadow
          ),
          child: Text('Submit Review'),
        ),
      ],
    );
  }

  // --- No changes below this line, as per your request ---

  Future<void> _submitReview() async {
    // Ensure user is logged in if not already checked elsewhere
    if (_currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to submit a review.')),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // The original user variable was local. Using _currentUser here.
      await _firestoreService.submitReview(
        ebookId: widget.ebookId,
        userId: _currentUser.uid,
        userName: _currentUser.email ?? 'Anonymous', // Fallback for userName
        rating: _rating,
        text: _reviewController.text.trim(),
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('✅ Review submitted successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('❌ Failed to submit review: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}