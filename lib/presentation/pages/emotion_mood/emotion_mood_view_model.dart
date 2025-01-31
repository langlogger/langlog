import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/domain/entity/emotion.dart';

class EmotionMoodViewModel extends AutoDisposeNotifier<Emotion> {
  @override
  Emotion build() {
    return Emotion.undefined;
  }

  void changeMood(Emotion emotion) {
    state = emotion;
  }
}

final emotionMoodViewModelProvider =
    NotifierProvider.autoDispose<EmotionMoodViewModel, Emotion>(
  () {
    return EmotionMoodViewModel();
  },
);
