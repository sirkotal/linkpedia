import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;

  User({required this.uid});

  Future<void> updateEmail(String email) async {
    await FirebaseAuth.instance.currentUser!.updateEmail(email);
  }
}

class UserData {
  final String uid;
  final String username;
  final String name;
  final String email;

  UserData(
      {required this.uid,
      required this.username,
      required this.name,
      required this.email});
}
