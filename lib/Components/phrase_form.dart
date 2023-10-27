import 'package:flutter/material.dart';
import 'package:canto/utilities.dart';

class PhraseFormWidget extends StatelessWidget {
  final String? cantonese;
  final String? english;
  final String? comment;
  final ValueChanged<String> onChangedCantonese;
  final ValueChanged<String> onChangedEnglish;
  final ValueChanged<String> onChangedComment;

  const PhraseFormWidget({
    Key? key,
    this.cantonese = '',
    this.english = '',
    required this.onChangedCantonese,
    required this.onChangedEnglish,
    required this.onChangedComment,
    required int attempts,
    required int successes,
    this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildPhrase(),
              FieldDivider(),
              buildTranslation(),
              FieldDivider(),
              buildComment(),
              FieldDivider(),
            ],
          ),
        ),
      );

  Widget buildPhrase() => TextFormField(
        maxLines: 1,
        initialValue: cantonese,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: inputDecorator('Cantonese Phrase'),
        validator: (phrase) => validateInput(phrase, 'phrase'),
        onChanged: onChangedCantonese,
      );

  Widget buildTranslation() => TextFormField(
        maxLines: 1,
        initialValue: english,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: inputDecorator('English Translation'),
        validator: (translation) => validateInput(translation, 'translation'),
        onChanged: onChangedEnglish,
      );

  Widget buildComment() => TextFormField(
        maxLines: 5,
        initialValue: comment,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: inputDecorator('Comment'),
        onChanged: onChangedComment,
      );
}

InputDecoration inputDecorator(String hintText) {
  return InputDecoration(
    border: InputBorder.none,
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.white60),
  );
}

String? validateInput(String? value, String component) {
  if (value != null && value.isEmpty) {
    return 'The $component cannot be empty';
  }
  return null;
}
