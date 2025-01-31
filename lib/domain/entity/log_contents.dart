class LogContents {
  String title;
  String contents;

  LogContents({
    required this.title,
    required this.contents,
  });

  @override
  String toString() {
    return '''title: $title
  content: $contents''';
  }
}
