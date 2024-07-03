import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget{
  final String labelText;
  const FormTextField({super.key, required this.labelText});

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.only(bottom: 8.0),
     child: TextField(
       decoration: InputDecoration(
         border: const OutlineInputBorder(),
         labelText: widget.labelText,
       ),
     ),
   );
  }
}