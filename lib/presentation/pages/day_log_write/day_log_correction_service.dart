import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:langlog/core/correction_result_changer.dart';
import 'package:langlog/domain/entity/correction_sentence.dart';

class CorrectionService {
  final String apiKey = dotenv.env['GPT_API_KEY']!;
  final String apiUrl = 'https://api.openai.com/v1/chat/completions';

  // 문장 교정
  Future<void> correctLog(
    String originText,
    Function(String, List<CorrectionSentence>) setCorrectionSentence,
  ) async {
    final dio = Dio();

    List<CorrectionSentence> correctionSentences = [];

    try {
      List<String> sentences = splitIntoSentences(originText);

      // 문장 단위로 교정 요청
      for (String sentence in sentences) {
        await getCorrectionResponse(
          dio,
          sentence,
          correctionSentences,
        );
      }

      final correctionResult =
          getCorrectionResult(originText, correctionSentences);

      // state에 교정 문장 등록
      setCorrectionSentence(correctionResult, correctionSentences);
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  // api로 문장 교정 요청
  Future<void> getCorrectionResponse(
    Dio dio,
    String sentence,
    List<CorrectionSentence> correctionSentences,
  ) async {
    final response = await dio.post(
      apiUrl,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
      ),
      data: json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'user', 'content': 'Correct this sentence: "$sentence"'}
        ],
        'max_tokens': 100,
      }),
    );

    if (response.statusCode == 200) {
      var correctedText =
          response.data['choices'][0]['message']['content'].toString();

      if (correctedText.startsWith("'") || correctedText.startsWith('"')) {
        correctedText = correctedText.substring(1, correctedText.length - 1);
      }

      if (sentence != correctedText) {
        correctionSentences.add(CorrectionSentence(
            originSentence: sentence, correctSentence: correctedText));
      }
    }
  }

  // 문장 단위로 끊기
  List<String> splitIntoSentences(String text) {
    final sentencePattern =
        RegExp(r'([^.?!\n]+(?:[.!?]|\n|$))'); // 문장부호 없이 마지막 문장도 포함
    return sentencePattern
        .allMatches(text)
        .map((match) => match.group(0)!.trim())
        .toList();
  }

  // api로 문장 교정 사유 요청
  Future<String> getCorrectionReason(CorrectionSentence sentence) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        apiUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $apiKey',
          },
        ),
        data: json.encode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'user',
              'content':
                  'Why was "${sentence.originSentence}" corrected to "${sentence.correctSentence}"? Please limit your explanation to 80 tokens. Respond in Korean.'
            }
          ],
          'max_tokens': 150,
        }),
      );

      // 응답 확인
      if (response.statusCode == 200) {
        var correctionReason =
            response.data['choices'][0]['message']['content'].toString();
        print("WHY? == $sentence");

        // 따옴표 제거
        // if (correctionReason.startsWith("'") ||
        //     correctionReason.startsWith('"')) {
        //   correctionReason =
        //       correctionReason.substring(1, correctionReason.length - 1);
        // }
        return correctionReason;
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }

    return "";
  }
}

final dayLogCorrectionServiceProvider =
    Provider<CorrectionService>((ref) => CorrectionService());
