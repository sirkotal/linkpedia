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
  String pageTitle = '';
  String currentUrl = '';

  @override
  void initState() {
    super.initState();

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (String url) async {
          String? title = await _webViewController.getTitle();
          currentUrl = await _webViewController.currentUrl() ?? '';
          setState(() {
            pageTitle = title!.substring(0, title.length - ' - Wikipedia'.length);
          });
        }
      ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          await _webViewController.goBack();
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context);
            },
          )
        ),
        body: WebViewWidget(controller: _webViewController),
        floatingActionButton: FloatingButtons(
          webViewController: _webViewController
        ),
        bottomNavigationBar: BottomBar(searchSelected: true),
      ),
    );
  }
}
