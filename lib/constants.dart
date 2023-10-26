import 'package:flutter/material.dart';

const bool canToEng = true;

const inputTextStyle = InputDecoration(
  labelText: 'Type the translation',
  labelStyle: TextStyle(color: Colors.red), // Change label color to red
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.red), // Set the underline color to red
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.red), // Set the focused underline color to red
  ),
);

class InfoText extends StatelessWidget {
  final String text;

  const InfoText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style:
      const TextStyle(color: Colors.white70, fontSize: 18),
    );
  }
}

class FieldDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.white70,
      thickness: 1,
    );
  }
}