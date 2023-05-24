import 'package:cloud_firestore/cloud_firestore.dart';

class FollowDatabaseService {
  static final CollectionReference pagesRef = FirebaseFirestore.instance.collection('pages');

  static Future<void> addPage(String pageTitle, String userId) async {
    final page = pagesRef.doc(pageTitle);
    final snapshot = await page.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;  
      List<String> userIds = List<String>.from(data['userIds'] ?? []); 
      print('before insert');
      print(userIds);
      userIds.add(userId);
      print(userIds);
      return await page.update({
        'userIds': userIds,
      });
    } else {
      print('else add');
      return await page.set({
        'userIds': [userId],
      });
    }
  }

  static Future<void> removePage(String pageTitle, String userId) async {
    final page = pagesRef.doc(pageTitle);
    final snapshot = await page.get();
    if (snapshot.exists) {
      final data = snapshot.data() as Map<String, dynamic>;  
      List<String> userIds = List<String>.from(data['userIds'] ?? []);
      print('beforehere');
      print(userIds);
      userIds.remove(userId);
      print(userIds);
      if (userIds.isEmpty) {
        print('removehere');
        return await page.delete();
      } else {
        return await page.update({
          'userIds': userIds,
        });
      }
    } else {
      return; 
    }
  }

  static Future<bool> checkFollow(String pageTitle, String userId) async {
    try {
      final pageSnapshot = await pagesRef.doc(pageTitle).get();
      if (pageSnapshot.exists) {
        final data = pageSnapshot.data() as Map<String, dynamic>;
        final userIds = List<String>.from(data['userIds'] ?? []);
        return userIds.contains(userId);
      }

      return false;
    } catch (error, stackTrace) {
      print('Error: $error');
      print('Stack trace: $stackTrace');
      return false;
    }
  }


}