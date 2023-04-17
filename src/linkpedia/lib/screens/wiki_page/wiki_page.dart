import 'package:flutter/material.dart';
import 'package:linkpedia/screens/wiki_page/floating_buttons.dart';
import 'package:linkpedia/shared/bottom_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiPage extends StatefulWidget {
  final String url;
  final String title;

  const WikiPage({super.key, required this.url, required this.title});

  @override
  State<WikiPage> createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  final WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: WebViewWidget(controller: _webViewController),
        floatingActionButton: FloatingButtons(
            webViewController: _webViewController, url: widget.url),
        bottomNavigationBar: BottomBar(searchSelected: true),
      ),
    );
  }

  Future<bool> onBackPressed() {
    Navigator.pop(context);
    return Future.value(false);
  }
}
