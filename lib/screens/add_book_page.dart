import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController(); 

  bool _isLoading = false;
  String? _message;

  Future<void> _addBook() async {
    if (_titleController.text.trim().isEmpty ||
        _authorController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty) {
      setState(() {
        _message = "❌ Please fill in all fields (title, author, description).";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _message = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        setState(() {
          _message = "❌ You must be logged in to add books.";
        });
        return;
      }

      await FirebaseFirestore.instance.collection('ebooks').add({
        'title': _titleController.text.trim(),
        'author': _authorController.text.trim(),
        'description': _descriptionController.text.trim(),
        'timestamp': Timestamp.now(),
        'uploadedBy': user.uid,
      });

      setState(() {
        _message = "✅ Book added successfully!";
        _titleController.clear();
        _authorController.clear();
        _descriptionController.clear(); // NEW
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Book added successfully!"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() {
        _message = "❌ Failed to add book: $e";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to add book."),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _descriptionController.dispose(); // NEW
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add New Book",
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primary,
        elevation: 4,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.auto_stories_rounded,
                size: 80,
                color: theme.colorScheme.onBackground,
              ),
              const SizedBox(height: 16),
              Text(
                'Enter Book Details',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onBackground,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: "Book Title",
                          hintText: "e.g., The Great Gatsby",
                          prefixIcon: Icon(
                            Icons.menu_book_rounded,
                            color: theme.colorScheme.primary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _authorController,
                        decoration: InputDecoration(
                          labelText: "Author",
                          hintText: "e.g., F. Scott Fitzgerald",
                          prefixIcon: Icon(
                            Icons.person_rounded,
                            color: theme.colorScheme.secondary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Description",
                          hintText: "Brief summary or synopsis",
                          prefixIcon: Icon(
                            Icons.description_rounded,
                            color: theme.colorScheme.tertiary,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.5),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                        style: TextStyle(color: theme.colorScheme.onSurface),
                      ),
                      const SizedBox(height: 24),
                      if (_message != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            _message!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: _message!.contains("✅")
                                  ? theme.colorScheme.secondary
                                  : theme.colorScheme.error,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _addBook,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                          elevation: 4,
                        ),
                        child: _isLoading
                            ? SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: theme.colorScheme.onPrimary,
                                  strokeWidth: 3,
                                ),
                              )
                            : Text(
                                "Add Book",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: theme.colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
