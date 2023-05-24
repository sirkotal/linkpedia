import 'package:flutter/material.dart';
import 'package:linkpedia/screens/wiki_page/add_comment.dart';
import 'package:linkpedia/screens/wiki_page/comments.dart';
import 'package:linkpedia/screens/wiki_page/floating_buttons.dart';
import 'package:linkpedia/shared/top_bar.dart';
import 'package:linkpedia/shared/bottom_bar.dart';
import 'package:linkpedia/shared/loading.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:linkpedia/models/user.dart';
import 'package:linkpedia/services/follow.dart';
import 'package:provider/provider.dart';





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
  bool _follow = false;
  double _height = 0;
  User? user;

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

  Future<bool> checkFollowStatus(String pageTitle, String userId) async {
    return await FollowDatabaseService.checkFollow(pageTitle, userId);
  }

  Future<void> toggleFollowStatus(String pageTitle, String userId) async {
    if (_follow) {
      await FollowDatabaseService.removePage(pageTitle, userId);
    } else {
      await FollowDatabaseService.addPage(pageTitle, userId);
    }
  }


  void status(User? user) async {
    if (user != null) {  
      _follow = await FollowDatabaseService.checkFollow(pageTitle, user!.uid);
      print(_follow);
      return;
    }
    _follow = false;

  }

  @override
  Widget build(BuildContext context) {
    print('start');
    user = Provider.of<User?>(context);
    final userId = user?.uid ?? '';
    print(user!.uid);
    //status(user);
    return WillPopScope(
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          await _webViewController.goBack();
        }
        return false;
      },
      child: _isLoading ? const Loading() : Scaffold(
        appBar: TopBar(
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
                FutureBuilder<bool>(
                    future: checkFollowStatus(pageTitle, userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }

                      if (snapshot.hasData) {
                        _follow = snapshot.data!;
                        return IconButton(
                          onPressed: () async {
                            await  toggleFollowStatus(pageTitle, userId);
                            setState(() {
                              _follow = !_follow;
                            });
                          },
                          icon: const Icon(Icons.turned_in),
                          color: _follow ? Colors.deepPurple : Colors.black,
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                Visibility(
                  visible: _showComments,
                  child: Comments(articleTitle: pageTitle, articleUrl: currentUrl, onHeight: (height) {
                    setState(() {
                      _height = height;
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
        bottomNavigationBar: _height >= 0.2 ? AddComment(articleTitle: pageTitle, articleUrl: currentUrl) : BottomBar(searchSelected: true),
      ),
    );
  }
}
