import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register user and save role in Firestore
  Future<String?> registerUser(String email, String password, String role) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'email': email,
          'role': role,           // 'user', 'admin', or 'clerk'
          'favorites': [],
          'wishlist': [],
        });
      }

      return null; // Success
    } catch (e) {
      return e.toString(); // Return error message
    }
  }
}
