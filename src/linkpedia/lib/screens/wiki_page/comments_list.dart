import 'package:flutter/material.dart';
import 'package:linkpedia/models/comment.dart';
import 'package:provider/provider.dart';

import 'comment_card.dart';

class CommentsList extends StatefulWidget {
  const CommentsList({super.key});

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  Widget build(BuildContext context) {
    final comments = Provider.of<List<Comment>>(context);

    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return CommentCard(comment: comments[index]);
      },
    );
  }
}