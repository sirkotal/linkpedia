import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkpedia/models/user.dart' as linkpedia;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLogged() => _auth.currentUser != null;

  Future<bool> autoSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe') ?? false;
  }

  Future<linkpedia.User?> signIn(String email, String password, bool rememberMe) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      final linkpedia.User user = linkpedia.User(
        uid: userCredential.user!.uid,
      );

      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('rememberMe', rememberMe);

      return user;
    } on FirebaseAuthException catch (e) {
      // TODO: Add error handling
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

      return null;
    }
  }

  Future<linkpedia.User?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      final linkpedia.User user = linkpedia.User(
        uid: userCredential.user!.uid,
      );

      // Be sure not to be logged in
      if (isLogged()) {
        await signOut();
      }

      return user;
    } on FirebaseAuthException catch (e) {
      // TODO: Add error handling
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
