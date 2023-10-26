import 'package:flutter/material.dart';
import 'vocabulary_screen.dart';
import 'package:canto/utilities.dart';
import 'package:canto/Database/phrases_database.dart';
import 'package:canto/Database/phrase.dart';
import 'dart:math';

class QuizScreen extends StatefulWidget {
  final PhrasesDatabase phrasesDatabase;
  static const String id = 'cancanto_screen';

  QuizScreen({required this.phrasesDatabase});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Phrase quizPhrase =
      Phrase(cantonese: '', english: '', attempts: 0, successes: 0);
  Phrase previousPhrase =
      Phrase(cantonese: '', english: '', attempts: 0, successes: 0);
  TextEditingController userInput = TextEditingController();
  String resultMessage = '';
  int attempts = 0;
  int correctAttempts = 0;
  bool order = canToEng;

  @override
  void initState() {
    super.initState();
    getNewPhrase();
  }

  void getNewPhrase() async {
    Phrase p = await PhrasesDatabase.instance.getRandomPhrase();
    setState(() {
      quizPhrase = p;
    });
  }

  String edit(String s) => s.trim().toLowerCase();

  String getTranslationOrder(Phrase p) {
    order = Random().nextDouble() > 0.5 ? canToEng : !canToEng;
    return order ? p.cantonese : p.english;
  }

  void checkInput() {
    String result = 'Correct!';
    attempts++;
    Phrase updatedPhrase = quizPhrase.copy(attempts: quizPhrase.attempts + 1);

    String translation =
        order ? edit(quizPhrase.english) : edit(quizPhrase.cantonese);

    if (edit(userInput.text) == translation) {
      correctAttempts++;
      updatedPhrase =
          updatedPhrase.copy(successes: updatedPhrase.successes + 1);
    } else {
      result = 'Wrong!';
    }

    PhrasesDatabase.instance.update(updatedPhrase);
    setState(() {
      resultMessage = result;
      userInput.clear();
    });
  }

  int getRunSuccessRate() {
    double rate = correctAttempts / attempts * 100;
    return rate.isNaN ? 0 : rate.round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Can Canto'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${previousPhrase.cantonese} - ${previousPhrase.english}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white38,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              getTranslationOrder(quizPhrase),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: userInput,
              decoration: inputTextStyle,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                checkInput();
                getNewPhrase();
                previousPhrase = quizPhrase;
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Set the button's background color to red
              ),
              child: const Text(
                'Check',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              resultMessage,
              style: TextStyle(
                fontSize: 30,
                color: resultMessage == 'Correct!' ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Success Rates: ${getRunSuccessRate()}% | ${quizPhrase.getSuccessRate()}%',
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, VocabularyScreen.id);
        },
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.library_books,
          color: Colors.white,
        ),
      ),
    );
  }
}
