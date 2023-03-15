import 'package:flutter/material.dart';
import 'package:linkpedia/screens/search_page/search_results.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
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
        title: const Text('Linkpedia'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Search: ',
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'What you want to search for',
                ),
                onSubmitted: (String text) {
                  _textController.clear();
                  
                  // TODO: Change to pushReplacement when bottom bar is implemented
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResults(query: text)
                    )
                  );
                }
              )
            ],
          ),
        )
      ),
    );
  }
}
