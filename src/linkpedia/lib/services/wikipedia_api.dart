import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:linkpedia/models/wiki_article.dart';

const String _wikipediaBaseUrl = "https://en.wikipedia.org/w/api.php?";

class WikipediaService {
  final int numberOfArticles;
  final int numberOfCharacters;

  WikipediaService({ required this.numberOfArticles, required this.numberOfCharacters });

  Future<List<WikiArticle>> fetchArticles(String searchQuery) async {
    searchQuery.trim();
    searchQuery.replaceAll(' ', '+');

    /* Wikipedia API OpenSearch Url */
    // ignore: prefer_interpolation_to_compose_strings
    String url = _wikipediaBaseUrl
      + 'action=opensearch&'
      + 'format=json&' // get output as JSON
      + "limit=$numberOfArticles&" // Limit to $numberOfArticles articles
      + 'origin=*&' // something to do with CORS
      + "search=$searchQuery"; // search parameter

    final searchResponse = await http.get(Uri.parse(url));

    /* throw exception if there was an error fetching data */
    if (searchResponse.statusCode != 200) {
      throw Exception("Failed to load from Wikipedia API");
    }

    final searchData = jsonDecode(searchResponse.body);

    List<WikiArticle> articles = [];

    for (int i = 0; i < numberOfArticles; i++) {
      String articleTitle = searchData[1][i];
      String articleUrl = searchData[3][i];

      /* Wikipedia API Query Url */
      // ignore: prefer_interpolation_to_compose_strings
      url = _wikipediaBaseUrl
        + 'action=query&'
        + 'prop=extracts&' // extract Summary
        + 'exchars=$numberOfCharacters&' // cap extraction at $numberOfCharacters chars
        + 'exlimit=1&' // limit to one article
        + 'explaintext=True&' // fetch data as plain text instead of HTML
        + 'format=json&' // format to JSON
        + 'formatversion=2&' // removes need to get pageId before hand
        + 'origin=*&' // something to do with CORS
        + "titles=$articleTitle";

      final extractResponse = await http.get(Uri.parse(url));

      /* throw exception if there was an error fetching data */
      if (extractResponse.statusCode != 200) {
        throw Exception("Failed to load from Wikipedia API");
      }

      final extractData = jsonDecode(extractResponse.body);
      String articleSummary = extractData['query']['pages'][0]['extract'];

      articles.add(WikiArticle(title: articleTitle, summary: articleSummary, url: articleUrl));
    }

    return articles;
  }
}

/**
 * Refer to these urls for JSON response structure
 * 
 * OpenSearch: https://www.mediawiki.org/wiki/API:Opensearch#Response
 * * Note: the second list of the json is supposed to return the article summaries but it returns an empty string
 * 
 * Query: https://www.mediawiki.org/wiki/API:Query#Response
 */
