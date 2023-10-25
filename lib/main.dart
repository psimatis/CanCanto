import 'package:flutter/material.dart';
import 'Screens/quiz_screen.dart';
import 'Screens/vocabulary_screen.dart';

void main() => runApp(CanCantoApp());

class CanCantoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: QuizScreen.id,
      routes: {
        QuizScreen.id: (context) => QuizScreen(),
        VocabularyScreen.id: (context) => VocabularyScreen(),
      },
    );
  }
}