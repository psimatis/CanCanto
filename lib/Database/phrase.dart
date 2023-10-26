final String tablePhrases = 'phrases';

class PhraseFields {
  static final List<String> values = [
    id,
    cantonese,
    english,
    attempts,
    successes,
    comment
  ];

  static final String id = '_id';
  static final String cantonese = 'cantonese';
  static final String english = 'english';
  static final String attempts = 'attempts';
  static final String successes = 'successes';
  static final String comment = 'comment';
}

class Phrase {
  final int? id;
  final String cantonese;
  final String english;
  final int attempts;
  final int successes;
  final String comment;

  const Phrase({
    this.id,
    required this.cantonese,
    required this.english,
    required this.attempts,
    required this.successes,
    required this.comment,
  });

  int getSuccessRate() {
    double rate = successes / attempts * 100;
    return rate.isNaN ? 0 : rate.round();
  }

  Phrase copy({
    int? id,
    String? cantonese,
    String? english,
    int? attempts,
    int? successes,
    String? comment,
  }) =>
      Phrase(
        id: id ?? this.id,
        cantonese: cantonese ?? this.cantonese,
        english: english ?? this.english,
        attempts: attempts ?? this.attempts,
        successes: successes ?? this.successes,
        comment: comment ?? this.comment,
      );

  static Phrase fromJson(Map<String, Object?> json) => Phrase(
        id: json[PhraseFields.id] as int?,
        cantonese: json[PhraseFields.cantonese] as String,
        english: json[PhraseFields.english] as String,
        attempts: json[PhraseFields.attempts] as int,
        successes: json[PhraseFields.successes] as int,
        comment: json[PhraseFields.comment] as String,
      );

  Map<String, Object?> toJson() => {
        PhraseFields.id: id,
        PhraseFields.cantonese: cantonese,
        PhraseFields.english: english,
        PhraseFields.attempts: attempts,
        PhraseFields.successes: successes,
        PhraseFields.comment: comment,
      };
}
