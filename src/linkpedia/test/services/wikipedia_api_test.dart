import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:linkpedia/services/wikipedia_api.dart';

void main() {
  // enough to test
  WikipediaService wikiApi = WikipediaService(numberOfArticles: 3, numberOfCharacters: 50);
  group('fetchArticleSummary', () {
    test('returns article summary when http response is successful', () async {
      
      String responseArticleSummary = "Tennis is a racket sport that is played either individually...";
      final mockHttpClient = MockClient((request) async {
        final response = {
          "batchcomplete": true,
          "query": {
            "pages": [
              {
                "pageid": 29773,
                "ns": 0,
                "title": "Tennis",
                "extract": responseArticleSummary
              }
            ]
          }
        };
        
        return Response(jsonEncode(response), 200);
      });

      dynamic articleSummary = await wikiApi.fetchArticleSummary(mockHttpClient, 'Tennis');

      expect(articleSummary, isA<String>());
      expect(articleSummary, responseArticleSummary);

      // 50 characters or less because of $numberOfCharacters or 53 with '...' included
      expect((articleSummary.length <= 50 || articleSummary.length == 53), true);
    });

    test('throws an exception when http response is not successful', () async {
      final mockHttpClient = MockClient((request) async => Response('', 404));

      try {
        await wikiApi.fetchArticleSummary(mockHttpClient, 'Tennis');
        fail('Expected exception with message "Failed to load from Wikipedia API" was not thrown');
      } on Exception catch (e) {
        expect(e, isA<Exception>());
        String exceptionMessage = e.toString().substring(11); // remove 'Exception: ' from the toString() method
        expect(exceptionMessage, equals('Failed to load from Wikipedia API'));
      }
    });
  });
}
