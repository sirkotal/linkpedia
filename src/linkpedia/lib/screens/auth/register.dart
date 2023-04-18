import 'package:flutter/material.dart';
import 'package:linkpedia/services/authentication.dart';
import 'package:linkpedia/services/auth_exceptions.dart';

class RegisterPage extends StatefulWidget {
  final Function toggleView;

  const RegisterPage({super.key, required this.toggleView});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String username = '';
  String? usernameError;
  String name = '';
  String? nameError;
  String email = '';
  String? emailError;
  String password = '';
  String? passwordError;
  String passwordConfirm = '';
  String? passwordConfirmError;
  bool rememberMe = false;

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        actions: <Widget>[
          ElevatedButton(onPressed: () => widget.toggleView(), child: const Text('Login')),
        ],
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Username',
                            errorText: usernameError,
                          ),
                          validator: (val) => val!.isEmpty ? 'Enter a username' : null,
                          onChanged: (val) => setState(() => username = val),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Name',
                            errorText: nameError,
                          ),
                          validator: (val) => val!.isEmpty ? 'Enter a name' : null,
                          onChanged: (val) => setState(() => name = val),
                        ),
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
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            errorText: passwordConfirmError,
                          ),
                          validator: (val) => val != password ? 'Passwords do not match!' : null,
                          onChanged: (val) => setState(() => passwordConfirm = val),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(const Size(150, 50)),
                          ),
                          onPressed: () async {
                            setState(() => _isLoading = true);
                            if (_formKey.currentState!.validate()) {
                              try {
                                await _auth.register(email, password, username, name);
                                widget.toggleView();
                              } on WeakPasswordException catch (e) {
                                setState(() {
                                  passwordError = e.message;
                                });
                              } on EmailAlreadyInUseException catch (e) {
                                setState(() {
                                  email = e.message;
                                });
                              } on InvalidEmailException catch (e) {
                                setState(() {
                                  emailError = e.message;
                                });
                              } on UserAlreadyExistsException catch (e) {
                                setState(() {
                                  usernameError = e.message;
                                });
                              }
                            }
                            setState(() => _isLoading = false);
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]
      ),
    );
  }
}
