import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiPage extends StatefulWidget {
  final String url;
  
  const WikiPage({super.key, required this.url});

  @override
  State<WikiPage> createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  String title = '';
  final WebViewController _webViewController = WebViewController();

  @override
  void initState() {
    super.initState();

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (url) async {
          String? pageTitle = await _webViewController.getTitle();
          
          // Removes the ' - Wikipidia' from the title
          pageTitle = pageTitle!.substring(0, pageTitle.length - 12);
          setState(() {
            title = pageTitle!;
          });
        }
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title)
      ),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
