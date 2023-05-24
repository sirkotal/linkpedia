import 'package:flutter/material.dart';
import 'package:linkpedia/shared/top_bar.dart';
import 'package:linkpedia/shared/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(
        title: Text('Linkpedia')
      ),
      body: const Center(
        child: Text(
          'Welcome to Linkpedia!',
          style: TextStyle(
            fontSize: 24.0
          ),
        )
      ),
      bottomNavigationBar: BottomBar(homeSelected: true)
    );
  }
}