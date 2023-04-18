import 'package:flutter/material.dart';
import 'package:linkpedia/models/comment.dart';
import 'package:provider/provider.dart';

import 'comment_card.dart';

class CommentsList extends StatefulWidget {
  final String title;

  const CommentsList({super.key, required this.title});

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<List<Comment>>(
      builder: (context, comments, child) {
        if (comments.isEmpty) {
          return const Center(
            child: Text(
              'No comments yet',
              style: TextStyle(
                fontSize: 18.0
              ),
            )
          );
        }

        // sort comments by date (newest first)
        List<Comment> sortedComments = comments;
        sortedComments.sort((a, b) => b.timestamp.compareTo(a.timestamp));

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget> [
                Text(
                  "Comments on \"${widget.title}\":",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
                ...sortedComments.map((comment) => CommentCard(comment: comment)).toList()
              ],
            ),
          ),
        );
      }
    );
  }
}