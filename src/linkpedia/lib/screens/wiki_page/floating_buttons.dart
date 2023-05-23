import 'package:flutter/material.dart';
import 'package:linkpedia/screens/wiki_page/comments_list.dart';

import 'comments.dart';

class FloatingButtons extends StatefulWidget {
  final String title;
  final String url;
  final Function(bool showComments) onTouch;

  const FloatingButtons({super.key, required this.title, required this.url, required this.onTouch});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons> {
  bool showComments = false;
  double _height = 0;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  showComments = !showComments;
                  widget.onTouch(showComments);
                });
              },
              child: const Icon(Icons.comment),
            ),
          );
  }
}