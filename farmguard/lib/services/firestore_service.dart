import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save image data to Firestore
  Future<void> saveImageData(String userId, Map<String, dynamic> imageData) async {
    try {
      await _db.collection('users').doc(userId).collection('images').add(imageData);
    } catch (e) {
      print(e);
    }
  }

  // Retrieve image data from Firestore
  Stream<QuerySnapshot> getImageData(String userId) {
    return _db.collection('users').doc(userId).collection('images').snapshots();
  }
}