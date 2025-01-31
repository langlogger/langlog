import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomTopicViewModel extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  Future<void> getRandomTopic() async {
    final firestore = FirebaseFirestore.instance;
    final topicRef = firestore.collection('topic');
    final result = await topicRef.get();
    final docs = result.docs;

    int randomIndex = Random().nextInt(docs.length);

    state = docs[randomIndex].data()['topic'];
  }
}

final randomTopicViewModelProvider =
    NotifierProvider<RandomTopicViewModel, String>(
  () => RandomTopicViewModel(),
);
