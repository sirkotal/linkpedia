import 'package:flutter/material.dart';
import 'package:linkpedia/screens/auth/test_login.dart';
import 'package:linkpedia/models/user.dart';
import 'package:linkpedia/screens/home_page/home_page.dart';
import 'package:provider/provider.dart';


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    if (user == null) {
      return const AuthTest();
    } else {
      return const HomePage();
    }
  }
}
