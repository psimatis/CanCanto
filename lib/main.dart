import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(CanCantoApp());

class CanCantoApp extends StatefulWidget {
  @override
  _CanCantoAppState createState() => _CanCantoAppState();
}

class _CanCantoAppState extends State<CanCantoApp> {
  String randomPhrase = generateRandomPhrase();
  TextEditingController userInputController = TextEditingController();
  String resultMessage = '';

  static String generateRandomPhrase() {
    List<String> phrases = [
      "Flutter is awesome!",
      "Dart is a great language.",
      "Can Canto is fun to use.",
      "OpenAI GPT-3 is amazing!",
    ];
    Random random = Random();
    int randomIndex = random.nextInt(phrases.length);
    return phrases[randomIndex];
  }

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
    // Generate a new random phrase
    setState(() {
      randomPhrase = generateRandomPhrase();
      userInputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
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
                decoration: const InputDecoration(
                  labelText: 'Enter the phrase',
                  labelStyle: TextStyle(color: Colors.red), // Change label color to red
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red), // Set the underline color to red
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red), // Set the focused underline color to red
                  ),
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}