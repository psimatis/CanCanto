import 'package:flutter/material.dart';
import 'package:canto/Database/phrases_database.dart';
import 'package:canto/Database/phrase.dart';
import 'add_edit_phrase_screen.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'phrase_detail_screen.dart';
import '../Components/phrase_card_widget.dart';
import 'quiz_screen.dart';

class VocabularyScreen extends StatefulWidget {
  final PhrasesDatabase phrasesDatabase;
  static const String id = 'vocabulary_screen';

  VocabularyScreen({required this.phrasesDatabase});

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  late List<Phrase> phrases;
  bool isLoading = false; // TODO: See if I can remove this

  @override
  void initState() {
    super.initState();
    phrases = [];
    refreshPhrases();
  }

  Future refreshPhrases() async {
    setState(() => isLoading = true);
    phrases = await PhrasesDatabase.instance.readAllPhrases();
    setState(() => isLoading = false);
  }

  Widget buildPhrases() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        phrases.length,
            (index) {
          final phrase = phrases[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PhraseDetailPage(phraseId: phrase.id!),
                ));
                refreshPhrases();
              },
              child: PhraseCardWidget(phrase: phrase, index: index),
            ),
          );
        },
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        AppBar(
          title: const Text('Vocabulary'),
          actions: <Widget>[
            // Add an IconButton for navigation to QuizScreen
            IconButton(
              icon: Icon(Icons.arrow_forward), // Use a suitable icon
              onPressed: () {
                Navigator.pushNamed(context, QuizScreen.id);
              },
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            buildPhrases(),
          ],
        ),

        floatingActionButton:
          FloatingActionButton(
              child:
              Icon(Icons.add),
              onPressed: () async {
                await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddEditPhrasePage())
                );
                refreshPhrases();
              }
              ),
    );
  }
}


