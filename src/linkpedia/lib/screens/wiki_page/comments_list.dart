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
  DraggableScrollableController _scrollController = DraggableScrollableController();
  double _height = 0;

  double get height => _height;
  
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() { widget.onHeightChanged(_scrollController.size);
    print("Height changed to 3${_scrollController.size}");
    });
  }

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
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              DraggableScrollableSheet(
                controller: _scrollController,
                initialChildSize: 0.5,
                minChildSize: 0.5,
                maxChildSize: 0.75,
                builder: (context, controller) => SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: const BorderRadius.only(topLeft : Radius.circular(20.0), topRight:  Radius.circular(20.0)),
                    ),
                    child: Column( 
                      children: [ 
                        Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5.0),
                                child: Container(
                                  width: 100,
                                  height: 3,
                                  color: Colors.black,
                                ),
                              ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: controller,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
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
                          )
                        )
                      ]
                    )  
                  ),
                )
              )
            ]
          )
        );
      }
    );
  }
}

