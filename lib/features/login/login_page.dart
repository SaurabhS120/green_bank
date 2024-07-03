import 'package:flutter/material.dart';
import 'package:green_bank/ui/form/app_form.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Colors.green,
      ),
      body: AppForm(
        children: [
          const FormTextField(
            labelText: 'Username',
          ),
          const FormTextField(
            labelText: 'Password',
          ),
          FormButton(
            text: 'Login',
            onPressed: () {
            },
          ),
        ],
      )
    );
  }
}