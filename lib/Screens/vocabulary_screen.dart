import 'package:flutter/material.dart';
import 'package:canto/Database/phrases_database.dart';
import 'package:canto/Database/phrase.dart';
import 'add_edit_phrase_screen.dart';
import 'phrase_detail_screen.dart';
import '../Components/phrase_card.dart';
import 'quiz_screen.dart';
import 'package:canto/utilities.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabulary'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, QuizScreen.id);
          },
        ),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: phrases.length,
          itemBuilder: (context, index) {
            final phrase = phrases[index];
            final color = palette.values.elementAt(index%palette.length);
            return GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PhraseDetailPage(phraseId: phrase.id!),
                ));
                refreshPhrases();
              },
              child: PhraseCardWidget(phrase: phrase, index: index, color: color),

            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddEditPhrasePage(),
            ),
          );
          refreshPhrases();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
