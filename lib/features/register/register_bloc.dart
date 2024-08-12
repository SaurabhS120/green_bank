import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bank/domain/model/register_request_model.dart';
import 'package:green_bank/domain/usecase/register/register_usecase.dart';
import 'package:green_bank/features/register/validation/confirm_password_validation.dart';
import 'package:green_bank/features/register/validation/email_validation.dart';
import 'package:green_bank/features/register/validation/name_validation.dart';
import 'package:green_bank/features/register/validation/password_validation.dart';
import 'package:green_bank/features/register/validation/phone_validation.dart';
import 'package:green_bank/features/register/validation/user_name_validation.dart';
import 'package:green_bank/features/register/validation/validation_controller.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase registerUsecase;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  RegisterBloc(this.registerUsecase) : super(const RegisterInitial()){
    on<RegisterButtonPressed>((event, emit) async {
      emit(const RegisterLoading());
      final RegisterValidationController registerValidationController = RegisterValidationController.create();
      var validationError = registerValidationController.validate(name: event.name, userName: event.username, password: event.password, confirmPassword: event.confirmPassword, email: event.email, phone: event.phone);
      if(validationError.hasError()) {
        RegisterValidationErrorPrototype prototype = RegisterValidationErrorPrototype();
        switch(validationError.nameError.reason){
          case RegisterValidationNameErrorReason.none:
            prototype.nameError = RegisterNameNoError();
          case RegisterValidationNameErrorReason.empty:
            prototype.nameError = RegisterNameEmptyError();
          case RegisterValidationNameErrorReason.number:
            prototype.nameError = RegisterNameShouldNotContainDigitError();
          case RegisterValidationNameErrorReason.spacialCharacter:
            prototype.nameError = RegisterNameShouldNotContainSpecialCharacterError();
          case RegisterValidationNameErrorReason.format:
            prototype.nameError = RegisterNameFormatError();
        }
        switch(validationError.userNameError.reason){
          case RegisterValidationUserNameErrorReason.none:
            prototype.usernameError = RegisterUsernameNoError();
          case RegisterValidationUserNameErrorReason.empty:
            prototype.usernameError = RegisterUsernameEmptyError();
        }
        switch(validationError.passwordError.reason){
          case RegisterValidationPasswordErrorReason.none:
            prototype.passwordError = RegisterPasswordNoError();
          case RegisterValidationPasswordErrorReason.empty:
            prototype.passwordError = RegisterPasswordEmptyError();
          case RegisterValidationPasswordErrorReason.length:
            prototype.passwordError = RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.length);
          case RegisterValidationPasswordErrorReason.number:
            prototype.passwordError = RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.number);
          case RegisterValidationPasswordErrorReason.lowercase:
            prototype.passwordError = RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.lowercase);
          case RegisterValidationPasswordErrorReason.uppercase:
            prototype.passwordError = RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.uppercase);
          case RegisterValidationPasswordErrorReason.character:
            prototype.passwordError = RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.lowercase);
          case RegisterValidationPasswordErrorReason.spacialCharacter:
            prototype.passwordError = RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.spacialCharacter);
        }
        switch(validationError.confirmPasswordError.reason){
          case RegisterValidationConfirmPasswordErrorReason.none:
            prototype.confirmPasswordError = RegisterConfirmPasswordNoError();
          case RegisterValidationConfirmPasswordErrorReason.empty:
            prototype.confirmPasswordError = RegisterConfirmPasswordEmptyError();
          case RegisterValidationConfirmPasswordErrorReason.noMatch:
            prototype.confirmPasswordError = RegisterConfirmPasswordNotMatch();
        }
        switch(validationError.emailError.reason){
          case RegisterValidationEmailErrorReason.none:
            prototype.emailError = RegisterEmailNoError();
          case RegisterValidationEmailErrorReason.empty:
            prototype.emailError = RegisterEmailEmptyError();
        }
        switch(validationError.phoneError.reason){
          case RegisterValidationPhoneErrorReason.none:
            prototype.phoneError = RegisterPhoneNoError();
          case RegisterValidationPhoneErrorReason.empty:
            prototype.phoneError = RegisterPhoneEmptyError();
        }
        emit(prototype.build());
      }else{
        if (await registerUsecase.execute(event.toRequestModel())) {
          emit(const RegisterSuccess());
        } else {
          emit(const RegisterFailure(error: 'Register failed'));
        }
      }
    });
  }
}
sealed class RegisterState extends Equatable{
  const RegisterState();
}
class RegisterInitial extends RegisterState{
  const RegisterInitial();

  @override
  List<Object?> get props => [];
}
class RegisterLoading extends RegisterState{
  const RegisterLoading();

  @override
  List<Object?> get props => [];
}
class RegisterFailure extends RegisterState{
  final String error;
  const RegisterFailure({required this.error});

  @override
  List<Object?> get props => [];
}
class RegisterSuccess extends RegisterState{
  const RegisterSuccess();

  @override
  List<Object?> get props => [];
}
class RegisterValidationError extends RegisterState {
  final RegisterNameValidationError nameError;
  final RegisterUsernameValidationError usernameError;
  final RegisterPasswordValidationError passwordError;
  final RegisterConfirmPasswordValidationError confirmPasswordError;
  final RegisterEmailValidationError emailError;
  final RegisterPhoneValidationError phoneError;

