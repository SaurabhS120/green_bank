import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc() : super(LoginInitial()){
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      await Future.delayed(const Duration(seconds: 2));
      if(event.username == 'admin' && event.password == 'admin'){
        emit(LoginSuccess());
      }else{
        emit(LoginFailure(error: 'Invalid credentials'));
      }
    });
  }
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void login(){
    add(LoginButtonPressed(username: usernameController.text, password: passwordController.text));
  }
}
sealed class LoginEvent{

}
class LoginButtonPressed extends LoginEvent{
  final String username;
  final String password;
  LoginButtonPressed({required this.username, required this.password});
}
sealed class LoginState{

}
class LoginInitial extends LoginState{

}
class LoginLoading extends LoginState{

}
class LoginFailure extends LoginState{
  final String error;
  LoginFailure({required this.error});
}
class LoginSuccess extends LoginState{

}