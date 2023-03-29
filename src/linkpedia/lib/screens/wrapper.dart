import 'package:flutter/material.dart';
import 'package:linkpedia/screens/auth/auth.dart';
import 'package:linkpedia/models/user.dart';
import 'package:linkpedia/screens/home_page/home_page.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);

    if (user == null) {
      return const AuthPage();
    } else {
      return const HomePage();
    }
  }
}
