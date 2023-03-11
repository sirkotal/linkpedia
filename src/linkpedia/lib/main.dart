import 'package:flutter/material.dart';
import 'package:linkpedia/models/wiki_article.dart';
import 'package:linkpedia/shared/wiki_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WikiArticle article = WikiArticle(
    title: 'Tennis',
    url: 'https://en.wikipedia.org/wiki/Tennis',
    summary: 'Tennis is a racket sport that is played either individually against a single opponent (singles) or between two teams of two players each (doubles). Each player uses a tennis racket that is strung with...'
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            WikiCard(article: article),
            WikiCard(article: article),
            WikiCard(article: article),
            WikiCard(article: article),
          ],
        ),
      ),
    );
  }
}
