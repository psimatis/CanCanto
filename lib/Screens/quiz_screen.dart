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
  Phrase quizPhrase = Phrase(
      cantonese: '', english: '', attempts: 0, successes: 0, comment: '');
  Phrase previousPhrase = Phrase(
      cantonese: '', english: '', attempts: 0, successes: 0, comment: '');
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildPreviousPhrase(),
                const SizedBox(height: 16),
                buildQuizPhrase(),
                const SizedBox(height: 16),
                TextField(
                  controller: userInput,
                  decoration: inputTextStyle,
                ),
                const SizedBox(height: 16),
                buildCheckButton(),
                const SizedBox(height: 10),
                buildResultMessage(),
                const SizedBox(height: 10),
                buildScores(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: buildVocabularyActionButton(context),
    );
  }

  FloatingActionButton buildVocabularyActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, VocabularyScreen.id);
      },
      backgroundColor: Colors.red,
      child: const Icon(
        Icons.library_books,
        color: Colors.white,
      ),
    );
  }

  Text buildScores() {
    return Text(
      'Success Rates: ${getRunSuccessRate()}% | ${quizPhrase.getSuccessRate()}%',
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }

  Text buildResultMessage() {
    return Text(
      resultMessage,
      style: TextStyle(
        fontSize: 32,
        color: resultMessage == 'Correct!' ? Colors.green : Colors.red,
      ),
    );
  }

  Text buildQuizPhrase() {
    return Text(
      getTranslationOrder(quizPhrase),
      style: const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text buildPreviousPhrase() {
    return Text(
      '${previousPhrase.cantonese} - ${previousPhrase.english}',
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }

  ElevatedButton buildCheckButton() {
    return ElevatedButton(
      onPressed: () {
        checkInput();
        getNewPhrase();
        previousPhrase = quizPhrase;
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
        minimumSize: Size(200, 50),
      ),
      child: const Text(
        'Check',
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    );
  }
}
