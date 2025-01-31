import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/domain/entity/emotion.dart';
import 'package:langlog/domain/entity/correction_sentence.dart';
import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/domain/entity/log_contents.dart';
import 'package:langlog/presentation/pages/day_log_write/day_log_correction_service.dart';
import 'package:langlog/presentation/pages/emotion_mood/emotion_mood_view_model.dart';
import 'package:langlog/provider.dart';

class DayLogViewModel extends AutoDisposeNotifier<DayLog> {
  @override
  DayLog build() {
    final emotion = ref.watch(emotionMoodViewModelProvider);

    return DayLog(
      date: DateTime.now().toIso8601String(),
      emotion: emotion,
      native: null,
      foreign: null,
      correctionResult: null,
      correctionSentence: null,
    );
  }

  // 감정 이모지 등록
  void setEmotion(Emotion emotion) {
    state = DayLog(
      date: state.date,
      emotion: emotion,
      native: state.native,
      foreign: state.foreign,
      correctionResult: state.correctionResult,
      correctionSentence: state.correctionSentence,
    );
  }

  // 일기 등록
  void setLogContents(LogContents? nativeLog, LogContents? foreignLog) {
    state = DayLog(
      date: state.date,
      emotion: state.emotion,
      native: nativeLog,
      foreign: foreignLog,
      correctionResult: state.correctionResult,
      correctionSentence: state.correctionSentence,
    );
  }

  // 일기 저장
  Future<void> saveDayLog() async {
    final dayLog = state;

    await ref.read(addDayLogUsecaseProvider).execute(dayLog);
    print("KEY == ${dayLog.keyDate}");
  }

  // 일기 조회
  Future<DayLog?> getDayLog(String key) async {
    final item = await ref.read(getDayLogUsecaseProvider).execute(key);
    return item;
  }

  // 일기 삭제
  Future<void> deleteDayLog(String key) async {
    await ref.read(deleteDayLogUsecaseProvider).execute(key);
  }

  // 일기 교정
  Future<void> logCorrection() async {
    await ref
        .read(dayLogCorrectionServiceProvider)
        .correctLog(state.foreign!.contents, setCorrectionSentence);
  }

  // 교정 일기 등록
  void setCorrectionSentence(
    String correctionResult,
    List<CorrectionSentence> correctionSentences,
  ) {
    state = DayLog(
      date: state.date,
      emotion: state.emotion,
      native: state.native,
      foreign: state.foreign,
      correctionResult: correctionResult,
      correctionSentence: correctionSentences,
    );
  }

  // 문장 교정 사유 반환
  Future<String> getCorrectionReason(CorrectionSentence sentence) async {
    return await ref
        .read(dayLogCorrectionServiceProvider)
        .getCorrectionReason(sentence);
  }
}

final dayLogViewModelProvider =
    NotifierProvider.autoDispose<DayLogViewModel, DayLog>(
  () => DayLogViewModel(),
);
