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
                      onErrorBuild: (BuildContext context){
                        return BlocSelector<RegisterBloc,RegisterState,RegisterNameValidationError?>(
                          selector: (state) {
                            if(state is RegisterValidationError){
                              return state.nameError;
                            }else{
                              return null;
                            }
                          },
                          builder: (BuildContext context, RegisterNameValidationError? state) {
                            if(state != null && state is RegisterNameEmptyError){
                              return const AppFormFieldErrorText(errorText:"Name cannot be empty");
                            }else{
                              return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                    FormTextField(
                      labelText: 'Username',
                      controller: context.read<RegisterBloc>().usernameController,
                      onErrorBuild: (BuildContext context) {
                        return BlocSelector<RegisterBloc,RegisterState,RegisterUsernameValidationError?>(
                          selector: (state) {
                            if(state is RegisterValidationError){
                              return state.usernameError;
                            }else{
                              return null;
                            }
                          },
                          builder: (BuildContext context, RegisterUsernameValidationError? state) {
                            if(state != null && state is RegisterUsernameEmptyError){
                              return const AppFormFieldErrorText(errorText:"Username cannot be empty");
                            }else{
                              return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                    FormTextField(
                      labelText: 'Password',
                      controller: context.read<RegisterBloc>().passwordController,
                      onErrorBuild: (BuildContext context) {
                        return BlocSelector<RegisterBloc,RegisterState,RegisterPasswordValidationError?>(
                          selector: (state) {
                            if(state is RegisterValidationError){
                              return state.passwordError;
                            }else{
                              return null;
                            }
                          },
                          builder: (BuildContext context, RegisterPasswordValidationError? state) {
                            switch(state){
                              case RegisterPasswordNoError():
                                return const SizedBox();
                              case RegisterPasswordEmptyError():
                                return const AppFormFieldErrorText(errorText:"Password cannot be empty");
                              case RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason reason):
                                switch(reason){
                                  case RegisterPasswordFormatErrorReason.length:
                                    return const AppFormFieldErrorText(errorText:"Password must be at least 12 characters long");
                                  case RegisterPasswordFormatErrorReason.lowercase:
                                    return const AppFormFieldErrorText(errorText:"Password must contain at least one lowercase letter");
                                  case RegisterPasswordFormatErrorReason.uppercase:
                                    return const AppFormFieldErrorText(errorText:"Password must contain at least one uppercase letter");
                                  case RegisterPasswordFormatErrorReason.number:
                                    return const AppFormFieldErrorText(errorText:"Password must contain at least one number");
                                  case RegisterPasswordFormatErrorReason.spacialCharacter:
                                    return const AppFormFieldErrorText(errorText:"Password must contain at least one special character");
                                  default:
                                    return const SizedBox();
                                }
                              default:
                                return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                    FormTextField(
                      labelText: 'Confirm Password',
                      controller: context.read<RegisterBloc>().confirmPasswordController,
                      onErrorBuild: (BuildContext context) {
                        return BlocSelector<RegisterBloc,RegisterState,RegisterConfirmPasswordValidationError?>(
                          selector: (state) {
                            if(state is RegisterValidationError){
                              return state.confirmPasswordError;
                            }else{
                              return null;
                            }
                          },
                          builder: (BuildContext context, RegisterConfirmPasswordValidationError? state) {
                            if(state != null && state is RegisterConfirmPasswordEmptyError){
                              return const AppFormFieldErrorText(errorText:"Confirm Password cannot be empty");
                            }else if(state != null && state is RegisterConfirmPasswordNotMatch){
                              return const AppFormFieldErrorText(errorText:"Confirm Password not match");
                            }else{
                              return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                    FormTextField(
                      labelText: 'Email',
                      controller: context.read<RegisterBloc>().emailController,
                      onErrorBuild: (BuildContext context) {
                        return BlocSelector<RegisterBloc,RegisterState,RegisterEmailValidationError?>(
                          selector: (state) {
                            if(state is RegisterValidationError){
                              return state.emailError;
                            }else{
                              return null;
                            }
                          },
                          builder: (BuildContext context, RegisterEmailValidationError? state) {
                            if(state != null && state is RegisterEmailEmptyError){
                              return const AppFormFieldErrorText(errorText:"Email cannot be empty");
                            }else{
                              return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                    FormTextField(
                      labelText: 'Phone',
                      controller: context.read<RegisterBloc>().phoneController,
                      onErrorBuild: (BuildContext context) {
                        return BlocSelector<RegisterBloc,RegisterState,RegisterPhoneValidationError?>(
                          selector: (state) {
                            if(state is RegisterValidationError){
                              return state.phoneError;
                            }else{
                              return null;
                            }
                          },
                          builder: (BuildContext context, RegisterPhoneValidationError? state) {
                            if(state != null && state is RegisterPhoneEmptyError){
                              return const AppFormFieldErrorText(errorText:"Phone cannot be empty");
                            }else{
                              return const SizedBox();
                            }
                          },
                        );
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