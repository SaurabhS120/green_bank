import 'package:flutter/material.dart';
import 'package:green_bank/features/login/login_bloc.dart';
import 'package:green_bank/ui/form/app_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
        backgroundColor: Colors.green,
      ),
      body: BlocConsumer<LoginBloc,LoginState>(
        builder: (BuildContext context, state) {
          switch(state){
            case LoginLoading state:
              return const Center(child: CircularProgressIndicator());
            default:
              return AppForm(
                children: [
                  FormTextField(
                    labelText: 'Username',
                    controller: context.read<LoginBloc>().usernameController,
                  ),
                  FormTextField(
                    labelText: 'Password',
                    controller: context.read<LoginBloc>().passwordController,
                  ),
                  FormButton(
                    text: 'Login',
                    onPressed:context.read<LoginBloc>().login,
                  ),
                ],
              );
          }
        },
        listener: (BuildContext context, Object? state) {
          switch(state){
            case LoginFailure state:
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Login failed: ${state.error}"),
                  backgroundColor: Colors.red,
                ),
              );
              break;
            case LoginSuccess state:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Login successful"),
                  backgroundColor: Colors.green,
                ),
              );
              break;
            default:
              break;
          }
        },
      )
    );
  }
}