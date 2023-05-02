import 'package:intl/intl.dart';

class Comment {
  final String commentId; /* use uuid: `Uuid().v4()` */
  final String userId;
  final String articleUrl;
  String commentBody;
  final DateTime timestamp; /* use microseconds since epoch: DateTime.now().microsecondsSinceEpoch.toString() */
  int votes;

  Comment({
    required this.commentId,
    required this.userId,
    required this.articleUrl,
    required this.commentBody,
    required this.timestamp,
    this.votes = 0
  });

  String timestampToString() {
    return DateFormat('dd-MM-yyyy kk:mm').format(timestamp);
  }
}