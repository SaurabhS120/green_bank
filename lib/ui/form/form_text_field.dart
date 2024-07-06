import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget{
  final String labelText;
  final TextEditingController controller;
  final Widget Function(BuildContext context) onErrorBuild;
  const FormTextField({super.key, required this.labelText, required this.controller, required this.onErrorBuild});

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.only(bottom: 8.0),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         TextField(
           controller: widget.controller,
           decoration: InputDecoration(
             border: const OutlineInputBorder(),
             labelText: widget.labelText,
           ),
         ),
         widget.onErrorBuild(context),
       ],
     ),
   );
  }
}
class AppFormFieldErrorText extends StatelessWidget {
  final String errorText;
  const AppFormFieldErrorText({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      style: const TextStyle(color: Colors.red),
    );
  }
}