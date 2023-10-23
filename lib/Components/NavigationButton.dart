import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  NavigationButton({required this.cantonese, required this.onPressed});

  final String cantonese;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(cantonese),
      ),
    );
  }
}