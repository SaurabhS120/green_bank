import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bank/features/register/register_bloc.dart';
import 'package:green_bank/ui/app_loader.dart';
import 'package:green_bank/ui/form/app_form.dart';
import 'package:green_bank/ui/snackbar/app_snack_bar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        builder: (BuildContext context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: AppForm(
                  children: [
                    FormTextField(
                      labelText: 'Name',
                      controller: context.read<RegisterBloc>().nameController,
                    ),
                    BlocSelector<RegisterBloc,RegisterState,RegisterNameValidationError?>(
                      selector: (state) {
                        if(state is RegisterValidationError){
                          return state.nameError;
                        }else{
                          return null;
                        }
                      },
                      builder: (BuildContext context, RegisterNameValidationError? state) {
                        if(state != null && state is RegisterNameEmptyError){
                          return const Text("Name cannot be empty", style: TextStyle(color: Colors.red));
                        }else{
                          return const SizedBox();
                        }
                      },
                    ),
                    FormTextField(
                      labelText: 'Username',
                      controller: context.read<RegisterBloc>().usernameController,
                    ),
                    BlocSelector<RegisterBloc,RegisterState,RegisterUsernameValidationError?>(
                      selector: (state) {
                        if(state is RegisterValidationError){
                          return state.usernameError;
                        }else{
                          return null;
                        }
                      },
                      builder: (BuildContext context, RegisterUsernameValidationError? state) {
                        if(state != null && state is RegisterUsernameEmptyError){
                          return const Text("Username cannot be empty", style: TextStyle(color: Colors.red));
                        }else{
                          return const SizedBox();
                        }
                      },
                    ),
                    FormTextField(
                      labelText: 'Password',
                      controller: context.read<RegisterBloc>().passwordController,
                    ),
                    BlocSelector<RegisterBloc,RegisterState,RegisterPasswordValidationError?>(
                      selector: (state) {
                        if(state is RegisterValidationError){
                          return state.passwordError;
                        }else{
                          return null;
                        }
                      },
                      builder: (BuildContext context, RegisterPasswordValidationError? state) {
                        if(state != null && state is RegisterPasswordEmptyError){
                          return const Text("Password cannot be empty", style: TextStyle(color: Colors.red));
                        }else{
                          return const SizedBox();
                        }
                      },
                    ),
                    FormTextField(
                      labelText: 'Confirm Password',
                      controller: context.read<RegisterBloc>().confirmPasswordController,
                    ),
                    BlocSelector<RegisterBloc,RegisterState,RegisterConfirmPasswordValidationError?>(
                      selector: (state) {
                        if(state is RegisterValidationError){
                          return state.confirmPasswordError;
                        }else{
                          return null;
                        }
                      },
                      builder: (BuildContext context, RegisterConfirmPasswordValidationError? state) {
                        if(state != null && state is RegisterConfirmPasswordEmptyError){
                          return const Text("Confirm Password cannot be empty", style: TextStyle(color: Colors.red));
                        }else if(state != null && state is RegisterConfirmPasswordNotMatch){
                          return const Text("Confirm Password not match", style: TextStyle(color: Colors.red));
                        }else{
                          return const SizedBox();
                        }
                      },
                    ),
                    FormTextField(
                      labelText: 'Email',
                      controller: context.read<RegisterBloc>().emailController,
                    ),
                    BlocSelector<RegisterBloc,RegisterState,RegisterEmailValidationError?>(
                      selector: (state) {
                        if(state is RegisterValidationError){
                          return state.emailError;
                        }else{
                          return null;
                        }
                      },
                      builder: (BuildContext context, RegisterEmailValidationError? state) {
                        if(state != null && state is RegisterEmailEmptyError){
                          return const Text("Email cannot be empty", style: TextStyle(color: Colors.red));
                        }else{
                          return const SizedBox();
                        }
                      },
                    ),
                    FormTextField(
                      labelText: 'Phone',
                      controller: context.read<RegisterBloc>().phoneController,
                    ),
                    BlocSelector<RegisterBloc,RegisterState,RegisterPhoneValidationError?>(
                      selector: (state) {
                        if(state is RegisterValidationError){
                          return state.phoneError;
                        }else{
                          return null;
                        }
                      },
                      builder: (BuildContext context, RegisterPhoneValidationError? state) {
                        if(state != null && state is RegisterPhoneEmptyError){
                          return const Text("Phone cannot be empty", style: TextStyle(color: Colors.red));
                        }else{
                          return const SizedBox();
                        }
                      },
                    ),
                    FormButton(
                      text: 'Register',
                      onPressed: () {
                        context.read<RegisterBloc>().add(
                          RegisterButtonPressed(
                            name: context.read<RegisterBloc>().nameController.text,
                            username: context.read<RegisterBloc>().usernameController.text,
                            password: context.read<RegisterBloc>().passwordController.text,
                            confirmPassword: context.read<RegisterBloc>().confirmPasswordController.text,
                            email: context.read<RegisterBloc>().emailController.text,
                            phone: context.read<RegisterBloc>().phoneController.text,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              if (state is RegisterLoading)
                const AppLoader(),
            ],
          );
        },
        listener: (BuildContext context, Object? state) {
          if (state is RegisterFailure) {
            AppSnackBar.showSnackBar(context, message: "Register failed: ${state.error}", type: SnackBarType.error);
          } else if (state is RegisterSuccess) {
            AppSnackBar.showSnackBar(context, message: "Register successful", type: SnackBarType.success);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}