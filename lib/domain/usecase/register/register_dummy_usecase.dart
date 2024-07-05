import 'package:green_bank/domain/model/register_request_model.dart';
import 'package:green_bank/domain/usecase/register/register_usecase.dart';

class RegisterDummyUsecase extends RegisterUsecase{
  @override
  Future<bool> register(RegisterRequestModel requestModel) async {
    return true;
  }
}