import 'package:flutter/material.dart';

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