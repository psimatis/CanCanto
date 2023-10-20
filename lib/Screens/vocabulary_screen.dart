import 'package:flutter/material.dart';

class VocabularyScreen extends StatelessWidget {

  static const String id = 'vocabulary_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary'),
      ),
      // body: VocabularyList(), // Create a VocabularyList widget to display phrases
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Navigate to the screen where the user can add a new phrase
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => AddPhraseScreen()));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}