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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
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
      );
  }
}
