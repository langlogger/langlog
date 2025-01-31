import 'package:langlog/domain/entity/emotion.dart';
import 'package:langlog/domain/entity/correction_sentence.dart';
import 'package:langlog/domain/entity/log_contents.dart';

class DayLog {
  late String keyDate;
  String date;
  Emotion emotion;
  LogContents? native;
  LogContents? foreign;
  String? correctionResult;
  List<CorrectionSentence>? correctionSentence;

  DayLog({
    required this.date,
    required this.emotion,
    required this.native,
    required this.foreign,
    required this.correctionResult,
    required this.correctionSentence,
  }) {
    // date 앞 10자리 추출.
    // 로컬 데이터베이스에서 key 값으로 사용.
    keyDate = date.substring(0, 10);
  }

  @override
  String toString() {
    return '''
keyDate: $keyDate,
date: $date, 
emotion: ${emotion.code}, 
native: {
  ${native?.toString()}
},
foreign: {
  ${foreign?.toString()}
},
correctionResult: $correctionResult,
correctionSentence: ${correctionSentence?.length},
''';
  }
}
