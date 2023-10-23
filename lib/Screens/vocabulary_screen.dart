import 'package:flutter/material.dart';
import 'cancanto_screen.dart';
import 'package:canto/Components/NavigationButton.dart';
import 'package:canto/Database/phrases_database.dart';
import 'package:canto/Database/phrase.dart';
import 'add_edit_phrase.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'phrase_detail_page.dart';
import '../Components/phrase_card_widget.dart';

class VocabularyScreen extends StatefulWidget {

  static const String id = 'vocabulary_screen';

  @override
  _VocabularyScreenState createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  late List<Phrase> phrases;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshPhrases();
  }

  @override
  void dispose() {
    PhrasesDatabase.instance.close();

    super.dispose();
  }

  Future refreshPhrases() async {
    setState(() => isLoading = true);

    phrases = await PhrasesDatabase.instance.readAllNotes();

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
        ),
        body: Column(
          children: <Widget>[
            buildPhrases(),
            Text('Your Text'),
            NavigationButton(
              cantonese:'Back to quiz',
              onPressed: () {
                Navigator.pushNamed(context, CanCantoScreen.id);
                },
            ),
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


