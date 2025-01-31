import 'package:langlog/domain/entity/correction_sentence.dart';

String getCorrectionResult(
  String originText,
  List<CorrectionSentence> correctionSentences,
) {
  for (var sentence in correctionSentences) {
    originText = originText.replaceFirst(
        sentence.originSentence, sentence.correctSentence);
  }
  return originText;
}
