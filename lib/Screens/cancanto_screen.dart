import 'package:flutter/material.dart';
import 'package:canto/Components/NavigationButton.dart';
import 'vocabulary_screen.dart';
import 'package:canto/constants.dart';
import 'package:canto/Database/phrases_database.dart';
import 'package:canto/Database/phrase.dart';

class CanCantoScreen extends StatefulWidget {

  static const String id = 'cancanto_screen';

  @override
  _CanCantoScreenState createState() => _CanCantoScreenState();
}

class _CanCantoScreenState extends State<CanCantoScreen> {
  late Phrase randomPhrase = Phrase(cantonese: 'a', english: 'b');
  TextEditingController userInputController = TextEditingController();
  String resultMessage = '';
  int attempts = 0;
  int correctAttempts = 0;

  void checkInput() async {
    String userInput = userInputController.text;
    String result = '';

    if (userInput == randomPhrase.english) {
      result = 'Correct!';
      correctAttempts++;
    }
    else result = 'Wrong!';
    Phrase newPhrase = await PhrasesDatabase.instance.getRandomPhrase();
    setState(() {
      resultMessage = result;
      randomPhrase = newPhrase;
      userInputController.clear();
    });
    attempts++;
  }

  String getSuccessRate(){
    double rate = correctAttempts/attempts*100;
    return 'Success Rate: ${(rate).toStringAsFixed(2)}%';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Can Canto'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(randomPhrase.cantonese,
                style: const TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextField(
                controller: userInputController,
                decoration: inputTextStyle,
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: checkInput,
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
              Text(getSuccessRate(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              NavigationButton(
                title:'Go to vocabulary',
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