import 'package:flutter/material.dart';

class VocabularyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the list of phrases here and include edit and delete functionality
    return ListView.builder(
      itemCount: phrases.length, // Replace 'phrases' with your list of phrases
      itemBuilder: (context, index) {
        final phrase = phrases[index];
        return ListTile(
          title: Text(phrase),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Implement edit functionality for the selected phrase
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Implement delete functionality for the selected phrase
                },
              ),
            ],
          ),
        );
      },
    );
  }
}