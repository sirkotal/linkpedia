import 'package:flutter/material.dart';
import 'package:linkpedia/services/authentication.dart';

class AuthTest extends StatefulWidget {
  const AuthTest({super.key});

  @override
  State<AuthTest> createState() => _AuthTestState();
}

class _AuthTestState extends State<AuthTest> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auth Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) => setState(() => email = val),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                  validator: (val) => val!.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) => setState(() => password = val),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _auth.signIn(email, password, rememberMe);
                      setState(() {});
                    }
                  },
                  child: const Text('Sign In'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _auth.register(email, password);
                      setState(() {});
                    }
                  },
                  child: const Text('Register'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Checkbox(
                      value: rememberMe,
                      onChanged: (val) {
                        setState(() {
                          rememberMe = val!;
                        });
                      },
                    ),
                    const Text('Remember me')
                  ],
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
