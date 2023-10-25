import 'package:flutter/material.dart';
import 'package:canto/Components/NavigationButton.dart';
import 'vocabulary_screen.dart';
import 'package:canto/constants.dart';
import 'package:canto/Database/phrases_database.dart';
import 'package:canto/Database/phrase.dart';

class QuizScreen extends StatefulWidget {
  static const String id = 'cancanto_screen';

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Phrase randomPhrase = Phrase(cantonese: '', english: '');
  TextEditingController userInput = TextEditingController();
  String resultMessage = '';
  int attempts = 0;
  int correctAttempts = 0;

  void initState() {
    super.initState();
    getNewPhrase(); // TODO: If the DB is empty this gives an error.
  }

  String edit(String s) => s.trim().toLowerCase();

  void checkInput() {
    String result = 'Correct!';
    attempts++;

    if (edit(userInput.text) == edit(randomPhrase.english))
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
      randomPhrase = p;
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
              randomPhrase.cantonese,
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
