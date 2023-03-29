import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:linkpedia/firebase_options.dart';
import 'package:linkpedia/models/user.dart';
import 'package:linkpedia/screens/auth/test_wrapper.dart';
import 'package:linkpedia/services/authentication.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Linkpedia());
}

class Linkpedia extends StatefulWidget {
  const Linkpedia({super.key});

  @override
  State<Linkpedia> createState() => _LinkpediaState();
}

class _LinkpediaState extends State<Linkpedia> {
  final AuthService _auth = AuthService();

  Future<void> _autoSignIn() async {
    bool autoSignIn = await _auth.autoSignIn();
    if (!autoSignIn) {
      await _auth.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linkpedia',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: FutureBuilder(
        future: _autoSignIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamProvider<User?>.value(
              value: _auth.user,
              initialData: null,
              child: const AuthWrapper()
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
