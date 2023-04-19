import 'package:flutter/material.dart';
import 'package:linkpedia/services/authentication.dart';
import 'package:linkpedia/services/auth_exceptions.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;
  
  const LoginPage({super.key, required this.toggleView});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        title: const Text('Login'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => widget.toggleView(),
            child: const Text('Register')
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  key: const ValueKey('email'),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: emailError,
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) => setState(() => email = val),
                ),
                TextFormField(
                  key: const ValueKey('password'),
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
                  key: const ValueKey('login'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _auth.signIn(email, password, rememberMe);
                        setState(() {}); // dont know if its needed
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