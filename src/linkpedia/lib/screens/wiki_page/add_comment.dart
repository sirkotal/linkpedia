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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Comment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Comment on "${widget.articleTitle}"',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                maxLines: 10,
                maxLength: 500,
                decoration: const InputDecoration(
                  hintText: 'Comment',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a comment';
                  }
                  return null;
                },
                onChanged: (value) => commentBody = value,
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Comment comment = Comment(
                      commentId: const Uuid().v4(),
                      userId: user.uid,
                      articleUrl: widget.articleUrl,
                      commentBody: commentBody,
                      timestamp: DateTime.now()
                    );
            
                    CommentsDatabaseService.addComment(comment).then((value) {
                      Navigator.pop(context);
                    });
                  }
                },
                child: const Text('Submit'),
              )
            ],
          )
        ),
      )
    );
  }
}
