
import 'package:green_bank/features/register/register_bloc.dart';
import 'package:green_bank/features/register/validation/validation_controller.dart';

class RegisterConfirmPasswordValidation extends RegisterValidation{
  @override
  RegisterValidationConfirmPasswordError validate(String input,[String input2='']) {
    final String password = input;
    final String confirmPassword = input2;
    if(confirmPassword.isEmpty){
      return RegisterValidationConfirmPasswordError(reason:RegisterValidationConfirmPasswordErrorReason.empty);
    }else if(password != confirmPassword){
      return RegisterValidationConfirmPasswordError(reason:RegisterValidationConfirmPasswordErrorReason.noMatch);
    }
    return RegisterValidationConfirmPasswordError(reason:RegisterValidationConfirmPasswordErrorReason.none);
  }

}
class RegisterValidationConfirmPasswordError extends BaseRegisterValidationError{
  final RegisterValidationConfirmPasswordErrorReason reason;
  static RegisterValidationConfirmPasswordError get none =>RegisterValidationConfirmPasswordError(reason:RegisterValidationConfirmPasswordErrorReason.none);
  RegisterValidationConfirmPasswordError({required this.reason}):super(error: reason!=RegisterValidationConfirmPasswordErrorReason.none);
}
enum RegisterValidationConfirmPasswordErrorReason{
  none,
  empty,
  noMatch,
}