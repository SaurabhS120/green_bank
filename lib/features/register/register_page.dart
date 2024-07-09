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
                      key: const Key('nameInput'),
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
                           switch(state){
                             case null:
                               return const SizedBox();
                             case RegisterNameNoError():
                               return const SizedBox();
                             case RegisterNameEmptyError():
                               return const AppFormFieldErrorText(errorText: RegisterErrorMessages.nameEmpty);
                             case RegisterNameFormatError error:
                               switch(error){
                                 case RegisterNameShouldNotContainDigitError():
                                   return const AppFormFieldErrorText(errorText: RegisterErrorMessages.nameWithDigitError);
                                 case RegisterNameShouldNotContainSpecialCharacterError():
                                   return const AppFormFieldErrorText(errorText: RegisterErrorMessages.nameWithSpecialCharacterError);
                                 default:
                                   return const AppFormFieldErrorText(errorText: RegisterErrorMessages.nameValidationError);

                               }
                           }
                          },
                        );
                      },
                    ),
                    FormTextField(
                      key: const Key('usernameInput'),
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
                              return const AppFormFieldErrorText(errorText:RegisterErrorMessages.usernameEmpty);
                            }else{
                              return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                    FormTextField(
                      key: const Key('passwordInput'),
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
                                return const AppFormFieldErrorText(errorText:RegisterErrorMessages.passwordEmpty);
                              case RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason reason):
                                switch(reason){
                                  case RegisterPasswordFormatErrorReason.length:
                                    return const AppFormFieldErrorText(errorText:RegisterErrorMessages.passwordLength);
                                  case RegisterPasswordFormatErrorReason.lowercase:
                                    return const AppFormFieldErrorText(errorText:RegisterErrorMessages.passwordLowercase);
                                  case RegisterPasswordFormatErrorReason.uppercase:
                                    return const AppFormFieldErrorText(errorText:RegisterErrorMessages.passwordUppercase);
                                  case RegisterPasswordFormatErrorReason.number:
                                    return const AppFormFieldErrorText(errorText:RegisterErrorMessages.passwordNumber);
                                  case RegisterPasswordFormatErrorReason.spacialCharacter:
                                    return const AppFormFieldErrorText(errorText:RegisterErrorMessages.passwordSpecialCharacter);
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
                      key: const Key('confirmPasswordInput'),
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
                              return const AppFormFieldErrorText(errorText:RegisterErrorMessages.confirmPasswordEmpty);
                            }else if(state != null && state is RegisterConfirmPasswordNotMatch){
                              return const AppFormFieldErrorText(errorText:RegisterErrorMessages.confirmPasswordNotMatch);
                            }else{
                              return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                    FormTextField(
                      key: const Key('emailInput'),
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
                              return const AppFormFieldErrorText(errorText:RegisterErrorMessages.emailEmpty);
                            }else{
                              return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                    FormTextField(
                      key: const Key('phoneInput'),
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
                              return const AppFormFieldErrorText(errorText:RegisterErrorMessages.phoneEmpty);
                            }else{
                              return const SizedBox();
                            }
                          },
                        );
                      },
                    ),
                    FormButton(
                      key: const Key('registerButton'),
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
            AppSnackBar.showSnackBar(context, message: "${RegisterSnackBarMessages.registerFailed}: ${state.error}", type: SnackBarType.error);
          } else if (state is RegisterSuccess) {
            AppSnackBar.showSnackBar(context, message: RegisterSnackBarMessages.registerSuccess, type: SnackBarType.success);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
class RegisterSnackBarMessages{
  static const String registerFailed = "Register failed";
  static const String registerSuccess = "Register successful";
}
class RegisterErrorMessages{
  static const String nameEmpty = "Name cannot be empty";
  static const String nameValidationError = "Name format error";
  static const String nameWithDigitError = "Name should not contain numbers";
  static const String nameWithSpecialCharacterError = "Name should not contain spacial character";
  static const String usernameEmpty = "Username cannot be empty";
  static const String passwordEmpty = "Password cannot be empty";
  static const String passwordLength = "Password must be at least 12 characters long";
  static const String passwordLowercase = "Password must contain at least one lowercase letter";
  static const String passwordUppercase = "Password must contain at least one uppercase letter";
  static const String passwordNumber = "Password must contain at least one number";
  static const String passwordSpecialCharacter = "Password must contain at least one special character";
  static const String confirmPasswordEmpty = "Confirm Password cannot be empty";
  static const String confirmPasswordNotMatch = "Confirm Password not match";
  static const String emailEmpty = "Email cannot be empty";
  static const String phoneEmpty = "Phone cannot be empty";
}