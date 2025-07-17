import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addDefaultFieldsToAllEbooks() async {
  final firestore = FirebaseFirestore.instance;
  final collection = firestore.collection('ebooks');

  final snapshot = await collection.get();

  final batch = firestore.batch();

  for (final doc in snapshot.docs) {
    batch.update(doc.reference, {
      'favoritesCount': 0,
      'averageRating': 0.0,
      'ratingCount': 0,
    });
  }

  await batch.commit();
  print('All ebooks updated with default favorites and rating fields!');
}
