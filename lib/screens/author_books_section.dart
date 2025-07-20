import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/firestore_service.dart';
import 'book_card.dart';
import 'edit_book_page.dart';

class AuthorBooksSection extends StatelessWidget {
  final FirestoreService firestoreService;
  final String? userId;

  const AuthorBooksSection({
    super.key,
    required this.firestoreService,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return Container(
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
          ),
        ),
        child: Center(
          child: Text(
            "Please log in to view your uploaded books.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return StreamBuilder<List<Book>>(
      stream: firestoreService.getBooksByAuthor(userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final books = snapshot.data!;
        if (books.isEmpty) {
          return const Center(
            child: Text('No books found'),
          );
        }

        return ListView.builder(
          itemCount: books.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            final book = books[index];
            return BookCard(
              key: ValueKey(book.id),
              title: book.title,
              author: book.author,
              description: book.description,
              coverUrl: book.coverUrl,
              bookId: book.id,
              onEdit: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditBookPage(book: book),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
