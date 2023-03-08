import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:linkpedia/models/wiki_article.dart';
import 'package:linkpedia/services/wikipedia_api.dart';

String exceptionMessageParser(String exceptionString) {
  return exceptionString.substring(11);
}

void main() {
  group('fetchArticleSummary', () {
    // enough to test
    WikipediaService wikiApi = WikipediaService(numberOfArticles: 3, numberOfCharacters: 50);
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
        
        return http.Response(jsonEncode(response), 200);
      });

      String articleSummary;
      try {
        articleSummary = await wikiApi.fetchArticleSummary(mockHttpClient, 'Tennis');
      } catch (e) {
        fail('Exception/Error not expected');
      }

      expect(articleSummary, isA<String>());
      expect(articleSummary, responseArticleSummary);

      // remove last word because last word can start at limit char (the 3 dots do not count as a char for the limit)
      String noLastWord = articleSummary.substring(0, articleSummary.lastIndexOf(' '));
      expect(noLastWord.length < 50, true);
    });

    test('throws an exception when http response is not successful', () async {
      final mockHttpClient = MockClient((request) async => http.Response('', 404));

      try {
        await wikiApi.fetchArticleSummary(mockHttpClient, 'Tennis');
        fail('Expected exception with message "Failed to load from Wikipedia API" was not thrown');
      } on Exception catch (e) {
        expect(e, isA<Exception>());
        expect(exceptionMessageParser(e.toString()), equals('Failed to load from Wikipedia API'));
      }
    });
  });

  group('fetchArticles', () {
    // Mock fetch summary fot searchQuery 'tennis' with $numberOfArticles = 3
    Future<String> mockFetchArticleSummary(http.Client client, String articleTitle) async {
      if (articleTitle == 'Tennis') {
        return 'Tennis is a racket sport that is played either individually...';
      } else if (articleTitle == 'Tennis scoring system') {
        return 'The tennis scoring system is a standard widespread...';
      } else if (articleTitle == 'Tennessine') {
        return 'Tennessine is a synthetic chemical element with the...';
      }

      throw Exception('Failed to load from Wikipedia API');
    }

    WikipediaService wikiApi = WikipediaService(numberOfArticles: 3, numberOfCharacters: 50, fetchArticleSummary: mockFetchArticleSummary);
    test('returns articles when http response is successful', () async {
      final mockHttpClient = MockClient((request) async {
        final response = [
          "tennis",
          [
            "Tennis",
            "Tennis scoring system",
            "Tennessine"
          ],
          [
            "",
            "",
            ""
          ],
          [
            "https://en.wikipedia.org/wiki/Tennis",
            "https://en.wikipedia.org/wiki/Tennis_scoring_system",
            "https://en.wikipedia.org/wiki/Tennessine"
          ]
        ];
        
        return http.Response(jsonEncode(response), 200);
      });

      List<WikiArticle> articles;
      try {
        articles = await wikiApi.fetchArticles(mockHttpClient, 'tennis');
      } catch (e) {
        fail('Exception/Error not expected');
      }

      expect(articles.length, 3); // $numberOfArticles

      expect(articles[0].title, 'Tennis');
      expect(articles[0].url, 'https://en.wikipedia.org/wiki/Tennis');
      expect(articles[0].summary, 'Tennis is a racket sport that is played either individually...');

      expect(articles[1].title, 'Tennis scoring system');
      expect(articles[1].url, 'https://en.wikipedia.org/wiki/Tennis_scoring_system');
      expect(articles[1].summary, 'The tennis scoring system is a standard widespread...');

      expect(articles[2].title, 'Tennessine');
      expect(articles[2].url, 'https://en.wikipedia.org/wiki/Tennessine');
      expect(articles[2].summary, 'Tennessine is a synthetic chemical element with the...');
    });

    test('throws an exception when fetchArticleSummary throws an exception', () async {
      // All titles throw exception
      final mockHttpClient = MockClient((request) async {
        final response = [
          "yes",
          [
            "Yes",
            "No",
            "Sometimes"
          ],
          [
            "",
            "",
            ""
          ],
          [
            "https://en.wikipedia.org/wiki/Tennis",
            "https://en.wikipedia.org/wiki/Tennis_scoring_system",
            "https://en.wikipedia.org/wiki/Tennessine"
          ]
        ];
        
        return http.Response(jsonEncode(response), 200);
      });

      try {
        await wikiApi.fetchArticles(mockHttpClient, 'yes');
        fail('Expected exception with message "Failed to fetch article summary" was not thrown');
      } on Exception catch (e) {
        expect(e, isA<Exception>());
        expect(exceptionMessageParser(e.toString()), 'Failed to fetch article summary');
      }
    });

    test('throws an exception when http response is not successful', () async {
      final mockHttpClient = MockClient((request) async => http.Response('', 404));
      try {
        await wikiApi.fetchArticles(mockHttpClient, 'tennis');
        fail('Expected exception with message "Failed to load from Wikipedia API" was not thrown');
      } on Exception catch (e) {
        expect(e, isA<Exception>());
        expect(exceptionMessageParser(e.toString()), 'Failed to load from Wikipedia API');
      }
    });
  });
}
