import 'package:flutter/material.dart';
import 'package:canto/Components/NavigationButton.dart';
import 'vocabulary_screen.dart';
import 'package:canto/constants.dart';

class CanCantoScreen extends StatefulWidget {

  static const String id = 'cancanto_screen';

  @override
  _CanCantoScreenState createState() => _CanCantoScreenState();
}

class _CanCantoScreenState extends State<CanCantoScreen> {
  String randomPhrase = VocabularyScreen.generateRandomPhrase();
  TextEditingController userInputController = TextEditingController();
  String resultMessage = '';
  int attempts = 0;
  int correctAttempts = 0;

  void checkInput() {
    String userInput = userInputController.text;
    if (userInput == randomPhrase) {
      setState(() {
        resultMessage = 'Correct!';
        correctAttempts++;
      });
    } else {
      setState(() {
        resultMessage = 'Wrong!';
      });
    }
    setState(() {
      randomPhrase = VocabularyScreen.generateRandomPhrase();
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
              Text(randomPhrase,
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