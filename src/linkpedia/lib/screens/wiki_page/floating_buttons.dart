import 'package:flutter/material.dart';
import 'package:linkpedia/screens/wiki_page/comments_list.dart';

import 'comments.dart';

class FloatingButtons extends StatefulWidget {
  final String title;
  final String url;
  final Function onTouch;

  const FloatingButtons({super.key, required this.title, required this.url, required this.onTouch});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons> {
  bool showComments = false, _showButtons = false;
  double _height = 0;


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: _showButtons,
          child: Container(
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
                ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                _showButtons = !_showButtons;
              });
            },
            child: Icon(_showButtons ? Icons.close : Icons.more_horiz),
          ),
        ),
      ],
    );
          
  }
}