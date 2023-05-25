import 'package:flutter/material.dart';

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