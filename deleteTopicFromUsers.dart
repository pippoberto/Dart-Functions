import 'package:cloud_firestore/cloud_firestore.dart';

Future deleteTopicFromUsers(
  List<DocumentReference> votedBy,
  List<DocumentReference> favoriteBy,
  DocumentReference topicRef,
) async {

  final batch = FirebaseFirestore.instance.batch();

  // Iter through every user in the list votedBy
  for (final reference in votedBy) {
    final documentSnapshot = await reference.get();
    if (documentSnapshot.exists) {
      final data = documentSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        final topicsYea =
            List<DocumentReference>.from(data['topics_yea'] as List<dynamic>);

        // remove from the user's topics yea the topic selected
        if (topicsYea != null && topicsYea.contains(topicRef)) {
          topicsYea.remove(topicRef);
          batch.update(reference, {'topics_yea': topicsYea});
        }

        final topicsNay =
            List<DocumentReference>.from(data['topics_nay'] as List<dynamic>);
       
        // remove from the user's topics nay the topic selected
        if (topicsNay != null && topicsNay.contains(topicRef)) {
          topicsNay.remove(topicRef);
          batch.update(reference, {'topics_nay': topicsNay});
        }

        final topicsVoted =
            List<DocumentReference>.from(data['topics_voted'] as List<dynamic>);
       
        // remove from the user's topics voted the topic selected
        if (topicsVoted != null && topicsVoted.contains(topicRef)) {
          topicsVoted.remove(topicRef);
          batch.update(reference, {'topics_voted': topicsVoted});
        }

        final topicsSkipped = List<DocumentReference>.from(
            data['topics_skipped'] as List<dynamic>);
        // remove from the user's topics skipped the topic selected
        if (topicsSkipped != null && topicsSkipped.contains(topicRef)) {
          topicsSkipped.remove(topicRef);
          batch.update(reference, {'topics_skipped': topicsSkipped});
        }
      }
    }
  }

  // Iter through every user in the list favoriteBy
  for (final reference in favoriteBy) {
    final documentSnapshot = await reference.get();
    if (documentSnapshot.exists) {
      final data = documentSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        final favorites =
            List<DocumentReference>.from(data['favorites'] as List<dynamic>);

        // remove from the user's favorites the topic selected
        if (favorites != null && favorites.contains(topicRef)) {
          favorites.remove(topicRef);
          batch.update(reference, {'favorites': favorites});
        }
      }
    }
  }

  await batch.commit();
}
