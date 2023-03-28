import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      child: IconTheme(
        data: const IconThemeData(
          color: Colors.deepPurple,
          size: 36.0
        ),
      child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.deepPurple,
                width: 2.0
              )
            )
          ),  
        )
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

import 'package:flutter/material.dart';
import 'package:linkpedia/screens/home_page/home_page.dart';
import 'package:linkpedia/screens/search_page/search_page.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: IconTheme(
        data: const IconThemeData(
          color: Colors.deepPurple,
          size: 36.0
        ),
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
                icon: const Icon(Icons.home_outlined),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage())
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage())
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
