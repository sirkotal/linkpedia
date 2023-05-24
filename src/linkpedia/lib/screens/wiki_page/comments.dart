import 'package:flutter/material.dart';
import 'package:linkpedia/models/comment.dart';
import 'package:linkpedia/services/comments_db.dart';
import 'package:linkpedia/screens/wiki_page/comments_list.dart';
import 'package:provider/provider.dart';

class Comments extends StatefulWidget {
  final String articleTitle;
  final String articleUrl;
  final Function(double height) onHeight;

  const Comments({super.key, required this.articleTitle, required this.articleUrl, required this.onHeight});

  @override
  State<Comments> createState() => _CommentsState();
}

//? test: https://en.wikipedia.org/wiki/The_New_York_Times (search for "the")
class _CommentsState extends State<Comments> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Comment>>.value(
      value: CommentsDatabaseService(articleUrl: widget.articleUrl).commentsByArticle,
      initialData: const [],
      child: CommentsList(title: widget.articleTitle, onHeightChanged: (height) {
          setState(() {
            widget.onHeight(height);
          });
        })
    );
  }
}
