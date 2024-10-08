import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bank/domain/model/register_request_model.dart';
import 'package:green_bank/domain/usecase/register/register_usecase.dart';

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
      final validationErrorPrototype = RegisterValidationErrorPrototype();
      validationErrorPrototype.nameError = RegisterBlocValidations.validateName(event.name);
      if(event.username.isEmpty){
        validationErrorPrototype.usernameError = RegisterUsernameEmptyError();
      }

      validationErrorPrototype.passwordError = RegisterBlocValidations.validatePassword(event.password);
      if(event.confirmPassword.isEmpty){
        validationErrorPrototype.confirmPasswordError = RegisterConfirmPasswordEmptyError();
      }else if(event.password != event.confirmPassword){
        validationErrorPrototype.confirmPasswordError = RegisterConfirmPasswordNotMatch();
      }
      if(event.email.isEmpty){
        validationErrorPrototype.emailError = RegisterEmailEmptyError();
      }
      if(event.phone.isEmpty){
        validationErrorPrototype.phoneError = RegisterPhoneEmptyError();
      }
      RegisterValidationError validationError = validationErrorPrototype.build();

      if(validationError.hasError()) {
        emit(validationError);
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

class RegisterBlocValidations{
  static RegisterNameValidationError validateName(String name){
    if(name.isEmpty){
      return RegisterNameEmptyError();
    }else if (RegExp(r'\d').hasMatch(name)){
      return RegisterNameShouldNotContainDigitError();
    }else if (RegExp(r'''[!@#\$%\^&\*\(\)_\+\-=\{\}\[\]\|\\:;\"'<>,\.\?/~`]''').hasMatch(name)){
      return RegisterNameShouldNotContainSpecialCharacterError();
    } else if(!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)){
      return RegisterNameFormatError();
    }
    return RegisterNameNoError();
  }

  static RegisterPasswordValidationError validatePassword(String password) {
    //At least 12 characters long but 14 or more is better.
    //
    // A combination of uppercase letters, lowercase letters, numbers, and symbols.
    if(password.isEmpty){
      // password empty
      return RegisterPasswordEmptyError();
    }else if(password.length < 12){
      // password less than 12 characters
      return RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.length);
    }else if(!password.contains(RegExp(r'[0-9]'))){
      // password without number
      return RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.number);
    }else if(password.length > 20){
      // password more than 20 characters
      return RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.length);
    }else if(!password.contains(RegExp(r'[A-Za-z]'))){
      // password without lowercase letter
      return RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.lowercase);
    } else if(!password.contains(RegExp(r'[A-Z]'))){
      // password without uppercase letter
      return RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.uppercase);
    }else if(!password.contains(RegExp(r'[a-z]'))){
      // password without lowercase letter
      return RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.lowercase);
    }else if(!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      // password without special character
      return RegisterPasswordFormatError(reason: RegisterPasswordFormatErrorReason.spacialCharacter);
    }
    return RegisterPasswordNoError();
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