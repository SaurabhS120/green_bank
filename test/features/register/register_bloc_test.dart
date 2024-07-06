import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/domain/usecase/register/register_usecase.dart';
import 'package:green_bank/features/register/register_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'register_bloc_test.mocks.dart';

RegisterButtonPressed createDummyButtonPress({
  String name = 'test',
  String username = 'admin',
  String password = 'Password123!',
  String confirmPassword = 'Password123!',
  String email = 'test@gmail.com',
  String phone = '0123456789',
}){
  return RegisterButtonPressed(
    name: name,
    username: username,
    password: password,
    confirmPassword: confirmPassword,
    email: email,
    phone: phone,
  );
}

@GenerateNiceMocks([MockSpec<RegisterUsecase>()])
void main(){
  MockRegisterUsecase mockRegisterUsecase = MockRegisterUsecase();
  group("Register bloc test", (){
    blocTest("Register success test",
      setUp: ()=>when(mockRegisterUsecase.execute(any)).thenAnswer((_) async => true),
      build: () => RegisterBloc(mockRegisterUsecase),
      act: (bloc) =>
          bloc.add(createDummyButtonPress()),
      expect: () => [isA<RegisterLoading>(), isA<RegisterSuccess>()],
    );
    blocTest("Register Failure test",
      setUp: ()=>when(mockRegisterUsecase.execute(any)).thenAnswer((_) async => false),
      build: () => RegisterBloc(mockRegisterUsecase),
      act: (bloc) =>
          bloc.add(createDummyButtonPress()),
      expect: () => [isA<RegisterLoading>(), isA<RegisterFailure>()],
    );
    group("Validation test", (){
      blocTest("Name empty test",
        build: () => RegisterBloc(mockRegisterUsecase),
        act: (bloc) => bloc.add(createDummyButtonPress(name: ''),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.nameError, isA<RegisterNameEmptyError>());
        }
      );
      blocTest("Username empty test",
        build: () => RegisterBloc(mockRegisterUsecase),
        act: (bloc) => bloc.add(createDummyButtonPress(username: ''),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.usernameError, isA<RegisterUsernameEmptyError>());
        }
      );
      blocTest("Password empty test",
        build: () => RegisterBloc(mockRegisterUsecase),
        act: (bloc) => bloc.add(createDummyButtonPress(password: ''),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.passwordError, isA<RegisterPasswordEmptyError>());
        }
      );
      group('Password Format test', (){
        //At least 12 characters long but 14 or more is better.
        //
        // A combination of uppercase letters, lowercase letters, numbers, and symbols.
        blocTest("Password less than 12 characters test",
          build: () => RegisterBloc(mockRegisterUsecase),
          act: (bloc) => bloc.add(createDummyButtonPress(password: '12345'),),
          expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
          verify: (bloc) {
            final state = bloc.state as RegisterValidationError;
            expect(state.passwordError, isA<RegisterPasswordFormatError>());
            var registerPasswordFormatError = state.passwordError as RegisterPasswordFormatError;
            expect(registerPasswordFormatError.reason, RegisterPasswordFormatErrorReason.length);
          }
        );
        blocTest("Password more than 20 characters test",
          build: () => RegisterBloc(mockRegisterUsecase),
          act: (bloc) => bloc.add(createDummyButtonPress(password: '123456789012345678901'),),
          expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
          verify: (bloc) {
            final state = bloc.state as RegisterValidationError;
            expect(state.passwordError, isA<RegisterPasswordFormatError>());
            var registerPasswordFormatError = state.passwordError as RegisterPasswordFormatError;
            expect(registerPasswordFormatError.reason, RegisterPasswordFormatErrorReason.length);
          }
        );
        blocTest("Password without number test",
          build: () => RegisterBloc(mockRegisterUsecase),
          act: (bloc) => bloc.add(createDummyButtonPress(password: 'abcxyzpqrabc'),),
          expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
          verify: (bloc) {
            final state = bloc.state as RegisterValidationError;
            expect(state.passwordError, isA<RegisterPasswordFormatError>());
            var registerPasswordFormatError = state.passwordError as RegisterPasswordFormatError;
            expect(registerPasswordFormatError.reason, RegisterPasswordFormatErrorReason.number);
          }
        );
        blocTest("Password without letter test",
          build: () => RegisterBloc(mockRegisterUsecase),
          act: (bloc) => bloc.add(createDummyButtonPress(password: '123456789012'),),
          expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
          verify: (bloc) {
            final state = bloc.state as RegisterValidationError;
            expect(state.passwordError, isA<RegisterPasswordFormatError>());
            var registerPasswordFormatError = state.passwordError as RegisterPasswordFormatError;
            expect(registerPasswordFormatError.reason, RegisterPasswordFormatErrorReason.lowercase);
          }
        );
        blocTest("Password without uppercase letter test",
          build: () => RegisterBloc(mockRegisterUsecase),
          act: (bloc) => bloc.add(createDummyButtonPress(password: '123456abcdef'),),
          expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
          verify: (bloc) {
            final state = bloc.state as RegisterValidationError;
            expect(state.passwordError, isA<RegisterPasswordFormatError>());
            var registerPasswordFormatError = state.passwordError as RegisterPasswordFormatError;
            expect(registerPasswordFormatError.reason, RegisterPasswordFormatErrorReason.uppercase);
          }
        );
        blocTest('Password without lowercase letter test',
          build: () => RegisterBloc(mockRegisterUsecase),
          act: (bloc) => bloc.add(createDummyButtonPress(password: '123456789ABC'),),
          expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
          verify: (bloc) {
            final state = bloc.state as RegisterValidationError;
            expect(state.passwordError, isA<RegisterPasswordFormatError>());
            var registerPasswordFormatError = state.passwordError as RegisterPasswordFormatError;
            expect(registerPasswordFormatError.reason, RegisterPasswordFormatErrorReason.lowercase);
          }
        );
        blocTest("Password without special character test",
          build: () => RegisterBloc(mockRegisterUsecase),
          act: (bloc) => bloc.add(createDummyButtonPress(password: '123456AbcXyz'),),
          expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
          verify: (bloc) {
            final state = bloc.state as RegisterValidationError;
            expect(state.passwordError, isA<RegisterPasswordFormatError>());
            var registerPasswordFormatError = state.passwordError as RegisterPasswordFormatError;
            expect(registerPasswordFormatError.reason, RegisterPasswordFormatErrorReason.spacialCharacter);
          }
        );
      });

      blocTest("Confirm password empty test",
        build: () => RegisterBloc(mockRegisterUsecase),
        act: (bloc) => bloc.add(createDummyButtonPress(confirmPassword: ''),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.confirmPasswordError, isA<RegisterConfirmPasswordEmptyError>());
        }
      );
      blocTest("Email empty test",
        build: () => RegisterBloc(mockRegisterUsecase),
        act: (bloc) => bloc.add(createDummyButtonPress(email: ''),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.emailError, isA<RegisterEmailEmptyError>());
        }
      );
      blocTest("Phone empty test",
        build: () => RegisterBloc(mockRegisterUsecase),
        act: (bloc) => bloc.add(createDummyButtonPress(phone: ''),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.phoneError, isA<RegisterPhoneEmptyError>());
        }
      );
      blocTest("Confirm password not match test",
        build: () => RegisterBloc(mockRegisterUsecase),
        act: (bloc) => bloc.add(createDummyButtonPress(password: 'admin',confirmPassword: 'fake'),),
        expect: () => [isA<RegisterLoading>(), isA<RegisterValidationError>()],
        verify: (bloc) {
          final state = bloc.state as RegisterValidationError;
          expect(state.confirmPasswordError, isA<RegisterConfirmPasswordNotMatch>());
        }
      );
    });
  });
}