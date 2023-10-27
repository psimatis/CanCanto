import 'package:flutter/material.dart';
import '../Database/phrases_database.dart';
import '../Database/phrase.dart';
import '../Components/phrase_form.dart';

class AddEditPhrasePage extends StatefulWidget {
  final Phrase? phrase;

  const AddEditPhrasePage({
    Key? key,
    this.phrase,
  }) : super(key: key);

  @override
  State<AddEditPhrasePage> createState() => _AddEditPhrasePageState();
}

class _AddEditPhrasePageState extends State<AddEditPhrasePage> {
  final _formKey = GlobalKey<FormState>();
  late String cantonese;
  late String english;
  late int attempts;
  late int successes;
  late String comment;

  @override
  void initState() {
    super.initState();
    cantonese = widget.phrase?.cantonese ?? '';
    english = widget.phrase?.english ?? '';
    attempts = widget.phrase?.attempts ?? 0;
    successes = widget.phrase?.successes ?? 0;
    comment = widget.phrase?.comment ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildSaveButton()],
        ),
        body: Form(
          key: _formKey,
          child: PhraseFormWidget(
            cantonese: cantonese,
            english: english,
            attempts: attempts,
            successes: successes,
            comment: comment,
            onChangedCantonese: (cantonese) =>
                setState(() => this.cantonese = cantonese),
            onChangedEnglish: (english) =>
                setState(() => this.english = english),
            onChangedComment: (comment) =>
                setState(() => this.comment = comment),
          ),
        ),
      );

  Widget buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.red,
        ),
        onPressed: addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final isUpdating = widget.phrase != null;
      isUpdating ? await updateNote() : await addNote();
      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.phrase!.copy(
      cantonese: cantonese,
      english: english,
      attempts: attempts,
      successes: successes,
      comment: comment,
    );
    await PhrasesDatabase.instance.update(note);
  }

  Future addNote() async {
    final phrase = Phrase(
      cantonese: cantonese,
      english: english,
      attempts: attempts,
      successes: successes,
      comment: comment,
    );
    await PhrasesDatabase.instance.create(phrase);
  }
}
