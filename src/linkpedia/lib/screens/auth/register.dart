import 'package:flutter/material.dart';
import 'package:linkpedia/services/authentication.dart';
import 'package:linkpedia/services/auth_exceptions.dart';
import 'package:linkpedia/shared/top_bar.dart';
import 'package:linkpedia/shared/loading.dart';

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
      body: _isLoading ? const Loading() : Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.deepPurple
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: const <Widget>[
                  Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 35, fontFamily: 'Poppins', fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(63), topRight: Radius.circular(63))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 10,),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Username',
                                errorText: usernameError,
                              ),
                              validator: (val) => val!.isEmpty ? 'Enter a username' : null,
                              onChanged: (val) => setState(() => username = val),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Name',
                                errorText: nameError,
                              ),
                              validator: (val) => val!.isEmpty ? 'Enter a name' : null,
                              onChanged: (val) => setState(() => name = val),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Email',
                                errorText: emailError,
                              ),
                              validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) => setState(() => email = val),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                errorText: passwordError,
                              ),
                              validator: (val) => val!.isEmpty ? 'Enter a password' : null,
                              onChanged: (val) => setState(() => password = val),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                errorText: passwordConfirmError,
                              ),
                              validator: (val) =>
                                  val != password ? 'Passwords do not match!' : null,
                              onChanged: (val) => setState(() => passwordConfirm = val),
                            ),
                            const SizedBox(height: 127),
                            SizedBox(
                              height: 50,
                              width: 300,
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
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
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                style: ButtonStyle(
                                  backgroundColor: const MaterialStatePropertyAll<Color>(Colors.deepPurple),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)))
                                ),
                                child: const Text('REGISTER'),
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.black,
                                elevation: 0,
                              ),
                              onPressed: () => widget.toggleView(),
                              child: const Text('Already have an account? Log In')
                            ),
                          ],
                        ),
                      )
                    ),
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}