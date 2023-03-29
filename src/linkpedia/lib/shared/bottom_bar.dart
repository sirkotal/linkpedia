import 'package:flutter/material.dart';
import 'package:linkpedia/screens/home_page/home_page.dart';
import 'package:linkpedia/screens/search_page/search_page.dart';
import 'package:linkpedia/utils/no_transition_router.dart';

class BottomBar extends StatelessWidget {
  final bool homeSelected;
  final bool searchSelected;
  
  const BottomBar({super.key, this.homeSelected = false, this.searchSelected = false});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.deepPurple,
              width: 2.0
            )
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              // Icon(Icons.home_outlined)
              icon: Icon(
                homeSelected ?
                  (Icons.home) : (Icons.home_outlined)),
              color: Colors.deepPurple,  
              iconSize: 36.0, 
              isSelected: true,
              onPressed: () => Navigator.pushReplacement(
                context,
                NoTransitionRouter(builder: (context) => const HomePage())
              ),
            ),
            IconButton(
              icon: Text(
                String.fromCharCode(Icons.search_outlined.codePoint),
                style: TextStyle(
                  fontFamily: 'MaterialIcons',
                  fontWeight: searchSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 36.0,
                  color: Colors.deepPurple
                  
                ),
              ),
              onPressed: () => Navigator.pushReplacement(
                context,
                NoTransitionRouter(builder: (context) => const SearchPage())
              ),
            ),
          ],
        ),
      ),
    );
  }
}