import 'package:green_bank/domain/usecase/login/login_usecase.dart';

class LoginDummyUsecase extends LoginUsecase{
  @override
  Future<bool> execute(String username, String password) async{
    if(username == 'admin' && password == 'admin'){
      return true;
    }else{
      return false;
    }
  }
}