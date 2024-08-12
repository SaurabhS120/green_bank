
import 'package:green_bank/features/register/register_bloc.dart';
import 'package:green_bank/features/register/validation/validation_controller.dart';

class RegisterPasswordValidation extends RegisterValidation{
  @override
  RegisterValidationPasswordError validate(String input,[String input2='']) {
    final String password = input;
    if(password.isEmpty){
      // password empty
      return RegisterValidationPasswordError(reason: RegisterValidationPasswordErrorReason.empty);
    }else if(password.length < 12){
      // password less than 12 characters
      return RegisterValidationPasswordError(reason: RegisterValidationPasswordErrorReason.length);
    }else if(!password.contains(RegExp(r'[0-9]'))){
      // password without number
      return RegisterValidationPasswordError(reason: RegisterValidationPasswordErrorReason.number);
    }else if(password.length > 20){
      // password more than 20 characters
      return RegisterValidationPasswordError(reason: RegisterValidationPasswordErrorReason.length);
    }else if(!password.contains(RegExp(r'[A-Za-z]'))){
      // password without lowercase letter
      return RegisterValidationPasswordError(reason: RegisterValidationPasswordErrorReason.character);
    } else if(!password.contains(RegExp(r'[A-Z]'))){
      // password without uppercase letter
      return RegisterValidationPasswordError(reason: RegisterValidationPasswordErrorReason.uppercase);
    }else if(!password.contains(RegExp(r'[a-z]'))){
      // password without lowercase letter
      return RegisterValidationPasswordError(reason: RegisterValidationPasswordErrorReason.lowercase);
    }else if(!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))){
      // password without special character
      return RegisterValidationPasswordError(reason: RegisterValidationPasswordErrorReason.spacialCharacter);
    }
    return RegisterValidationPasswordError(reason: RegisterValidationPasswordErrorReason.none);
  }

}
class RegisterValidationPasswordError extends BaseRegisterValidationError{
  final RegisterValidationPasswordErrorReason reason;
  static RegisterValidationPasswordError get none =>RegisterValidationPasswordError(reason:RegisterValidationPasswordErrorReason.none);
  RegisterValidationPasswordError({required this.reason}):super(error: reason!=RegisterValidationPasswordErrorReason.none);
}
enum RegisterValidationPasswordErrorReason{
  none,
  empty,
  length,
  number,
  lowercase,
  uppercase,
  character,
  spacialCharacter,
}