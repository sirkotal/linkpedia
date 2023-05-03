import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkpedia/models/wiki_article.dart';
import 'package:linkpedia/shared/wiki_card.dart';

void main() {
  WikiArticle article = WikiArticle(
    title: 'Test Article',
    summary: 'A test article for testing purposes.',
    url: 'www.google.com'
  );

  testWidgets('WikiCard widget test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp( // context is required for Navigator
      home: WikiCard(article: article),
    ));

    // Check if the WikiCard widget is displayed
    expect(find.text(article.title), findsOneWidget);
    expect(find.text(article.summary), findsOneWidget);
  });
}
