import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:litshelf2/screens/edit_book_page.dart'; // Ensure this import is correct

class ManageBooksPage extends StatelessWidget {
  const ManageBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme; // Get colorScheme for easier access

    final CollectionReference booksRef = FirebaseFirestore.instance.collection('ebooks');

    return Scaffold(
      // Use theme's background color (usually surface or background)
      backgroundColor: colorScheme.background, // A common choice for Scaffold background
      appBar: AppBar(
        title: Text(
          'Manage Books',
          // Consistent title style with other pages
          style: theme.textTheme.headlineSmall?.copyWith( // Using headlineSmall for consistency
            fontWeight: FontWeight.bold,
            // Title color should be onPrimaryContainer if AppBar is primaryContainer
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        // Consistent AppBar background color
        backgroundColor: colorScheme.primaryContainer, // Use theme's primaryContainer
        // Consistent icon theme for back button and other icons
        foregroundColor: colorScheme.onPrimaryContainer, // Ensures icons and text contrast primaryContainer
        centerTitle: true, // Consistent title alignment
        elevation: 0, // Consistent with M3, often no elevation when scrolled to top
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: booksRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: colorScheme.primary, // Loading indicator color from theme
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
                    Icon(Icons.error_outline_rounded, size: 60, color: colorScheme.error),
                    const SizedBox(height: 16),
                    Text(
                      'Error loading books.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Please check your connection and try again.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          final books = snapshot.data?.docs ?? [];

          if (books.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.book_outlined, size: 60, color: colorScheme.onBackground.withOpacity(0.6)), // Muted icon color
                    const SizedBox(height: 16),
                    Text(
                      'No books found.',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onBackground,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Add new books to manage your collection.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              final title = book['title'] ?? 'Untitled';
              final author = book['author'] ?? 'Unknown';
              final description = book['description'] ?? 'No description available'; // Assuming description field exists

              return Card(
                elevation: 2, // Consistent subtle elevation for cards
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Consistent rounded corners
                ),
                color: colorScheme.surfaceContainerLow, // Consistent card background color
                child: InkWell( // Add InkWell for tap feedback on the entire card
                  borderRadius: BorderRadius.circular(12), // Match card border radius
                  onTap: () {
                    // Navigate to EditBookPage when card is tapped
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditBookPage(
                          bookId: book.id,
                          currentTitle: title,
                          currentAuthor: author,
                          currentDescription: description,
                        ),
                      ),
                    );
                  },
                  child: Padding( // Add padding around the ListTile content
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0), // Adjust padding for a slightly larger tile
                    child: ListTile(
                      leading: Icon(
                        Icons.library_books_rounded, // Themed icon for book entry
                        color: colorScheme.primary, // Icon color from theme
                        size: 32,
                      ),
                      title: Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface, // Text color on card surface
                        ),
                      ),
                      subtitle: Text(
                        'Author: $author',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant, // Subtitle color on card surface
                        ),
                      ),
                      trailing: PopupMenuButton<String>(
                        icon: Icon(
                          Icons.more_vert_rounded, // Rounded more icon
                          color: colorScheme.onSurfaceVariant, // Icon color from theme
                        ),
                        onSelected: (value) {
                          if (value == 'delete') {
                            // Show confirmation dialog before deleting
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Confirm Delete',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: Text(
                                    'Are you sure you want to delete "$title"?',
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: colorScheme.primary),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FilledButton( // Consistent button style
                                      style: FilledButton.styleFrom(
                                        backgroundColor: colorScheme.error,
                                        foregroundColor: colorScheme.onError,
                                      ),
                                      child: const Text('Delete'),
                                      onPressed: () {
                                        booksRef.doc(book.id).delete();
                                        Navigator.of(context).pop(); // Close dialog
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Book "$title" deleted.'),
                                            backgroundColor: colorScheme.primary, // Use theme primary color for success
                                            behavior: SnackBarBehavior.floating, // Consistent snackbar behavior
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } else if (value == 'edit') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EditBookPage(
                                  bookId: book.id,
                                  currentTitle: title,
                                  currentAuthor: author,
                                  currentDescription: description,
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
                              style: TextStyle(color: colorScheme.onSurface), // Text color for popup menu item
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text(
                              'Delete',
                              style: TextStyle(color: colorScheme.error), // Error color for delete
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
      // Floating Action Button for adding new books
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to an Add Book page (placeholder for now)
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Add new book functionality not yet implemented.'),
              backgroundColor: colorScheme.secondary,
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        label: Text(
          'Add New Book',
          style: theme.textTheme.titleMedium?.copyWith(color: colorScheme.onPrimary),
        ),
        icon: const Icon(Icons.add_rounded),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners for FAB
        ),
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, // Center the FAB
    );
  }
}