import 'package:flutter/material.dart';
import 'package:linkpedia/screens/wiki_page/add_comment.dart';
import 'package:linkpedia/screens/wiki_page/comments.dart';
import 'package:linkpedia/screens/wiki_page/floating_buttons.dart';
import 'package:linkpedia/shared/bottom_bar.dart';
import 'package:linkpedia/shared/loading.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiPage extends StatefulWidget {
  final String url;

  const WikiPage({super.key, required this.url});

  @override
  State<WikiPage> createState() => _WikiPageState();
}

class _WikiPageState extends State<WikiPage> {
  final WebViewController _webViewController = WebViewController();
  String pageTitle = '';
  String currentUrl = '';
  bool _isLoading = true;
  bool _showComments = false;
  double height = 0;

  @override
  void initState() {
    super.initState();

    _webViewController
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) => setState(() { 
          _isLoading = true;
          _showComments = false;
        }),
        onPageFinished: (String url) async {
          setState(() => _isLoading = false); // test in FEUP if slower internet don't cause problems

          String? title = await _webViewController.getTitle();
          currentUrl = await _webViewController.currentUrl() ?? '';

          // remove mobile version url
          if (currentUrl.contains('.m.')) {
            currentUrl = currentUrl.replaceAll('.m.', '.');
          }

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
      child: _isLoading ? const Loading() : Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ),
        body: Stack(
              children: [
                WebViewWidget(controller: _webViewController),
                Visibility(
                  visible: _showComments,
                  child: Comments(articleTitle: pageTitle, articleUrl: currentUrl, onHeight: (_height) {
                    setState(() {
                      height = _height;
                    });
                  })),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: FloatingButtons(title: pageTitle, url: currentUrl, onTouch: (showComments) {
                    setState(() {
                      _showComments = showComments;
                    });
                  })),
                ],
            ),
        bottomNavigationBar: height >= 0.2 ? AddComment(articleTitle: pageTitle, articleUrl: currentUrl) : BottomBar(searchSelected: true),
      ),
    );
  }
}
