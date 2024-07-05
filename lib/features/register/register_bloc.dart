import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bank/domain/model/register_request_model.dart';
import 'package:green_bank/domain/usecase/register/register_usecase.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterUsecase registerUsecase;
  RegisterBloc({required this.registerUsecase}) : super(const RegisterInitial()){
    on<RegisterButtonPressed>((event, emit) async {
      emit(const RegisterLoading());
      final validationErrorPrototype = RegisterValidationErrorPrototype();
      if(event.name.isEmpty){
        validationErrorPrototype.nameError = RegisterNameEmptyError();
      }
      if(event.username.isEmpty){
        validationErrorPrototype.usernameError = RegisterUsernameEmptyError();
      }
      if(event.password.isEmpty){
        validationErrorPrototype.passwordError = RegisterPasswordEmptyError();
      }
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
        if (await registerUsecase.register(event.toRequestModel())) {
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