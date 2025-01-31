class CorrectionSentence {
  String originSentence;
  String correctSentence;
  String? correctionReason;
  String? nativeInterpretation;

  CorrectionSentence({
    required this.originSentence,
    required this.correctSentence,
    this.correctionReason,
    this.nativeInterpretation,
  });

  @override
  String toString() {
    return '''originSentence: $originSentence 
    correctSentence: $correctSentence
    correctionReason: $correctionReason
    nativeInterpretation: $nativeInterpretation''';
  }
}
