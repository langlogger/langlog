enum Emotion {
  /// 행복
  happiness('happiness', 'Happiness'),

  /// 슬픔
  sorrow('sorrow', 'Sorrow'),

  /// 좌절
  frustration('frustration', 'Frustration'),

  /// 불안
  anxiety('anxiety', 'Anxiety'),

  /// 평온
  serenity('serenity', 'Serenity'),

  /// 분노
  anger('anger', 'Anger'),

  /// 정의 안됨
  undefined('undefined', '');

  const Emotion(this.code, this.displayName);
  final String code;
  final String displayName;

  factory Emotion.getByCode(String code) {
    return Emotion.values.firstWhere((value) => value.code == code,
        orElse: () => Emotion.undefined);
  }
}
