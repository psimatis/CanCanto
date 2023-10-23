final String tablePhrases = 'phrases';

class PhraseFields {
  static final List<String> values = [id, cantonese, english];

  static final String id = '_id';
  static final String cantonese = 'cantonese';
  static final String english = 'english';
}

class Phrase {
  final int? id;
  final String cantonese;
  final String english;

  const Phrase({
    this.id,
    required this.cantonese,
    required this.english,
  });

  Phrase copy({
    int? id,
    String? cantonese,
    String? english,
  }) =>
      Phrase(
        id: id ?? this.id,
        cantonese: cantonese ?? this.cantonese,
        english: english ?? this.english,
      );

  static Phrase fromJson(Map<String, Object?> json) => Phrase(
    id: json[PhraseFields.id] as int?,
    cantonese: json[PhraseFields.cantonese] as String,
    english: json[PhraseFields.english] as String,
  );

  Map<String, Object?> toJson() => {
    PhraseFields.id: id,
    PhraseFields.cantonese: cantonese,
    PhraseFields.english: english,
  };
}