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
  String searchQuery = '';
  bool isLoading = false;
  int totalPhraseCount = 0;
  bool canLeaveScreen = false;

  @override
  void initState() {
    super.initState();
    phrases = [];
    refreshPhrases();
  }

  Future refreshPhrases() async {
    setState(() => isLoading = true);
    phrases = await PhrasesDatabase.instance.readAllPhrases();
    totalPhraseCount = phrases.length;
    canLeaveScreen = totalPhraseCount > 0 ? true : false;
    setState(() => isLoading = false);
  }

  List<Phrase> filterPhrases() {
    if (searchQuery.isNotEmpty) {
      return phrases.where((phrase) {
        final query = edit(searchQuery);
        return edit(phrase.cantonese).contains(query) ||
            edit(phrase.english).contains(query);
      }).toList();
    }
    return phrases;
  }

  Future<void> _exportDatabase() async {
    await widget.phrasesDatabase.exportDatabase();
  }

  @override
  Widget build(BuildContext context) {
    final filteredPhrases = filterPhrases();
    return Scaffold(
      appBar: AppBar(
        title: Text('Vocabulary ($totalPhraseCount phrases)'),
        leading: canLeaveScreen
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushNamed(context, QuizScreen.id);
                },
              )
            : const Text(''),
        actions: <Widget>[
          // Add Export Database button to the AppBar
          IconButton(
            icon: const Icon(Icons.cloud_download),
            onPressed: () => _exportDatabase(),
          ),
        ],
      ),
      body: canLeaveScreen
          ? Column(children: [
              buildSearchBar(),
              buildVocabularyList(filteredPhrases),
            ])
          : const Center(
              child: InfoText(text: 'Go ahead and add some phrases')),
      floatingActionButton: buildAddPhraseActionButton(context),
    );
  }

  FloatingActionButton buildAddPhraseActionButton(BuildContext context) {
    return FloatingActionButton(
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
    );
  }

  Expanded buildVocabularyList(List<Phrase> filteredPhrases) {
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          itemCount: filteredPhrases.length,
          itemBuilder: (context, index) {
            final phrase = filteredPhrases[index];
            final color = palette.values.elementAt(index % palette.length);
            return GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PhraseDetailPage(phraseId: phrase.id!),
                ));
                refreshPhrases();
              },
              child:
                  PhraseCardWidget(phrase: phrase, index: index, color: color),
            );
          },
        ),
      ),
    );
  }

  Padding buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: const InputDecoration(
          hintText: 'Search for a phrase',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
