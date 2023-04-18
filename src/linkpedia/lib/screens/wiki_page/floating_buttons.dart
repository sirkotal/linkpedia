import 'package:flutter/material.dart';

import 'comments.dart';

class FloatingButtons extends StatefulWidget {
  final String title;
  final String url;

  const FloatingButtons({super.key, required this.title, required this.url});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons> {
  bool _showButtons = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _showButtons ? 1.0 : 0.0,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: Visibility(
              visible: _showButtons,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => Comments(articleTitle: widget.title, articleUrl: widget.url)
                  ));
                  setState(() {
                    _showButtons = false;
                  });
                },
                child: const Icon(Icons.comment),
              ),
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
      ]
    );
  }
}
