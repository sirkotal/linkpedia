import 'package:flutter/material.dart';
import 'package:linkpedia/models/wiki_article.dart';
import 'package:linkpedia/services/wikipedia_api.dart';
import 'package:http/http.dart' as http;
import 'package:linkpedia/shared/bottom_bar.dart';
import 'package:linkpedia/shared/wiki_card.dart';

class SearchResults extends StatefulWidget {
  final String query;

  const SearchResults({super.key, required this.query});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late TextEditingController _textController;
  
  late Future<List<WikiArticle>> futureArticles;
  WikipediaService wikiService = WikipediaService(
    numberOfArticles: 10,
    numberOfCharacters: 200
  );

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textController.text = widget.query;

    futureArticles = wikiService.fetchArticles(http.Client(), widget.query);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0)
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  prefixIconColor: Colors.black,
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none
                ),
                onSubmitted: (String text) {
                  _textController.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResults(query: text)
                    )
                  );
                },
              ),
          ),
        )
      ),
      body: FutureBuilder<List<WikiArticle>>(
        future: futureArticles,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<WikiArticle> articles = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Results for "${widget.query}"',
                      style: const TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: articles.map((art) => WikiCard(article: art)).toList()
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            Error();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: BottomBar(searchSelected: true),
    );
  }
}
