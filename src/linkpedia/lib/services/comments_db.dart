import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:linkpedia/models/comment.dart';

class CommentsDatabaseService {
  static final CollectionReference commentsRef = FirebaseFirestore.instance.collection('comments');

  static Future<void> addComment(Comment comment) async {
    return await commentsRef.doc(comment.commentId).set({
      'userId': comment.userId,
      'articleUrl': comment.articleUrl,
      'commentBody': comment.commentBody,
      'timestamp': comment.timestamp.microsecondsSinceEpoch,
      'votes': comment.votes
    });
  }

  static Future<void> updateComment(Comment comment) async {
    return await commentsRef.doc(comment.commentId).update({
      'commentBody': comment.commentBody,
      'votes': comment.votes
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
          timestamp: DateTime.fromMicrosecondsSinceEpoch(doc.get('timestamp')),
          votes: doc.get('votes')
        );
      }).toList();
    });
  }

  
  static Future<int> CheckValue(String userId, String commentId) async {
    try {
      QuerySnapshot likesSnapshot = await FirebaseFirestore.instance
          .collection('comments')
          .doc(commentId)
          .collection('votes')
          .where('userId', isEqualTo: userId)
          .limit(1)
          .get();
      print(commentId);
      print(userId);
      if (likesSnapshot.docs.isNotEmpty){
        print('entrou');
        print(likesSnapshot.docs.first['voteValue']);
        return likesSnapshot.docs.first['voteValue'];}
      else{
        print('here?');
        return 0;}
    } catch (error) {
      print('Error checking user like status: $error');
      return -2;
    }
  }


  static Future<void> updateUserLikeStatus(String userId, String commentId, bool liked, bool disliked) async {
    try {
      // Check if the user has already liked the comment
      int hasLiked = await CheckValue(userId, commentId);

      if (hasLiked == 1 && disliked){
          await FirebaseFirestore.instance
            .collection('comments')
            .doc(commentId)
            .collection('votes')
            .where('userId', isEqualTo: userId)
            .limit(1)
            .get()
            .then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            // Delete the like document for the user
            snapshot.docs.first.reference.update({
              'voteValue': -1,
            });
          }
          });
      }  
      else if (hasLiked == -1 && liked){
          await FirebaseFirestore.instance
            .collection('comments')
            .doc(commentId)
            .collection('votes')
            .where('userId', isEqualTo: userId)
            .limit(1)
            .get()
            .then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            // Delete the like document for the user
            snapshot.docs.first.reference.update({
              'voteValue': 1,
            });
          }
          });
      }
      else if ((hasLiked==1  && !liked) || (hasLiked==-1 && !disliked)) {
        // User has liked the comment, but wants to unlike it
        await FirebaseFirestore.instance
            .collection('comments')
            .doc(commentId)
            .collection('votes')
            .where('userId', isEqualTo: userId)
            .limit(1)
            .get()
            .then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            // Delete the like document for the user
            snapshot.docs.first.reference.delete();
          }
          });
      } 
      else if (hasLiked == 0 && (liked || disliked)) {
        // User has not liked the comment, but wants to like it
        await FirebaseFirestore.instance
            .collection('comments')
            .doc(commentId)
            .collection('votes')
            .add({
          'userId': userId,
          'voteValue': liked ? 1 : (disliked ? -1 : 0),
        });
      }
    } catch (error) {
      print('Error updating user like status: $error');
    }
  }

}