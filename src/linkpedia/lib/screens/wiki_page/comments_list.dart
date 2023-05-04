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
      if (comments.isEmpty) {
        return const Center(
          child: Text(
            'No comments yet',
            style: TextStyle(fontSize: 18.0),
          )
        );
      }
      // sort comments by date (newest first)
      List<Comment> sortedComments = comments;
      sortedComments.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return DraggableScrollableSheet(
        controller: _scrollController,
        initialChildSize: 0.5,
        minChildSize: 0.2,
        maxChildSize: 0.75,
        builder: (context, controller) => Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5),
            borderRadius:
                const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          ),
          child: SingleChildScrollView(
            controller: controller,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Comments on \"${widget.title}\":",
                    style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  ...sortedComments.map((comment) => CommentCard(comment: comment)).toList()
                ],
              ),
            ),
          )
        )
      );
    });
  }
}
