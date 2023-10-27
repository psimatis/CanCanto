import 'package:flutter/material.dart';
import '../Database/phrase.dart';

class PhraseCardWidget extends StatelessWidget {
  const PhraseCardWidget({
    Key? key,
    required this.phrase,
    required this.index,
    required this.color,
  }) : super(key: key);

  final Phrase phrase;
  final int index;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    const height = 50.0;

    return Card(
      color: color,
      child: Container(
        constraints: const BoxConstraints(minHeight: height),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              '${phrase.cantonese} - ${phrase.english} - ${phrase.getSuccessRate()}%',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
