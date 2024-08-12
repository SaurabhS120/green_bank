import 'package:green_bank/features/register/validation/confirm_password_validation.dart';
import 'package:green_bank/features/register/validation/name_validation.dart';
import 'package:green_bank/features/register/validation/password_validation.dart';
import 'package:green_bank/features/register/validation/phone_validation.dart';
import 'package:green_bank/features/register/validation/email_validation.dart';
import 'package:green_bank/features/register/validation/user_name_validation.dart';

abstract class BaseRegisterValidationError{
  final bool error;

  BaseRegisterValidationError({this.error = true});
}
abstract class RegisterValidation{
  BaseRegisterValidationError validate(String input,[String input2]);
}
class RegisterValidationController{
  final RegisterNameValidation registerNameValidation;
  final RegisterUserNameValidation registerUserNameValidation;
  final RegisterPasswordValidation registerPasswordValidation;
  final RegisterConfirmPasswordValidation registerConfirmPasswordValidation;
  final RegisterEmailValidation registerEmailValidation;
  final RegisterPhoneValidation registerPhoneValidation;

  RegisterValidationController({
    required this.registerNameValidation,
    required this.registerUserNameValidation,
    required this.registerPasswordValidation,
    required this.registerConfirmPasswordValidation,
    required this.registerEmailValidation,
    required this.registerPhoneValidation,
  });

  RegisterValidationResult validate({
    required String name,
    required String userName,
    required String password,
    required String confirmPassword,
    required String email,
    required String phone,
  }){
    return RegisterValidationResult(
        nameError: registerNameValidation.validate(name),
        userNameError: registerUserNameValidation.validate(userName),
        passwordError: registerPasswordValidation.validate(password),
        confirmPasswordError: registerConfirmPasswordValidation.validate(password,confirmPassword),
        emailError: registerEmailValidation.validate(email),
        phoneError: registerPhoneValidation.validate(phone),
    );
  }

  factory RegisterValidationController.create() => RegisterValidationController(
    registerNameValidation: RegisterNameValidation(),
    registerUserNameValidation: RegisterUserNameValidation(),
    registerPasswordValidation: RegisterPasswordValidation(),
    registerConfirmPasswordValidation: RegisterConfirmPasswordValidation(),
    registerEmailValidation: RegisterEmailValidation(),
    registerPhoneValidation: RegisterPhoneValidation(),
  );

}
class RegisterValidationResult{
  final RegisterValidationNameError nameError;
  final RegisterValidationUserNameError userNameError;
  final RegisterValidationPasswordError passwordError;
  final RegisterValidationConfirmPasswordError confirmPasswordError;
  final RegisterValidationEmailError emailError;
  final RegisterValidationPhoneError phoneError;

  late List<BaseRegisterValidationError> errorList;
  RegisterValidationResult({
    required this.nameError,
    required this.userNameError,
    required this.passwordError,
    required this.confirmPasswordError,
    required this.emailError,
    required this.phoneError,
  }){
    errorList = [
      nameError,
      userNameError,
      passwordError,
      confirmPasswordError,
      emailError,
      phoneError,
    ];
  }

  bool hasError(){
    for(var errorState in errorList){
      if(errorState.error){
        return true;
      }
    }
    return false;
  }
}