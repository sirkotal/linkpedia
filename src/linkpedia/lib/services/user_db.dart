import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkpedia/models/user.dart';

class UserDatabaseService {
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  Future<bool> userExists(String username) async {
    final QuerySnapshot result = await usersRef.where('username', isEqualTo: username).get();
    return result.docs.isNotEmpty;
  }

  Future<void> updateUserData(String uid, UserData userData) async {
    return await usersRef.doc(uid).set({
      'username': userData.username,
      'name': userData.name,
      'email': userData.email,
    });
  }

  Future<UserData> getUserData(String userId) async {
    final DocumentSnapshot doc = await usersRef.doc(userId).get();
    return UserData(
      uid: userId,
      username: doc.get('username'),
      name: doc.get('name'),
      email: doc.get('email'),
    );
  }
}
