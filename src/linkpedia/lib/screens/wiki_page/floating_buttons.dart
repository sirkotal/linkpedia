import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'comments.dart';

class FloatingButtons extends StatefulWidget {
  final WebViewController webViewController;

  const FloatingButtons({super.key, required this.webViewController});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons> {
  bool _showButtons = false;
  String currentUrl = '';

  @override
  void initState() {
    super.initState();

    widget.webViewController.currentUrl().then((value) => currentUrl = value ?? '');
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
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Comments(articleUrl: currentUrl)));
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
