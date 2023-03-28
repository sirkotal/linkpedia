import 'package:flutter/material.dart';
import 'package:linkpedia/services/auth_exceptions.dart';
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
  String? emailError;
  String password = '';
  String? passwordError;
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
                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: emailError,
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) => setState(() => email = val),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    errorText: passwordError,
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter a password' : null,
                  onChanged: (val) => setState(() => password = val),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _auth.signIn(email, password, rememberMe);
                        setState(() {});
                      } on UserNotFoundException catch(e) {
                        setState(() {
                          emailError = e.message;
                        });
                      } on WrongPasswordException catch(e) {
                        setState(() {
                          passwordError = e.message;
                        });
                      } on InvalidEmailException catch (e) {
                        setState(() {
                          emailError = e.message;
                        });
                      }
                    }
                  },
                  child: const Text('Sign In'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _auth.register(email, password);
                        setState(() {});
                      } on WeakPasswordException catch(e) {
                        setState(() {
                          passwordError = e.message;
                        });
                      } on EmailAlreadyInUseException catch(e) {
                        setState(() {
                          email = e.message;
                        });
                      } on InvalidEmailException catch (e) {
                        setState(() {
                          emailError = e.message;
                        });
                      }
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
