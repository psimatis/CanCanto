import 'package:flutter/material.dart';
import '../Database/phrases_database.dart';
import '../Database/phrase.dart';
import './add_edit_phrase_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:canto/utilities.dart';

class PhraseDetailPage extends StatefulWidget {
  final int phraseId;

  const PhraseDetailPage({
    Key? key,
    required this.phraseId,
  }) : super(key: key);

  @override
  State<PhraseDetailPage> createState() => _PhraseDetailPageState();
}

class _PhraseDetailPageState extends State<PhraseDetailPage> {
  late Phrase phrase;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshPhrase();
  }

  Future refreshPhrase() async {
    setState(() => isLoading = true);
    phrase = await PhrasesDatabase.instance.readPhrase(widget.phraseId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildPhrase(),
                    FieldDivider(),
                    InfoText(text: 'Translation: ${phrase.english}'),
                    FieldDivider(),
                    InfoText(text: 'Comment: ${phrase.comment}'),
                    FieldDivider(),
                    buildStats(),
                  ],
                ),
              ),
      );

  Row buildStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InfoText(
            text: 'Successes/Attempts: ${phrase.successes}/${phrase.attempts}'),
        const SizedBox(width: 45),
        CircularPercentIndicator(
          radius: 40.0,
          lineWidth: 8.0,
          percent: phrase.getSuccessRate() / 100,
          center: Text('${phrase.getSuccessRate()}%'),
          backgroundColor: Colors.transparent,
          animation: true,
          linearGradient: Gradients.hotLinear,
          footer: InfoText(text: 'Rate'),
        ),
      ],
    );
  }

  Text buildPhrase() {
    return Text(
      phrase.cantonese,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        height: 2,
      ),
    );
  }

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditPhrasePage(phrase: phrase),
        ));
        refreshPhrase();
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          await PhrasesDatabase.instance.delete(widget.phraseId);
          Navigator.of(context).pop();
        },
      );
}
