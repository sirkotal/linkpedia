import 'package:flutter/material.dart';
import 'package:linkpedia/models/comment.dart';
import 'package:linkpedia/models/user.dart';
import 'package:linkpedia/screens/wiki_page/add_comment.dart';
import 'package:linkpedia/services/authentication.dart';
import 'package:linkpedia/services/comments_db.dart';
import 'package:linkpedia/screens/wiki_page/comments_list.dart';
import 'package:linkpedia/shared/bottom_bar.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  final String articleTitle;
  final String articleUrl;

  const Comments({super.key, required this.articleTitle, required this.articleUrl});

  @override
  State<Comments> createState() => _CommentsState();
}

//? test: https://en.wikipedia.org/wiki/The_New_York_Times (search for "the")
class _CommentsState extends State<Comments> {
  double? _height = 0;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Comment>>.value(
      value: CommentsDatabaseService(articleUrl: widget.articleUrl).commentsByArticle,
      initialData: const [],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),   
        ),
        body: CommentsList(title: widget.articleTitle, onHeightChanged: (height) {setState(() {
            _height = height;
          });
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return StreamProvider<User?>.value(
                value: AuthService().user,
                initialData: null,
                child: AddComment(articleTitle: widget.articleTitle, articleUrl: widget.articleUrl),
              );
            }));
          },
          child: const Icon(Icons.add)
        ),
        bottomNavigationBar: _height! >= 0.3 ? AddComment(articleTitle: widget.articleTitle, articleUrl: widget.articleUrl) : BottomBar(),
      ),
    );
  }
}
