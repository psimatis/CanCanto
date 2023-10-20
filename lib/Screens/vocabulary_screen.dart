import 'package:flutter/material.dart';
import 'cancanto_screen.dart';
import 'package:canto/Components/NavigationButton.dart';
import 'dart:math';
import 'package:canto/Database/database_helper.dart';
import 'package:canto/Database/phrase.dart';

class VocabularyScreen extends StatefulWidget {

  static const String id = 'vocabulary_screen';

  static String generateRandomPhrase() {
    List<String> phrases = [
      "Flutter is awesome!",
      "Dart is a great language.",
      "Can Canto is fun to use.",
      "OpenAI GPT-3 is amazing!",
    ];
    Random random = Random();
    int randomIndex = random.nextInt(phrases.length);
    return phrases[randomIndex];
  }

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        AppBar(
          title: const Text('Vocabulary'),
        ),
        body:
        NavigationButton(
          title:'Back to quiz',
          onPressed: () {
            Navigator.pushNamed(context, CanCantoScreen.id);
          },
        )
    );
  }
}