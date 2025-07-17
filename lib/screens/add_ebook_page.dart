import 'package:flutter/material.dart';
import 'firestore_service.dart';

class AddEbookPage extends StatefulWidget {
  const AddEbookPage({super.key});

  @override
  State<AddEbookPage> createState() => _AddEbookPageState();
}

class _AddEbookPageState extends State<AddEbookPage> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();

  String _title = '';
  String _author = '';
  String _genre = '';
  String _description = '';
  String _coverUrl = '';

  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isLoading = true);

    try {
      await _firestoreService.addEbook(
        title: _title,
        author: _author,
        genre: _genre,
        description: _description,
        coverUrl: _coverUrl.isEmpty ? null : _coverUrl,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ebook added successfully')),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _title = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Author'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _author = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Genre'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _genre = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onSaved: (value) => _description = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cover Image URL (optional)'),
                onSaved: (value) => _coverUrl = value ?? '',
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                      onPressed: _submit,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
