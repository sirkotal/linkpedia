import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkpedia/models/user.dart' as linkpedia;
import 'package:linkpedia/services/auth_exceptions.dart';
import 'package:linkpedia/services/user_db.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool isLogged() => _auth.currentUser != null;

  Future<bool> autoSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('rememberMe') ?? false;
  }

  Stream<linkpedia.User?> get user {
    return _auth.authStateChanges()
      .map((User? user) => user != null ? linkpedia.User(uid: user.uid) : null);
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

  Future<linkpedia.User?> register(String email, String password, String username, String name) async {
    try {
      if (await UserDatabaseService().userExists(username)) {
        throw UserAlreadyExistsException('User already exists');
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      final linkpedia.User user = linkpedia.User(
        uid: userCredential.user!.uid
      );

      await UserDatabaseService().updateUserData(
        user.uid,
        linkpedia.UserData(
          uid: user.uid,
          username: username,
          name: name,
          email: email
        )
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

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', false);
  }
}
