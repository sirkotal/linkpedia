import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkpedia/models/user.dart' as linkpedia;
import 'package:linkpedia/services/auth_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLogged() => _auth.currentUser != null;

  Future<bool> autoSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe') ?? false;
  }

  Stream<linkpedia.User?> get user {
    return _auth.userChanges().map((User? user) {
      return user != null ? linkpedia.User(uid: user.uid) : null;
    });
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
      if (e.code == 'invalid-email') {
        throw InvalidEmailException('Invalid email');
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException('Wrong password');
      } else if (e.code == 'user-not-found') {
        throw UserNotFoundException('User not found');
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
      if (e.code == 'invalid-email') {
        throw InvalidEmailException('Invalid email');
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException('Email already registered');
      } else if (e.code == 'weak-password') {
        throw WeakPasswordException('Password is too weak');
      }

      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
