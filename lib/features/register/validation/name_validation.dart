
import 'package:green_bank/features/register/register_bloc.dart';
import 'package:green_bank/features/register/validation/validation_controller.dart';

class RegisterNameValidation extends RegisterValidation{
  @override
  RegisterValidationNameError validate(String input,[String input2='']) {
    final String name = input;
    if(name.isEmpty){
      return RegisterValidationNameError(reason: RegisterValidationNameErrorReason.empty);
    }else if (RegExp(r'\d').hasMatch(name)){
      return RegisterValidationNameError(reason: RegisterValidationNameErrorReason.number);
    }else if (RegExp(r'''[!@#\$%\^&\*\(\)_\+\-=\{\}\[\]\|\\:;\"'<>,\.\?/~`]''').hasMatch(name)){
      return RegisterValidationNameError(reason: RegisterValidationNameErrorReason.spacialCharacter);
    } else if(!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)){
      return RegisterValidationNameError(reason: RegisterValidationNameErrorReason.format);
    }
    return RegisterValidationNameError(reason: RegisterValidationNameErrorReason.none);  }

}
class RegisterValidationNameError extends BaseRegisterValidationError{
  final RegisterValidationNameErrorReason reason;
  static RegisterValidationNameError get none =>RegisterValidationNameError(reason:RegisterValidationNameErrorReason.none);
  RegisterValidationNameError({required this.reason}):super(error: reason!=RegisterValidationNameErrorReason.none);
}
enum RegisterValidationNameErrorReason{
  none,
  empty,
  number,
  spacialCharacter,
  format,
}