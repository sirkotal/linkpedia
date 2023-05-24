import 'package:flutter/material.dart';
import 'package:linkpedia/screens/auth/login.dart';
import 'package:linkpedia/screens/auth/register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = true;

  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showLogin
        ? LoginPage(toggleView: toggleView)
        : RegisterPage(toggleView: toggleView);
  }
}
