
import 'package:green_bank/features/register/register_bloc.dart';
import 'package:green_bank/features/register/validation/validation_controller.dart';

class RegisterUserNameValidation extends RegisterValidation{
  @override
  RegisterValidationUserNameError validate(String input,[String input2='']) {
    final String name = input;
    if(name.isEmpty){
      return RegisterValidationUserNameError(reason: RegisterValidationUserNameErrorReason.empty);
    }
    return RegisterValidationUserNameError(reason: RegisterValidationUserNameErrorReason.none);  }

}
class RegisterValidationUserNameError extends BaseRegisterValidationError{
  final RegisterValidationUserNameErrorReason reason;
  static RegisterValidationUserNameError get none =>RegisterValidationUserNameError(reason:RegisterValidationUserNameErrorReason.none);
  RegisterValidationUserNameError({required this.reason}):super(error: reason!=RegisterValidationUserNameErrorReason.none);
}
enum RegisterValidationUserNameErrorReason{
  none,
  empty,
}