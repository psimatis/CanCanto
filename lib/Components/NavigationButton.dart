import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  NavigationButton({required this.title, required this.onPressed});

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(title),
      ),
    );
  }
}