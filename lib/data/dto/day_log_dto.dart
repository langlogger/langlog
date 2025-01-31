import 'package:hive/hive.dart';
import 'package:langlog/data/dto/correction_sentence_dto.dart';
import 'package:langlog/data/dto/log_contents_dto.dart';

part 'day_log_dto.g.dart';

@HiveType(typeId: 0)
class DayLogDto extends HiveObject {
  @HiveField(0)
  String date;

  @HiveField(1)
  String emotion;

  @HiveField(2)
  LogContentsDto? native;

  @HiveField(3)
  LogContentsDto? foreign;

  @HiveField(4)
  String? correctionResult;

  @HiveField(5)
  List<CorrectionSentenceDto>? correctionSentence;

  DayLogDto({
    required this.date,
    required this.emotion,
    required this.native,
    required this.foreign,
    required this.correctionResult,
    required this.correctionSentence,
  });
}
