import 'package:flutter/material.dart';

List<List<TextSpan>> correctionDiffCheck(
  String original,
  String modified,
) {
  List<String> originalWords = original.split(' ');
  List<String> modifiedWords = modified.split(' ');

  List<TextSpan> originalSpans = [];
  List<TextSpan> modifiedSpans = [];

  Set<String> deletedWords = {};
  Set<String> insertedWords = {};
  Set<String> reorderedWords = {};

  // 원본에서 삭제된 단어 찾기
  getRemovedWords(
    originalWords,
    modifiedWords,
    deletedWords,
  );

  // 수정된 문장에서 추가된 단어 찾기
  getAddedWords(
    originalWords,
    modifiedWords,
    insertedWords,
  );

  List<String> filteredOriginal =
      originalWords.where((word) => !deletedWords.contains(word)).toList();
  List<String> filteredModified =
      modifiedWords.where((word) => !insertedWords.contains(word)).toList();

  // 두 리스트의 길이가 다를 경우, 짧은 리스트의 길이에 맞춰 반복
  int minLength = filteredOriginal.length < filteredModified.length
      ? filteredOriginal.length
      : filteredModified.length;

  // 두 리스트를 비교하며 순서 변경된 단어를 찾기
  getOrderedWords(
    filteredOriginal,
    filteredModified,
    reorderedWords,
  );

  // 원본에서 삭제된 부분을 강조
  highlightOriginText(
    originalWords,
    deletedWords,
    originalSpans,
    reorderedWords,
  );

  // 수정본에서 추가된 부분을 강조
  highlightCorrectedText(
    modifiedWords,
    insertedWords,
    modifiedSpans,
    reorderedWords,
  );

  return [originalSpans, modifiedSpans];
}

// 수정본에서 추가된 부분을 강조
void highlightCorrectedText(
    List<String> modifiedWords,
    Set<String> insertedWords,
    List<TextSpan> modifiedSpans,
    Set<String> reorderedWords) {
  for (var word in modifiedWords) {
    if (insertedWords.contains(word)) {
      modifiedSpans.add(TextSpan(
        text: word + ' ',
        style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
      ));
    } else if (reorderedWords.contains(word)) {
      modifiedSpans.add(TextSpan(
        text: word + ' ',
        style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
      ));
    } else {
      modifiedSpans.add(
          TextSpan(text: word + ' ', style: TextStyle(color: Colors.black)));
    }
  }
}

// 원본에서 삭제된 부분을 강조
void highlightOriginText(
  List<String> originalWords,
  Set<String> deletedWords,
  List<TextSpan> originalSpans,
  Set<String> reorderedWords,
) {
  for (var word in originalWords) {
    if (deletedWords.contains(word)) {
      originalSpans.add(TextSpan(
        text: word + ' ',
        style: TextStyle(
            decoration: TextDecoration.lineThrough, color: Colors.red),
      ));
    } else if (reorderedWords.contains(word)) {
      originalSpans.add(TextSpan(
        text: word + ' ',
        style: TextStyle(color: Colors.blue, fontStyle: FontStyle.italic),
      ));
    } else {
      originalSpans.add(
          TextSpan(text: word + ' ', style: TextStyle(color: Colors.black)));
    }
  }
}

void getOrderedWords(
  List<String> filteredOriginal,
  List<String> filteredModified,
  Set<String> reorderedWords,
) {
  int originalIndex = 0;
  int modifiedIndex = 0;

  while (originalIndex < filteredOriginal.length &&
      modifiedIndex < filteredModified.length) {
    if (filteredOriginal[originalIndex] != filteredModified[modifiedIndex]) {
      reorderedWords.add(filteredModified[modifiedIndex]);
      modifiedIndex++;
    } else {
      originalIndex++;
      modifiedIndex++;
    }
  }

  // filteredModified가 더 길다면 남은 단어들도 추가
  while (modifiedIndex < filteredModified.length) {
    reorderedWords.add(filteredModified[modifiedIndex]);
    modifiedIndex++;
  }
}

void getAddedWords(
  List<String> originalWords,
  List<String> modifiedWords,
  Set<String> insertedWords,
) {
  for (var word in modifiedWords) {
    if (!originalWords.contains(word)) {
      insertedWords.add(word);
    }
  }
}

void getRemovedWords(
  List<String> originalWords,
  List<String> modifiedWords,
  Set<String> deletedWords,
) {
  for (var word in originalWords) {
    if (!modifiedWords.contains(word)) {
      deletedWords.add(word);
    }
  }
}
