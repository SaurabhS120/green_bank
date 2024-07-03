class LoginUsecase{
  Future<bool> execute(String username, String password) async{
    await Future.delayed(const Duration(seconds: 3));
    if(username == 'admin' && password == 'admin'){
      return true;
    }else{
      return false;
    }
  }
}