import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FloatingButtons extends StatefulWidget {
  final WebViewController webViewController;
  final String url;

  const FloatingButtons({super.key, required this.webViewController, required this.url});

  @override
  State<FloatingButtons> createState() => _FloatingButtonsState();
}

class _FloatingButtonsState extends State<FloatingButtons> {
  bool _showButtons = false;

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
                  widget.webViewController.loadRequest(Uri.parse(widget.url));
                  setState(() {
                    _showButtons = false;
                  });
                },
                child: const Icon(Icons.arrow_back_rounded),
              ),
            ),
          ),
        ),
        // TODO: for comments
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _showButtons ? 1.0 : 0.0,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: Visibility(
              visible: _showButtons,
              child: FloatingActionButton(
                onPressed: () {
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