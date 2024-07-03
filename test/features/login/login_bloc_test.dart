import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/domain/usecase/login/login_dummy_usecase.dart';
import 'package:green_bank/features/login/login_bloc.dart';

void main(){
  group('LoginBloc', (){
    blocTest("Login success test",
        build: () => LoginBloc(LoginDummyUsecase()),
        act: (bloc) => bloc.add(LoginButtonPressed(username: 'admin', password: 'admin')),
        expect: () => [isA<LoginLoading>(), isA<LoginSuccess>()],
    );
    blocTest("Login fail test",
      build: () => LoginBloc(LoginDummyUsecase()),
      act: (bloc) =>bloc.add(LoginButtonPressed(username: 'fail', password: 'fail')),
      expect: () => [isA<LoginLoading>(), isA<LoginFailure>()],
    );
  });
}