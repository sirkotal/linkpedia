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
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.deepPurpleAccent
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children:  <Widget>[
                  Image.asset('assets/Logo.png'),
                  const Text("LINKPEDIA", style: TextStyle(color: Colors.white, fontSize: 43, fontFamily: 'KronaOne'),),
                  const SizedBox(height: 10,),
                  const Text("Welcome Back!", style: TextStyle(color: Colors.black, fontSize: 23, fontFamily: 'Poppins'),),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(63), topRight: Radius.circular(63))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      SingleChildScrollView(
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
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                Container(
                                  height: 50,
                                  width: 300,
                                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
                                  child: ElevatedButton(
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
                                    style: ButtonStyle(
                                      backgroundColor: const MaterialStatePropertyAll<Color>(Colors.deepPurpleAccent),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)))
                                    ),
                                    child: const Text('LOGIN'),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                  ),
                                  onPressed: () => widget.toggleView(),
                                  child: const Text('Don`t have an account yet? Register')
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                    ],
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