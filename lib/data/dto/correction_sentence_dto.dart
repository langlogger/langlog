import 'package:hive/hive.dart';

part 'correction_sentence_dto.g.dart';

@HiveType(typeId: 2)
class CorrectionSentenceDto extends HiveObject {
  @HiveField(0)
  String originSentence;

  @HiveField(1)
  String correctSentence;

  @HiveField(2)
  String? correctionReason;

  @HiveField(3)
  String? nativeInterpretation;

  CorrectionSentenceDto({
    required this.originSentence,
    required this.correctSentence,
    this.correctionReason,
    this.nativeInterpretation,
  });
}
