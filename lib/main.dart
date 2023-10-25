import 'package:flutter/material.dart';
import 'Screens/quiz_screen.dart';
import 'Screens/vocabulary_screen.dart';
import 'Database/phrases_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final phrasesDatabase = PhrasesDatabase.instance;
  await phrasesDatabase.database;
  final databaseStatus = await phrasesDatabase.checkStatus(phrasesDatabase);

  runApp(CanCantoApp(
    phrasesDatabase: phrasesDatabase,
    emptyDatabase: databaseStatus,
  ));
}

class CanCantoApp extends StatelessWidget {
  final PhrasesDatabase phrasesDatabase;
  final bool emptyDatabase;

  CanCantoApp({required this.phrasesDatabase, required this.emptyDatabase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: emptyDatabase ? VocabularyScreen.id : QuizScreen.id,
      routes: {
        QuizScreen.id: (context) =>
            QuizScreen(phrasesDatabase: phrasesDatabase),
        VocabularyScreen.id: (context) =>
            VocabularyScreen(phrasesDatabase: phrasesDatabase),
      },
    );
  }
}
