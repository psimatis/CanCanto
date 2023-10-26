import 'package:flutter/material.dart';

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
              const Row(
                children: [],
              ),
              buildPhrase(),
              const SizedBox(height: 8),
              buildTranslation(),
              const SizedBox(height: 16),
              buildComment(),
              const SizedBox(height: 16),
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
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Cantonese Phrase',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (phrase) => phrase != null && phrase.isEmpty
            ? 'The phrase cannot be empty'
            : null,
        onChanged: onChangedCantonese,
      );

  Widget buildTranslation() => TextFormField(
        maxLines: 5,
        initialValue: english,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'English translation',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (translation) => translation != null && translation.isEmpty
            ? 'The translation cannot be empty'
            : null,
        onChanged: onChangedEnglish,
      );

  Widget buildComment() => TextFormField(
    maxLines: 5,
    initialValue: comment,
    style: const TextStyle(color: Colors.white60, fontSize: 18),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Comment',
      hintStyle: TextStyle(color: Colors.white60),
    ),
    onChanged: onChangedComment,
  );
}
