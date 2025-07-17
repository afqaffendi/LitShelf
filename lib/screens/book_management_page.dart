import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:litshelf2/screens/edit_book_page.dart';

class ManageBooksPage extends StatelessWidget {
  const ManageBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // ✅ No change to booksRef initialization
    final CollectionReference booksRef = FirebaseFirestore.instance.collection('ebooks');

    return Scaffold(
      // The Scaffold's default background color (theme.scaffoldBackgroundColor or theme.colorScheme.background)
      // will be the main background, which is typically a subtle white/light grey or black/dark grey.
      appBar: AppBar(
        title: Text(
          'Manage Books',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onPrimary, // Text color on primary AppBar background
          ),
        ),
        backgroundColor: theme.colorScheme.primary, // Solid primary color for AppBar
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary), // Back button icon color
        centerTitle: true,
        elevation: 4, // Added subtle shadow to differentiate from body
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: booksRef.snapshots(), // ✅ No change to stream query or collection
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary, // Loading indicator color
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline_rounded, size: 60, color: theme.colorScheme.error),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading books.', // ✅ Original text
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Please check your connection and try again.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onBackground.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          final books = snapshot.data?.docs ?? []; // ✅ No change to data retrieval

          if (books.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book_outlined, size: 60, color: theme.colorScheme.onBackground),
                    const SizedBox(height: 16),
                    Text(
                      'No books found.', // ✅ Original text
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Add new books to manage your collection.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onBackground.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0), // Standard padding
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final title = book['title'] ?? 'Untitled';
              final author = book['author'] ?? 'Unknown';
              // ✅ No change to data access or variables

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: theme.cardColor, // Card background color
                child: InkWell( // Add InkWell for tap feedback on the entire card
                  borderRadius: BorderRadius.circular(16),
                  onTap: () {
                    // Optional: You could navigate to an edit page or show details here,
                    // but keeping it empty to adhere to 'no function change' for now.
                  },
                  child: Padding( // Add padding around the ListTile content
                    padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust padding for a slightly larger tile
                    child: ListTile(
                      leading: Icon(
                        Icons.library_books_rounded, // Themed icon for book entry
                        color: theme.colorScheme.primary, // Icon color from theme
                        size: 32,
                      ),
                      title: Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface, // Text color on card surface
                        ),
                      ),
                      subtitle: Text(
                        'Author: $author',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7), // Subtitle color on card surface
                        ),
                      ),
                      trailing: PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert_rounded, // Rounded more icon
                          color: theme.colorScheme.onSurface, // Icon color from theme
                        ),
                        onSelected: (value) {
                          // ✅ No change to onSelected logic, keeping delete and future edit
                          if (value == 'delete') {
                            booksRef.doc(book.id).delete();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Book "$title" deleted.'),
                                backgroundColor: theme.colorScheme.error, // Use theme error color
                              ),
                            );
                          } else if (value == 'edit') {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => EditBookPage(
        bookId: book.id,
        currentTitle: title,
        currentAuthor: author, currentDescription: '',
      ),
    ),
  );
}

                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Text(
                              'Edit',
                              style: TextStyle(color: theme.colorScheme.onSurface), // Text color for popup menu item
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              'Delete',
                              style: TextStyle(color: theme.colorScheme.error), // Error color for delete
                            ),
                          ),
                        ],
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