import 'package:flutter/material.dart';
import 'package:linkpedia/screens/profile/edit_profile.dart';
import 'package:linkpedia/screens/search_page/search_page.dart';
import 'package:linkpedia/screens/wrapper.dart';
import 'package:linkpedia/services/authentication.dart';
import 'package:linkpedia/utils/no_transition_router.dart';
import 'package:provider/provider.dart';
import 'package:linkpedia/models/user.dart';
import 'package:linkpedia/services/user_db.dart';




class BottomBar extends StatelessWidget {
  final bool homeSelected;
  final bool searchSelected;
  User? user;
  UserData? data;

  final AuthService _auth = AuthService();

  BottomBar(
      {super.key, this.homeSelected = false, this.searchSelected = false});

  void loadData(String userId) async {
    data = await UserDatabaseService().getUserData(userId);
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<User?>(context);
    final userId = user?.uid ?? '';
    loadData(userId);
    return BottomAppBar(
      child: Container(
        decoration: const BoxDecoration(
            border:
                Border(top: BorderSide(color: Colors.deepPurple, width: 2.0))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              // Icon(Icons.home_outlined)
              icon: Icon(homeSelected ? (Icons.home) : (Icons.home_outlined)),
              color: Colors.deepPurple,
              iconSize: 36.0,
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  NoTransitionRouter(builder: (context) => const Wrapper()),
                  (Route<dynamic> route) => false),
            ),
            IconButton(
              icon: Text(
                String.fromCharCode(Icons.search_outlined.codePoint),
                style: TextStyle(
                    fontFamily: 'MaterialIcons',
                    fontWeight:
                        searchSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 36.0,
                    color: Colors.deepPurple),
              ),
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  NoTransitionRouter(builder: (context) => const SearchPage()),
                  (Route<dynamic> route) => false),
            ),
            IconButton(
              icon: Text(
                String.fromCharCode(Icons.account_box_outlined.codePoint),
                style: TextStyle(
                    fontFamily: 'MaterialIcons',
                    fontWeight:
                        searchSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 36.0,
                    color: Colors.deepPurple),
              ),
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  NoTransitionRouter(
                      builder: (context) => const EditProfilePage()),
                  (Route<dynamic> route) => false),
            ),
            IconButton(
              icon: const Icon(
                Icons.logout,
              ),
              color: Colors.deepPurple,
              iconSize: 36.0,
              onPressed: () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    NoTransitionRouter(builder: (context) => const Wrapper()),
                    (Route<dynamic> route) => false);
                 _auth.updateEmailAndSignOut(user! ,data!.email);
              },
            )
          ],
        ),
      ),
    );
  }
}
