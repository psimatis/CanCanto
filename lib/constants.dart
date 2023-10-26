import 'package:flutter/material.dart';

const bool canToEng = true;

const inputTextStyle = InputDecoration(
  hintText: 'Type the translation',
  hintStyle: TextStyle(color: Colors.red),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
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
    return Text(
      text,
      style: const TextStyle(color: Colors.white70, fontSize: 18),
    );
  }
}

class FieldDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.white70,
      thickness: 1,
    );
  }
}
