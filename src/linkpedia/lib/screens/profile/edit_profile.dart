import 'dart:async';

import 'package:flutter/material.dart';
import 'package:linkpedia/models/user.dart';
import 'package:linkpedia/shared/top_bar.dart';
import 'package:linkpedia/shared/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:linkpedia/services/user_db.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  User? user = null;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = Provider.of<User?>(context);
    final userId = user?.uid ?? '';
    loadData(userId);
  }

  void loadData(String userId) async {
    UserData data = await UserDatabaseService().getUserData(userId);
    setState(() {
      _usernameController.text = data.username;
      _nameController.text = data.name;
      _emailController.text = data.email;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBar(title: Text('Linkpedia')),
        body: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Current Username: ${_usernameController.text}',
                          style: const TextStyle(
                              fontSize: 20.0, fontFamily: 'Times New Roman'),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(labelText: 'Username'),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Current Username: ${_nameController.text}',
                          style: const TextStyle(
                              fontSize: 20.0, fontFamily: 'Times New Roman'),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Current Email: ${_emailController.text}',
                          style: const TextStyle(
                              fontSize: 20.0, fontFamily: 'Times New Roman'),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.deepPurple, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Enter Password to Confirm Changes',
                          style: const TextStyle(
                              fontSize: 20.0, fontFamily: 'Times New Roman'),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (val) => val!.isEmpty ? 'Enter a password' : null,
                      obscureText: true, 
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {        
                        bool flag = false;
                        print(user);
                        print(_passwordController.text);
                        print(_emailController.text);
                        if (user != null && _passwordController != null && _emailController != null) {
                          flag = await user!.updateEmail(_emailController.text, _passwordController.text);
                          print('here');
                        }
                        print(flag);
                        if (flag){
                          UserData userData = UserData(
                          uid: user!.uid,
                          username: _usernameController.text,
                          name: _nameController.text,
                          email: _emailController.text,
                        );
                        UserDatabaseService databaseService =
                            UserDatabaseService(); // Create an instance
                        await databaseService.updateUserData(
                            user!.uid, userData);
                        setState(() {});
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Profile Updated with Sucess!'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Profile Update Failed'),
                                content: const Text(
                                    'Please make sure the provided password is correct.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(
                                  Colors.deepPurple),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(17)))),
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar(profileSelected: true));
  }
}