  const RegisterValidationError({
      required this.nameError,
      required this.usernameError,
      required this.passwordError,
      required this.confirmPasswordError,
      required this.emailError,
      required this.phoneError,
  });

  @override
  List<Object?> get props => [nameError, usernameError, passwordError, confirmPasswordError, emailError, phoneError];

  bool hasError() {
    return nameError is! RegisterNameNoError ||
        usernameError is! RegisterUsernameNoError ||
        passwordError is! RegisterPasswordNoError ||
        confirmPasswordError is! RegisterConfirmPasswordNoError ||
        emailError is! RegisterEmailNoError ||
        phoneError is! RegisterPhoneNoError;
  }
}
class RegisterValidationErrorPrototype{
  //   final String name;
  RegisterNameValidationError nameError = RegisterNameNoError();
  //   final String username;
  RegisterUsernameValidationError usernameError = RegisterUsernameNoError();
  //   final String password;
  RegisterPasswordValidationError passwordError = RegisterPasswordNoError();
  //   final String confirmPassword;
  RegisterConfirmPasswordValidationError confirmPasswordError = RegisterConfirmPasswordNoError();
  //   final String email;
  RegisterEmailValidationError emailError = RegisterEmailNoError();
  //   final String phone;
  RegisterPhoneValidationError phoneError = RegisterPhoneNoError();

  RegisterValidationErrorPrototype();

  RegisterValidationError build(){
    return RegisterValidationError(
      nameError: nameError,
      usernameError: usernameError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      emailError: emailError,
      phoneError: phoneError,
    );
  }
}
// final String name;
sealed class RegisterNameValidationError{
  RegisterNameValidationError();
}
class RegisterNameNoError extends RegisterNameValidationError{
  RegisterNameNoError();
}
class RegisterNameEmptyError extends RegisterNameValidationError{
  RegisterNameEmptyError();
}
class RegisterNameFormatError extends RegisterNameValidationError{
  RegisterNameFormatError();
}
class RegisterNameShouldNotContainDigitError extends RegisterNameFormatError{
  RegisterNameShouldNotContainDigitError();
}
class RegisterNameShouldNotContainSpecialCharacterError extends RegisterNameFormatError{
  RegisterNameShouldNotContainSpecialCharacterError();
}
//   final String username;
sealed class RegisterUsernameValidationError{
  RegisterUsernameValidationError();
}
class RegisterUsernameNoError extends RegisterUsernameValidationError{
  RegisterUsernameNoError();
}
class RegisterUsernameEmptyError extends RegisterUsernameValidationError{
  RegisterUsernameEmptyError();
}
//   final String password;
sealed class RegisterPasswordValidationError{
  RegisterPasswordValidationError();
}
class RegisterPasswordNoError extends RegisterPasswordValidationError{
  RegisterPasswordNoError();
}
class RegisterPasswordEmptyError extends RegisterPasswordValidationError{
  RegisterPasswordEmptyError();
}
enum RegisterPasswordFormatErrorReason{
  length,
  lowercase,
  uppercase,
  number,
  spacialCharacter,
}
class RegisterPasswordFormatError extends RegisterPasswordValidationError{
  final RegisterPasswordFormatErrorReason reason;
  RegisterPasswordFormatError({required this.reason});
}
//   final String confirmPassword;
sealed class RegisterConfirmPasswordValidationError{
  RegisterConfirmPasswordValidationError();
}
class RegisterConfirmPasswordNoError extends RegisterConfirmPasswordValidationError{
  RegisterConfirmPasswordNoError();
}
class RegisterConfirmPasswordEmptyError extends RegisterConfirmPasswordValidationError{
  RegisterConfirmPasswordEmptyError();
}
class RegisterConfirmPasswordNotMatch extends RegisterConfirmPasswordValidationError{
  RegisterConfirmPasswordNotMatch();
}
//   final String email;
sealed class RegisterEmailValidationError{
  RegisterEmailValidationError();
}
class RegisterEmailNoError extends RegisterEmailValidationError{
  RegisterEmailNoError();
}
class RegisterEmailEmptyError extends RegisterEmailValidationError{
  RegisterEmailEmptyError();
}
//   final String phone;
sealed class RegisterPhoneValidationError{
  RegisterPhoneValidationError();
}
class RegisterPhoneNoError extends RegisterPhoneValidationError{
  RegisterPhoneNoError();
}
class RegisterPhoneEmptyError extends RegisterPhoneValidationError{
  RegisterPhoneEmptyError();
}

sealed class RegisterEvent{
  RegisterEvent();
}
class RegisterButtonPressed extends RegisterEvent{
  final String name;
  final String username;
  final String password;
  final String confirmPassword;
  final String email;
  final String phone;
  RegisterButtonPressed({required this.name, required this.username, required this.password, required this.confirmPassword, required this.email, required this.phone,});

  RegisterRequestModel toRequestModel() => RegisterRequestModel(username: username, password: password, email: email, phone: phone, name: name, confirmPassword: confirmPassword);
}