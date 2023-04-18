import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkpedia/models/comment.dart';

class CommentsDatabaseService {
  static final CollectionReference commentsRef = FirebaseFirestore.instance.collection('comments');

  static Future<void> addComment(Comment comment) async {
    return await commentsRef.doc(comment.commentId).set({
      'userId': comment.userId,
      'articleUrl': comment.articleUrl,
      'commentBody': comment.commentBody,
      'timestamp': comment.timestamp.microsecondsSinceEpoch.toString()
    });
  }

  final String articleUrl;
  CommentsDatabaseService({ required this.articleUrl });

  Stream<List<Comment>> get commentsByArticle {
    return commentsRef.where('articleUrl', isEqualTo: articleUrl).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Comment(
          commentId: doc.id,
          userId: doc.get('userId'),
          articleUrl: doc.get('articleUrl'),
          commentBody: doc.get('commentBody'),
          timestamp: DateTime.fromMicrosecondsSinceEpoch(int.parse(doc.get('timestamp')))
        );
      }).toList();
    });
  }
}
