import 'package:flutter/material.dart';
import 'package:linkpedia/models/comment.dart';
import 'package:linkpedia/models/user.dart';
import 'package:linkpedia/services/comments_db.dart';
import 'package:linkpedia/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddComment extends StatefulWidget {
  final String articleUrl;
  final String articleTitle;

  const AddComment({super.key, required this.articleTitle, required this.articleUrl});

  @override
  State<AddComment> createState() => _AddCommentState();
}

class _AddCommentState extends State<AddComment> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<User?>(context);
    String commentBody = '';

    if (user == null) {
      return const Loading();
    }

    return BottomAppBar(
      child: Container(
        child: Row(
          children: <Widget>[
            Expanded(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Add a comment',
                    contentPadding: EdgeInsets.all(10.0),
                    border: InputBorder.none,
                  ),
                  validator: (val) => val!.isEmpty ? 'Please enter a comment' : null,
                  onChanged: (val) {
                    setState(() {
                      commentBody = val;
                    });
                  },
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await CommentsDatabaseService.addComment(
                    Comment(
                      commentId: const Uuid().v4(),
                      userId: user.uid,
                      articleUrl: widget.articleUrl,
                      commentBody: commentBody,
                      timestamp: DateTime.now(),
                    )
                  );
                }
              }
            )
          ],
        ),
      )
    );
  }
}
