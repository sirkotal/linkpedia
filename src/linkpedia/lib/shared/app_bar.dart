import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  const Bar({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linkpedia',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Linkpedia'),
        ),
        body: const Center(
          child: Text('Among Us'),
        ),
      ),
    );
  }
}
