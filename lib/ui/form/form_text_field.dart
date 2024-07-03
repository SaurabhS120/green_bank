import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget{
  final String labelText;
  final TextEditingController controller;
  const FormTextField({super.key, required this.labelText, required this.controller});

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.only(bottom: 8.0),
     child: TextField(
       controller: widget.controller,
       decoration: InputDecoration(
         border: const OutlineInputBorder(),
         labelText: widget.labelText,
       ),
     ),
   );
  }
}