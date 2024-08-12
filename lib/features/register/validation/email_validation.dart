
import 'package:green_bank/features/register/validation/validation_controller.dart';

class RegisterEmailValidation extends RegisterValidation{
  @override
  RegisterValidationEmailError validate(String input,[String input2='']) {
    final String email = input;
    if(email.isEmpty){
      return RegisterValidationEmailError(reason:RegisterValidationEmailErrorReason.empty);
    }
    return RegisterValidationEmailError(reason:RegisterValidationEmailErrorReason.none);
  }

}
class RegisterValidationEmailError extends BaseRegisterValidationError{
  final RegisterValidationEmailErrorReason reason;
  static RegisterValidationEmailError get none =>RegisterValidationEmailError(reason:RegisterValidationEmailErrorReason.none);
  RegisterValidationEmailError({required this.reason}):super(error: reason!=RegisterValidationEmailErrorReason.none);
}
enum RegisterValidationEmailErrorReason{
  none,
  empty,
}