import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ⭐️ Add new eBook
  Future<void> addEbook({
    required String title,
    required String author,
    required String genre,
    String? coverUrl,
    String? description,
  }) async {
    await _db.collection('ebooks').add({
      'title': title,
      'author': author,
      'genre': genre,
      'coverUrl': coverUrl ?? '',
      'description': description ?? '',
      'favoritesCount': 0,
      'averageRating': 0.0,
      'ratingCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // ⭐️ Get single eBook document
  Stream<DocumentSnapshot> getEbook(String ebookId) {
    return _db.collection('ebooks').doc(ebookId).snapshots();
  }

  // ⭐️ Stream all eBooks, newest first
  Stream<QuerySnapshot> getEbooks() {
    return _db
        .collection('ebooks')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ⭐️ Toggle Favorite
  Future<void> toggleFavorite(String userId, String ebookId) async {
    final userRef = _db.collection('users').doc(userId);
    final ebookRef = _db.collection('ebooks').doc(ebookId);

    final userDoc = await userRef.get();
    List<dynamic> favorites = userDoc.data()?['favorites'] ?? [];

    final isFavorite = favorites.contains(ebookId);

    if (isFavorite) {
      favorites.remove(ebookId);
      await ebookRef.update({
        'favoritesCount': FieldValue.increment(-1),
      });
    } else {
      favorites.add(ebookId);
      await ebookRef.update({
        'favoritesCount': FieldValue.increment(1),
      });
    }

    await userRef.set({
      'favorites': favorites,
    }, SetOptions(merge: true));
  }

  // ⭐️ Toggle Wishlist
  Future<void> toggleWishlist(String userId, String ebookId, bool bool) async {
    final userRef = _db.collection('users').doc(userId);

    final userDoc = await userRef.get();
    List<dynamic> wishlist = userDoc.data()?['wishlist'] ?? [];

    final inWishlist = wishlist.contains(ebookId);

    if (inWishlist) {
      wishlist.remove(ebookId);
    } else {
      wishlist.add(ebookId);
    }

    await userRef.set({
      'wishlist': wishlist,
    }, SetOptions(merge: true));
  }

  // ⭐️ Submit or Update Review
  Future<void> submitReview({
    required String ebookId,
    required String userId,
    required String userName,
    required double rating,
    required String text,
  }) async {
    final ebookRef = _db.collection('ebooks').doc(ebookId);
    final reviewRef = ebookRef.collection('reviews').doc(userId);

    final prev = await reviewRef.get();
    final exists = prev.exists;

    if (exists) {
      await reviewRef.update({
        'rating': rating,
        'text': text,
        'userId': userId,
        'userName': userName,
      });
    } else {
      await reviewRef.set({
        'rating': rating,
        'text': text,
        'userId': userId,
        'userName': userName,
      });
      await ebookRef.update({
        'ratingCount': FieldValue.increment(1),
      });
    }

    // ⭐️ Recalculate average rating
    final reviews = await ebookRef.collection('reviews').get();
    double total = 0;
    for (final r in reviews.docs) {
      total += (r.data()['rating'] ?? 0.0);
    }
    final avg = total / (reviews.size > 0 ? reviews.size : 1);

    await ebookRef.update({
      'averageRating': avg,
    });
  }

  // ⭐️ Get reviews for an eBook
  Stream<QuerySnapshot> getReviews(String ebookId) {
    return _db
        .collection('ebooks')
        .doc(ebookId)
        .collection('reviews')
        .orderBy('userName')
        .snapshots();
  }

  // ⭐️ Get user's Favorites as List of IDs
  Stream<List<String>> getUserFavorites(String userId) {
    return _db.collection('users').doc(userId).snapshots().map((snap) {
      final data = snap.data();
      if (data == null) return <String>[];
      final list = data['favorites'];
      if (list == null) return <String>[];
      return List<String>.from(list);
    });
  }

  // ⭐️ Get user's Wishlist as List of IDs
  Stream<List<String>> getUserWishlist(String userId) {
    return _db.collection('users').doc(userId).snapshots().map((snap) {
      final data = snap.data();
      if (data == null) return <String>[];
      final list = data['wishlist'];
      if (list == null) return <String>[];
      return List<String>.from(list);
    });
  }


  // ... (your existing methods like getUserWishlist, toggleWishlist)

  /// OPTIMIZED: Fetches a stream of eBook documents using a list of IDs.
  /// This uses a 'whereIn' query to get all documents in a single request.
  Stream<QuerySnapshot> getEbooksByIds(List<String> ebookIds) {
    return _db
        .collection('ebooks')
        .where(FieldPath.documentId, whereIn: ebookIds)
        .snapshots();
  }
  
}
