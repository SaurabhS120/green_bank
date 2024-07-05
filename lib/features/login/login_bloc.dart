import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:green_bank/domain/usecase/login/login_usecase.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final LoginUsecase loginUsecase;
  LoginBloc(this.loginUsecase) : super(LoginInitial()){
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      if(await loginUsecase.execute(event.username, event.password)){
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
sealed class LoginState extends Equatable{

}
class LoginInitial extends LoginState{
  @override
  List<Object?> get props => [];

}
class LoginLoading extends LoginState{
  @override
  List<Object?> get props => [];

}
class LoginFailure extends LoginState{
  final String error;
  LoginFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
class LoginSuccess extends LoginState{
  @override
  List<Object?> get props => [];

}