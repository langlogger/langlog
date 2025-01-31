import 'package:langlog/domain/entity/emotion.dart';
import 'package:langlog/data/dto/correction_sentence_dto.dart';
import 'package:langlog/data/dto/day_log_dto.dart';
import 'package:langlog/data/dto/log_contents_dto.dart';
import 'package:langlog/domain/entity/correction_sentence.dart';
import 'package:langlog/domain/entity/day_log.dart';
import 'package:langlog/domain/entity/log_contents.dart';

class EntityDtoMapper {
  // LogContents -> LogContentsDto 변환
  static LogContentsDto logContentsToDto(LogContents logContents) {
    return LogContentsDto(
      title: logContents.title,
      contents: logContents.contents,
    );
  }

  // CorrectionSentence -> CorrectionSentenceDto 변환
  static CorrectionSentenceDto correctionSentenceToDto(
      CorrectionSentence correctionSentence) {
    return CorrectionSentenceDto(
      originSentence: correctionSentence.originSentence,
      correctSentence: correctionSentence.correctSentence,
      correctionReason: correctionSentence.correctionReason,
      nativeInterpretation: correctionSentence.nativeInterpretation,
    );
  }

  // DayLog -> DayLogDto 변환
  static DayLogDto dayLogToDto(DayLog dayLog) {
    return DayLogDto(
      date: dayLog.date,
      emotion: dayLog.emotion.code,
      native: dayLog.native != null ? logContentsToDto(dayLog.native!) : null,
      foreign:
          dayLog.foreign != null ? logContentsToDto(dayLog.foreign!) : null,
      correctionResult: dayLog.correctionResult,
      correctionSentence: dayLog.correctionSentence
          ?.map((sentence) => correctionSentenceToDto(sentence))
          .toList(),
    );
  }

  // LogContentsDto -> LogContents 변환
  static LogContents logContentsFromDto(LogContentsDto logContentsDto) {
    return LogContents(
      title: logContentsDto.title,
      contents: logContentsDto.contents,
    );
  }

  // CorrectionSentenceDto -> CorrectionSentence 변환
  static CorrectionSentence correctionSentenceFromDto(
      CorrectionSentenceDto correctionSentenceDto) {
    return CorrectionSentence(
      originSentence: correctionSentenceDto.originSentence,
      correctSentence: correctionSentenceDto.correctSentence,
      correctionReason: correctionSentenceDto.correctionReason,
      nativeInterpretation: correctionSentenceDto.nativeInterpretation,
    );
  }

  // DayLogDto -> DayLog 변환
  static DayLog dayLogFromDto(DayLogDto dayLogDto) {
    return DayLog(
      date: dayLogDto.date,
      emotion: Emotion.getByCode(dayLogDto.emotion),
      native: dayLogDto.native != null
          ? logContentsFromDto(dayLogDto.native!)
          : null,
      foreign: dayLogDto.foreign != null
          ? logContentsFromDto(dayLogDto.foreign!)
          : null,
      correctionResult: dayLogDto.correctionResult,
      correctionSentence: dayLogDto.correctionSentence
          ?.map((sentence) => correctionSentenceFromDto(sentence))
          .toList(),
    );
  }
}
