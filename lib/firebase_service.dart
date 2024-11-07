import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUserData({
    required String email,
    required String password,
    required String gender,
    required String username,
    bool newsCheck = false,
    bool marketPurposeCheck = false,
  }) async {
    try {
      await _firestore.collection('users').add({
        'email': email,
        'password': password,
        'gender': gender,
        'username': username,
        'newsCheck': newsCheck,
        'marketPurposeCheck': marketPurposeCheck,
      });
    } catch (e) {
      print("Failed to add user: $e");
    }
  }
}
