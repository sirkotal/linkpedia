import 'package:flutter/material.dart';
import 'package:linkpedia/models/wiki_article.dart';

class WikiCard extends StatelessWidget {
  final WikiArticle article;

  const WikiCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      margin: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        // TODO: navigate to wikipedia page
        onTap: () { print(article.url); },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              Divider(
                height: 0.5,
                thickness: 1.5,
                color: Colors.grey[850]
              ),
              const SizedBox(height: 12.0),
              Text(
                article.summary,
                style: const TextStyle(
                  height: 1.5
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}