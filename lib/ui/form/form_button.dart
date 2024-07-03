import 'package:flutter/material.dart';

class FormButton extends StatelessWidget{
  final String text;
  final VoidCallback onPressed;
  final double width;
  const FormButton({super.key, required this.text, required this.onPressed, this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        height: 48,
        minWidth: width,
        child: Text(text)
      ),
    );
  }
}