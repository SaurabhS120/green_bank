import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/domain/usecase/register/register_dummy_usecase.dart';
import 'package:green_bank/domain/usecase/register/register_usecase.dart';
import 'package:green_bank/features/register/register_bloc.dart';

void main(){
  group("RegisterBloc", (){
    blocTest("Register success test",
      build: () => RegisterBloc(RegisterDummyUsecase()),
      act: (bloc) => bloc.add(RegisterButtonPressed(name: 'test',username: 'admin', password: 'admin', confirmPassword: 'admin', email: 'test@gmail.com', phone: '1234567890',)),
      expect: () => [isA<RegisterLoading>(), isA<RegisterSuccess>()],
    );
    group("Validation test", (){
      blocTest("Name empty test",
        build: () => RegisterBloc(RegisterDummyUsecase()),
        act: (bloc) => bloc.add(RegisterButtonPressed(name: '',username: 'admin', password: 'admin', confirmPassword: 'admin', email: 'test@gmail.com', phone: '1234567890',),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.nameError, isA<RegisterNameEmptyError>());
        }
      );
      blocTest("Username empty test",
        build: () => RegisterBloc(RegisterDummyUsecase()),
        act: (bloc) => bloc.add(RegisterButtonPressed(name: 'test',username: '', password: 'admin', confirmPassword: 'admin', email: 'test@gmail.com', phone: '1234567890',),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.usernameError, isA<RegisterUsernameEmptyError>());
        }
      );
      blocTest("Password empty test",
        build: () => RegisterBloc(RegisterDummyUsecase()),
        act: (bloc) => bloc.add(RegisterButtonPressed(name: 'test',username: 'admin', password: '', confirmPassword: 'admin', email: 'test@gmail.com', phone: '1234567890',),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.passwordError, isA<RegisterPasswordEmptyError>());
        }
      );
      blocTest("Confirm password empty test",
        build: () => RegisterBloc(RegisterDummyUsecase()),
        act: (bloc) => bloc.add(RegisterButtonPressed(name: 'test',username: 'admin', password: 'admin', confirmPassword: '', email: 'test@gmail.com', phone: '1234567890',),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.confirmPasswordError, isA<RegisterConfirmPasswordEmptyError>());
        }
      );
      blocTest("Email empty test",
        build: () => RegisterBloc(RegisterDummyUsecase()),
        act: (bloc) => bloc.add(RegisterButtonPressed(name: 'test',username: 'admin', password: 'admin', confirmPassword: 'admin', email: '', phone: '1234567890',),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.emailError, isA<RegisterEmailEmptyError>());
        }
      );
      blocTest("Phone empty test",
        build: () => RegisterBloc(RegisterDummyUsecase()),
        act: (bloc) => bloc.add(RegisterButtonPressed(name: 'test',username: 'admin', password: 'admin', confirmPassword: 'admin', email: 'test@gmail.com', phone: '',),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.phoneError, isA<RegisterPhoneEmptyError>());
        }
      );
      blocTest("Confirm password not match test",
        build: () => RegisterBloc(RegisterDummyUsecase()),
        act: (bloc) => bloc.add(RegisterButtonPressed(name: 'test',username: 'admin', password: 'admin', confirmPassword: 'admin1', email: 'test@gmail.com', phone: '1234567890',),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.confirmPasswordError, isA<RegisterConfirmPasswordNotMatch>());
        }
      );
    });
  });
}