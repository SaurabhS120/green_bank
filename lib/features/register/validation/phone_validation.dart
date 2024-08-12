
import 'package:green_bank/features/register/register_bloc.dart';
import 'package:green_bank/features/register/validation/validation_controller.dart';

class RegisterPhoneValidation extends RegisterValidation{
  @override
  RegisterValidationPhoneError validate(String input,[String input2='']) {
    final String phone = input;
    if(phone.isEmpty){
      return RegisterValidationPhoneError(reason:RegisterValidationPhoneErrorReason.empty);
    }
    return RegisterValidationPhoneError(reason:RegisterValidationPhoneErrorReason.none);
  }

}
class RegisterValidationPhoneError extends BaseRegisterValidationError{
  final RegisterValidationPhoneErrorReason reason;
  static RegisterValidationPhoneError get none =>RegisterValidationPhoneError(reason:RegisterValidationPhoneErrorReason.none);
  RegisterValidationPhoneError({required this.reason}):super(error: reason!=RegisterValidationPhoneErrorReason.none);
}
enum RegisterValidationPhoneErrorReason{
  none,
  empty,
}