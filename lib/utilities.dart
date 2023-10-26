import 'package:flutter/material.dart';

const bool canToEng = true;

const Map<String, Color> palette = {
  'cantoneseGold': Color(0xFFFFD600),
  'dragonBoatGreen': Color(0xFF3FA443),
  'kowloonOrange': Color(0xFFFF9800),
  'dimSumRed': Color(0xFFD32F2F),
  'hongKongSkylineBlue': Color(0xFF00ACC1),
  'harborGray': Color(0xFFBDB6B6),
};

const inputTextStyle = InputDecoration(
  hintText: 'Type the translation',
  hintStyle: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
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
