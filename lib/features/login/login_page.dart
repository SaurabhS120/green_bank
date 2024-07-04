import 'package:flutter/material.dart';
import 'package:green_bank/features/login/login_bloc.dart';
import 'package:green_bank/ui/snackbar/app_snack_bar.dart';
import 'package:green_bank/ui/app_loader.dart';
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
          return Stack(
            children: [
              AppForm(
              children: [
                FormTextField(
                  key: const Key('usernameInput'),
                  labelText: 'Username',
                  controller: context.read<LoginBloc>().usernameController,
                ),
                FormTextField(
                  key: const Key('passwordInput'),
                  labelText: 'Password',
                  controller: context.read<LoginBloc>().passwordController,
                ),
                FormButton(
                  key: const Key('loginButton'),
                  text: 'Login',
                  onPressed:context.read<LoginBloc>().login,
                ),
              ],
            ),
            if(state is LoginLoading)
              const AppLoader(),
            ],
          );
        },
        listener: (BuildContext context, Object? state) {
          switch(state){
            case LoginLoading _:
              AppLoader.closeKeyboard();
              break;
            case LoginFailure state:
              AppSnackBar.showSnackBar(context, message: "Login failed: ${state.error}", type: SnackBarType.error);
              break;
            case LoginSuccess _:
              AppSnackBar.showSnackBar(context,message: "Login successful", type: SnackBarType.success);
              break;
            default:
              break;
          }
        },
      )
    );
  }
}