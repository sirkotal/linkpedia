import 'package:flutter/material.dart';
import 'package:linkpedia/screens/search_page/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linkpedia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SearchPage(),
    );
  }
}
