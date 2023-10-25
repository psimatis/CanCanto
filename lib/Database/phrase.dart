final String tablePhrases = 'phrases';

class PhraseFields {
  static final List<String> values = [id, cantonese, english, attempts, successes];

  static final String id = '_id';
  static final String cantonese = 'cantonese';
  static final String english = 'english';
  static final String attempts = 'attempts';
  static final String successes = 'successes';
}

class Phrase {
  final int? id;
  final String cantonese;
  final String english;
  final int attempts;
  final int successes;

  const Phrase({
    this.id,
    required this.cantonese,
    required this.english,
    required this.attempts,
    required this.successes,
  });

  Phrase copy({
    int? id,
    String? cantonese,
    String? english,
    int? attempts,
    int? successes,
  }) =>
      Phrase(
        id: id ?? this.id,
        cantonese: cantonese ?? this.cantonese,
        english: english ?? this.english,
        attempts: attempts ?? this.attempts,
        successes: successes ?? this.successes,
      );

  static Phrase fromJson(Map<String, Object?> json) => Phrase(
        id: json[PhraseFields.id] as int?,
        cantonese: json[PhraseFields.cantonese] as String,
        english: json[PhraseFields.english] as String,
        attempts: json[PhraseFields.attempts] as int,
        successes: json[PhraseFields.successes] as int,
      );

  Map<String, Object?> toJson() => {
        PhraseFields.id: id,
        PhraseFields.cantonese: cantonese,
        PhraseFields.english: english,
        PhraseFields.attempts: attempts,
        PhraseFields.successes: successes,
      };
}
