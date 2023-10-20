class Phrase {
  int? id;
  String cantonese;
  String english;

  Phrase({
    this.id,
    required this.cantonese,
    required this.english,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cantonese': cantonese,
      'english': english,
    };
  }

  factory Phrase.fromMap(Map<String, dynamic> map) {
    return Phrase(
      id: map['id'],
      cantonese: map['cantonese'],
      english: map['english'],
    );
  }
}