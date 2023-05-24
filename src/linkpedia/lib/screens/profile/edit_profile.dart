import 'package:flutter/material.dart';
import 'package:linkpedia/models/user.dart';
import 'package:linkpedia/shared/top_bar.dart';
import 'package:linkpedia/shared/bottom_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfilePage extends StatefulWidget {
  final UserData userData;

  // ignore: prefer_const_constructors_in_immutables
  EditProfilePage({super.key, required this.userData});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.userData.username;
    _nameController.text = widget.userData.name;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  // will this work??
  void _updateProfile() {
    String newUsername = _usernameController.text;
    String newName = _nameController.text;

    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userData.uid)
        .update({
      'username': newUsername,
      'name': newName,
    }).then((_) {
      // Update successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }).catchError((error) {
      // Handle error
      // ignore: avoid_print
      print('Failed to update profile: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update profile')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TopBar(title: Text('Linkpedia')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Current Username: ${widget.userData.username}',
                style: TextStyle(fontSize: 24.0),
              ),
              Text(
                'Current Name: ${widget.userData.name}',
                style: TextStyle(fontSize: 24.0),
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _updateProfile,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar());
  }
}
