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
                        border: Border.all(color: Colors.deepPurple, width: 2.0),
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
                        border: Border.all(color: Colors.deepPurple, width: 2.0),
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
                        border: Border.all(color: Colors.deepPurple, width: 2.0),
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
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () async {
                        UserData userData = UserData(
                          uid: user!.uid,
                          username: _usernameController.text,
                          name: _nameController.text,
                          email: _emailController.text,
                        );
                        UserDatabaseService databaseService = UserDatabaseService(); // Create an instance
                        await databaseService.updateUserData(user!.uid, userData);
                        setState(() {
            
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll<Color>(
                              Colors.deepPurple),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17)))),
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomBar());
  }
}
