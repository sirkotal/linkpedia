import 'package:flutter/material.dart';
import 'package:linkpedia/models/comment.dart';
import 'package:provider/provider.dart';

import 'comment_card.dart';

class CommentsList extends StatefulWidget {
  final String title;
  final Function(double height) onHeightChanged;

  const CommentsList({super.key, required this.title, required this.onHeightChanged});

  @override
  State<CommentsList> createState() => _CommentsListState();
}

class _CommentsListState extends State<CommentsList> {
  final DraggableScrollableController _scrollController = DraggableScrollableController();
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      widget.onHeightChanged(_scrollController.size);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<List<Comment>>(builder: (context, comments, child) {
      List<Comment> sortedComments = [];
      if (comments.isNotEmpty) {
        // sort comments by date (newest first)
        sortedComments = comments;
        sortedComments.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      }
      return DraggableScrollableSheet(
        controller: _scrollController,
        initialChildSize: 0.15,
        minChildSize: 0.15,
        maxChildSize: 0.75,
        builder: (context, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.deepPurple,
            borderRadius:
              BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                const Text(
                  "Comments",
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold,  color: Colors.white),
                ),
                if (comments.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0), // Add desired top padding
                    child: Text(
                      "No comments yet!",
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ...sortedComments.map((comment) => CommentCard(comment: comment)).toList(),
              ],
              ),
            ),
          )
        )
      );
    });
  }
}
