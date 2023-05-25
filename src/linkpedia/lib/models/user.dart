import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String uid;

  User({required this.uid});

  Future<bool> updateEmail(String email, String password) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        print('here');
        AuthCredential credential = EmailAuthProvider.credential(email: FirebaseAuth.instance.currentUser!.email!, password: password);
        await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
        await FirebaseAuth.instance.currentUser!.updateEmail(email);
        // Email updated successfully
        return true;
      } else {
        print('null');
        // User is not signed in or doesn't exist
        // Handle the error or redirect the user to sign in
        return false;
      }
    } catch (e) {
      print('ups');
      // An error occurred while reauthenticating or updating the email
      print("Error: $e");
      return false;
    }
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
