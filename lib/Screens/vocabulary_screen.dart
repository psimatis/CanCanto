import 'package:flutter/material.dart';
import 'cancanto_screen.dart';
import 'package:canto/Components/NavigationButton.dart';

class VocabularyScreen extends StatelessWidget {

  static const String id = 'vocabulary_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary'),
      ),
      body:
        NavigationButton(
          title:'Back to quiz',
          onPressed: () {
            Navigator.pushNamed(context, CanCantoScreen.id);
            },
        )
    );
  }
}