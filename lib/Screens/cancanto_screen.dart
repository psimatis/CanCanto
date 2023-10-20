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

  void checkInput() {
    String userInput = userInputController.text;
    if (userInput == randomPhrase) {
      setState(() {
        resultMessage = 'Correct!';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Can Canto'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                randomPhrase,
                style: TextStyle(fontSize: 24),
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
                  fontSize: 18,
                  color: resultMessage == 'Correct!' ? Colors.green : Colors.red,
                ),
              ),
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