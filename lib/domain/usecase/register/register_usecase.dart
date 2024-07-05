import 'package:green_bank/domain/model/register_request_model.dart';

class RegisterUsecase{
  Future<bool> register(RegisterRequestModel requestModel) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}