import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkpedia/models/user.dart';

class DatabaseService {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  final String uid;
  DatabaseService({ required this.uid });

  static Future<bool> userExists(String username) async {
    final QuerySnapshot result = await db.collection('users').where('username', isEqualTo: username).get();
    return result.docs.isNotEmpty;
  }

  Future<void> updateUserData(UserData userData) async {
    return await db.collection('users').doc(uid).set({
      'username': userData.username,
      'name': userData.name,
      'email': userData.email,
    });
  }

  Stream<UserData> get userData {
    return db.collection('users').doc(uid).snapshots().map((doc) {
      return UserData(
        uid: uid,
        username: doc.get('username'),
        name: doc.get('name'),
        email: doc.get('email'),
      );
    });
  }
}
