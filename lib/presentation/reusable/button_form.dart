import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;

  FormButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
      child: Text(text),
    );
  }
}
