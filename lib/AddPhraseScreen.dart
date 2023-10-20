import 'package:flutter/material.dart';

class AddPhraseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the screen to add new phrases here
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Phrase'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add text input and a button to add a new phrase
            Text('Add a new phrase:'),
            // Implement text input for the new phrase
            ElevatedButton(
              onPressed: () {
                // Implement code to add the new phrase to the list
                // You'll need to navigate back to the Vocabulary screen
                Navigator.pop(context);
              },
              child: Text('Add Phrase'),
            ),
          ],
        ),
      ),
    );
  }
}