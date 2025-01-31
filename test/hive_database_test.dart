// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:langlog/core/database_helper.dart';
// import 'package:langlog/data/dto/correction_sentence_dto.dart';
// import 'package:langlog/data/dto/day_log_dto.dart';
// import 'package:langlog/data/dto/log_contents_dto.dart';

// // Mock 클래스 생성
// class MockDatabaseHelper extends Mock implements DatabaseHelper {}

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   group('DatabaseHelper Tests', () {
//     late MockDatabaseHelper mockDatabaseHelper;

//     setUp(() {
//       mockDatabaseHelper = MockDatabaseHelper();
//     });

//     test('addDayLog', () async {
//       var dayLog = DayLog(
//         date: DateTime.now(),
//         native: LogContentsDto(title: '제목', contents: '내용'),
//         foreign: LogContentsDto(title: 'Title', contents: 'Content'),
//         correctionResult: 'Correction Result',
//         correctionSentence: [
//           CorrectionSentenceDto(
//             originSentence: 'Original',
//             correctSentence: 'Corrected',
//             correctionReason: 'Reason',
//             nativeInterpretation: 'Interpretation',
//           ),
//         ],
//       );

//       // add 메소드 모킹 (Future<void> 반환)
//       when(
//         mockDatabaseHelper.add<DayLog>(
//           'daylogBox',
//           dayLog.date.toIso8601String(),
//           dayLog,
//         ),
//       ).thenAnswer((_) async => Future.value());

//       // add 메소드 호출 (실제 데이터베이스에 추가되지 않음)
//       await mockDatabaseHelper.add<DayLog>(
//           'daylogBox', dayLog.date.toIso8601String(), dayLog);

//       // add 메소드가 호출되었는지 확인
//       verify(mockDatabaseHelper.add<DayLog>(
//               'daylogBox', dayLog.date.toIso8601String(), dayLog))
//           .called(1);
//     });
//   });
// }
