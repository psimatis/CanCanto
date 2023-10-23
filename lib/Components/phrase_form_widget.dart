import 'package:flutter/material.dart';

class PhraseFormWidget extends StatelessWidget {
  final String? cantonese;
  final String? english;
  final ValueChanged<String> onChangedCantonese;
  final ValueChanged<String> onChangedEnglish;

  const PhraseFormWidget({
    Key? key,
    this.cantonese = '',
    this.english = '',
    required this.onChangedCantonese,
    required this.onChangedEnglish,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
            ],
          ),
          buildTitle(),
          const SizedBox(height: 8),
          buildDescription(),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  Widget buildTitle() => TextFormField(
    maxLines: 1,
    initialValue: cantonese,
    style: const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Title',
      hintStyle: TextStyle(color: Colors.white70),
    ),
    validator: (title) =>
    title != null && title.isEmpty ? 'The title cannot be empty' : null,
    onChanged: onChangedCantonese,
  );

  Widget buildDescription() => TextFormField(
    maxLines: 5,
    initialValue: english,
    style: const TextStyle(color: Colors.white60, fontSize: 18),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Type something...',
      hintStyle: TextStyle(color: Colors.white60),
    ),
    validator: (cantonese) => cantonese != null && cantonese.isEmpty
        ? 'The description cannot be empty'
        : null,
    onChanged: onChangedEnglish,
  );
}