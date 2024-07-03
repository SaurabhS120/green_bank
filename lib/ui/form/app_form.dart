import 'package:flutter/material.dart';
export 'form_button.dart';
export 'form_text_field.dart';
class AppForm extends StatelessWidget {
  final List<Widget> children;

  const AppForm({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8,left: 8,right: 8),
      child: Column(
        children: children,
      ),
    );
  }
}
