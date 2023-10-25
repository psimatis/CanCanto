import 'package:flutter/material.dart';
import 'Screens/quiz_screen.dart';
import 'Screens/vocabulary_screen.dart';
import 'Database/phrases_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final phrasesDatabase =
      PhrasesDatabase.instance; // Create an instance of the database handler
  await phrasesDatabase.database; // Initialize the database
  final isDatabaseEmptyOrNotCreated = await checkDatabaseStatus(
      phrasesDatabase); // Check if the database is empty or not created yet

  runApp(CanCantoApp(
    phrasesDatabase: phrasesDatabase,
    isDatabaseEmptyOrNotCreated: isDatabaseEmptyOrNotCreated,
  ));
}

Future<bool> checkDatabaseStatus(PhrasesDatabase phrasesDatabase) async {
  // Check if the database is empty or not created yet
  final allPhrases = await phrasesDatabase.readAllPhrases();
  return allPhrases.isEmpty;
}

class CanCantoApp extends StatelessWidget {
  final PhrasesDatabase phrasesDatabase;
  final bool isDatabaseEmptyOrNotCreated;

  CanCantoApp({
    required this.phrasesDatabase,
    required this.isDatabaseEmptyOrNotCreated,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: isDatabaseEmptyOrNotCreated
          ? VocabularyScreen
              .id // Start with VocabularyScreen if the database is empty
          : QuizScreen.id, // Start with QuizScreen if the database is not empty
      routes: {
        QuizScreen.id: (context) =>
            QuizScreen(phrasesDatabase: phrasesDatabase),
        VocabularyScreen.id: (context) =>
            VocabularyScreen(phrasesDatabase: phrasesDatabase),
      },
    );
  }
}
