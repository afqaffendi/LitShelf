import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Book>> getBooksByAuthor(String? userId) {
    if (userId == null) {
      return Stream.value([]);
    }

    return _firestore
        .collection('books')
        .where('authorId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return Book(
                id: doc.id,
                title: data['title'] as String,
                author: data['author'] as String,
                description: data['description'] as String,
                coverUrl: data['coverUrl'] as String?,
              );
            }).toList());
  }

  Stream<List<String>> getUserWishlist(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  Stream<List<Book>> getEbooksByIds(List<String> bookIds) {
    if (bookIds.isEmpty) {
      return Stream.value([]);
    }

    return _firestore
        .collection('books')
        .where(FieldPath.documentId, whereIn: bookIds)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return Book(
                id: doc.id,
                title: data['title'] as String,
                author: data['author'] as String,
                description: data['description'] as String,
                coverUrl: data['coverUrl'] as String?,
              );
            }).toList());
  }

  Future<void> toggleWishlist(String userId, String bookId, bool add) async {
    final userWishlistRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(bookId);
    
    if (add) {
      await userWishlistRef.set({});
    } else {
      await userWishlistRef.delete();
    }
  }
}
