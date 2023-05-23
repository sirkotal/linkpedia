import 'package:flutter/material.dart';
import 'package:linkpedia/models/comment.dart';
import 'package:linkpedia/models/user.dart';
import 'package:linkpedia/services/user_db.dart';
import 'package:linkpedia/shared/loading.dart';

class CommentCard extends StatefulWidget {
  final Comment comment;

  const CommentCard({super.key, required this.comment});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  late Future<UserData> futureAuthorData;

  @override
  void initState() {
    super.initState();
    futureAuthorData = UserDatabaseService().getUserData(widget.comment.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureAuthorData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData authorData = snapshot.data as UserData;
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        authorData.username,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        widget.comment.timestampToString(),
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ]
                  ),
                  Divider(
                    height: 0.5,
                    thickness: 1.5,
                    color: Colors.grey[850]
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    widget.comment.commentBody,
                    style: const TextStyle(
                      height: 1.5
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return const Loading();
      },
    );
  }
}
