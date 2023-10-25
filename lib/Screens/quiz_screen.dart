import 'package:flutter/material.dart';
import 'package:canto/Components/NavigationButton.dart';
import 'vocabulary_screen.dart';
import 'package:canto/constants.dart';
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
  Phrase quizPhrase = Phrase(cantonese: '', english: '');
  TextEditingController userInput = TextEditingController();
  String resultMessage = '';
  int attempts = 0;
  int correctAttempts = 0;
  bool order = canToEng;

  void initState() {
    super.initState();
    getNewPhrase();
  }

  String edit(String s) => s.trim().toLowerCase();

  String randomizeTranslation(Phrase p) {
    order = Random().nextDouble() > 0.5 ? canToEng : !canToEng;
    return order ? p.cantonese : p.english;
  }

  void checkInput() {
    String result = 'Correct!';
    attempts++;
    String translation = order ? edit(quizPhrase.english) : edit(quizPhrase.cantonese);

    if (edit(userInput.text) == translation)
      correctAttempts++;
    else
      result = 'Wrong!';

    setState(() {
      resultMessage = result;
      userInput.clear();
    });
  }

  String getSuccessRate() {
    double rate = correctAttempts / attempts * 100;
    return 'Success Rate: ${(rate).toStringAsFixed(0)}%';
  }

  void getNewPhrase() async {
    Phrase p = await PhrasesDatabase.instance.getRandomPhrase();
    setState(() {
      quizPhrase = p;
    });
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
              randomizeTranslation(quizPhrase),
              style: const TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            TextField(
              controller: userInput,
              decoration: inputTextStyle,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                checkInput();
                getNewPhrase();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Set the button's background color to red
              ),
              child: Text('Check'),
            ),
            SizedBox(height: 10),
            Text(
              resultMessage,
              style: TextStyle(
                fontSize: 22,
                color: resultMessage == 'Correct!' ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 10),
            Text(
              getSuccessRate(),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            NavigationButton(
              title: 'Vocabulary',
              onPressed: () {
                Navigator.pushNamed(context, VocabularyScreen.id);
              },
            )
          ],
        ),
      ),
    );
  }
}
