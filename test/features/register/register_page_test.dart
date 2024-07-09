import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/features/register/register_bloc.dart';
import 'package:green_bank/features/register/register_page.dart';
import 'package:green_bank/ui/app_loader.dart';
import 'package:mockito/mockito.dart';

import '../../ui/snackbar/app_snack_bar_test_helper.dart';
import 'register_bloc_test.mocks.dart';

RegisterButtonPressed createDummyButtonPress({
  String name = 'test',
  String username = 'admin',
  String password = 'Password123!',
  String confirmPassword = 'Password123!',
  String email = 'test@gmail.com',
  String phone = '0123456789',
}) {
  return RegisterButtonPressed(
    name: name,
    username: username,
    password: password,
    confirmPassword: confirmPassword,
    email: email,
    phone: phone,
  );
}

class RegisterTestWidget extends StatelessWidget {
  final RegisterBloc registerBloc;

  const RegisterTestWidget({super.key, required this.registerBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider.value(
        value: registerBloc,
        child: const RegisterPage(),
      ),
    );
  }
}

void main() {
  MockRegisterUsecase mockRegisterUsecase = MockRegisterUsecase();

  testWidgets("Register loader test", (WidgetTester tester) async {
    when(mockRegisterUsecase.execute(any)).thenAnswer((_) async => Future.delayed(const Duration(milliseconds: 1),()=>true));
    await tester.pumpWidget(
        RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
    await enterRegistrationDetails(tester);
    await tester.tap(find.byKey(const Key('registerButton')));
    await tester.pump();
    expect(find.byType(AppLoader), findsOneWidget);
    await tester.pumpAndSettle();
  });

  testWidgets("Register success test", (WidgetTester tester) async {
    when(mockRegisterUsecase.execute(any)).thenAnswer((_) async => true);
    await tester.pumpWidget(
        RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
    await enterRegistrationDetails(tester);
    await tester.tap(find.byKey(const Key('registerButton')));
    await tester.pump();
    AppSnackBarTestHelper.verifySnackBarTitle(tester, titleStartsWith: RegisterSnackBarMessages.registerSuccess);
  });
  testWidgets("Register failure test", (WidgetTester tester) async {
    when(mockRegisterUsecase.execute(any)).thenAnswer((_) async => false);
    await tester.pumpWidget(
        RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
    await enterRegistrationDetails(tester);
    await tester.tap(find.byKey(const Key('registerButton')));
    await tester.pump();
    AppSnackBarTestHelper.verifySnackBarTitle(tester, titleStartsWith: RegisterSnackBarMessages.registerFailed);
  });
  group('Validation testing', () {
    group("Name validation", (){
      testWidgets("Name empty test", (WidgetTester tester) async {
        await tester.pumpWidget(
            RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
        await enterRegistrationDetails(tester,name: '');
        await tester.tap(find.byKey(const Key('registerButton')));
        await tester.pump();
        expect(find.text(RegisterErrorMessages.nameEmpty), findsOneWidget);
      });
      testWidgets("Name with numbers error test", (WidgetTester tester) async {
        await tester.pumpWidget(
            RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
        await enterRegistrationDetails(tester,name: 'abc123');
        await tester.tap(find.byKey(const Key('registerButton')));
        await tester.pump();
        expect(find.text(RegisterErrorMessages.nameWithDigitError), findsOneWidget);
      });
      testWidgets("Name with spacial character error test", (WidgetTester tester) async {
        await tester.pumpWidget(
            RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
        await enterRegistrationDetails(tester,name: 'abc!');
        await tester.tap(find.byKey(const Key('registerButton')));
        await tester.pump();
        expect(find.text(RegisterErrorMessages.nameWithSpecialCharacterError), findsOneWidget);
      });
    });
    testWidgets("Username empty test", (WidgetTester tester) async {
      await tester.pumpWidget(
          RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
      await enterRegistrationDetails(tester,username: '');
      await tester.tap(find.byKey(const Key('registerButton')));
      await tester.pump();
      expect(find.text(RegisterErrorMessages.usernameEmpty), findsOneWidget);
    });
    testWidgets("Password empty test", (WidgetTester tester) async {
      await tester.pumpWidget(
          RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
      await enterRegistrationDetails(tester,password: '');
      await tester.tap(find.byKey(const Key('registerButton')));
      await tester.pump();
      expect(find.text(RegisterErrorMessages.passwordEmpty), findsOneWidget);
    });
    group("Password format error tests", (){
      testWidgets("Password less than 12 characters test", (WidgetTester tester) async {
        await tester.pumpWidget(
            RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
        await enterRegistrationDetails(tester,password: '12345');
        await tester.tap(find.byKey(const Key('registerButton')));
        await tester.pump();
        expect(find.text(RegisterErrorMessages.passwordLength), findsOneWidget);
      });
      testWidgets("Password more than 20 characters test", (WidgetTester tester) async {
        await tester.pumpWidget(
            RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
        await enterRegistrationDetails(tester,password: '12345');
        await tester.tap(find.byKey(const Key('registerButton')));
        await tester.pump();
        expect(find.text(RegisterErrorMessages.passwordLength), findsOneWidget);
      });
      testWidgets("Password without number test", (WidgetTester tester) async {
        await tester.pumpWidget(
            RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
        await enterRegistrationDetails(tester,password: 'abcxyzpqrabc');
        await tester.tap(find.byKey(const Key('registerButton')));
        await tester.pump();
        expect(find.text(RegisterErrorMessages.passwordNumber), findsOneWidget);
      });
      testWidgets("Password without uppercase letter test", (WidgetTester tester) async {
        await tester.pumpWidget(
            RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
        await enterRegistrationDetails(tester,password: '123456abcdef');
        await tester.tap(find.byKey(const Key('registerButton')));
        await tester.pump();
        expect(find.text(RegisterErrorMessages.passwordUppercase), findsOneWidget);
      });
      testWidgets("Password without lowercase letter test", (WidgetTester tester) async {
        await tester.pumpWidget(
            RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
        await enterRegistrationDetails(tester,password: '123456789ABC');
        await tester.tap(find.byKey(const Key('registerButton')));
        await tester.pump();
        expect(find.text(RegisterErrorMessages.passwordLowercase), findsOneWidget);
      });
      testWidgets("Password without spacial character test", (WidgetTester tester) async {
        await tester.pumpWidget(
            RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
        await enterRegistrationDetails(tester,password: '123456AbcXyz');
        await tester.tap(find.byKey(const Key('registerButton')));
        await tester.pump();
        expect(find.text(RegisterErrorMessages.passwordSpecialCharacter), findsOneWidget);
      });
    });
    testWidgets("Confirm password empty test", (WidgetTester tester) async {
      await tester.pumpWidget(
          RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
      await enterRegistrationDetails(tester,confirmPassword: '');
      await tester.tap(find.byKey(const Key('registerButton')));
      await tester.pump();
      expect(find.text(RegisterErrorMessages.confirmPasswordEmpty),
          findsOneWidget);
    });
    testWidgets("Email empty test", (WidgetTester tester) async {
      await tester.pumpWidget(
          RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
      await enterRegistrationDetails(tester,email: '');
      await tester.tap(find.byKey(const Key('registerButton')));
      await tester.pump();
      expect(find.text(RegisterErrorMessages.emailEmpty), findsOneWidget);
    });
    testWidgets("Phone empty test", (WidgetTester tester) async {
      await tester.pumpWidget(
          RegisterTestWidget(registerBloc: RegisterBloc(mockRegisterUsecase)));
      await enterRegistrationDetails(tester,phone: '');
      await tester.tap(find.byKey(const Key('registerButton')));
      await tester.pump();
      expect(find.text(RegisterErrorMessages.phoneEmpty), findsOneWidget);
    });
  });
}

Future<void> enterRegistrationDetails(WidgetTester tester,{String name = 'test',String username = 'admin',password = 'Password123!',String confirmPassword = 'Password123!',String email = 'test@gmail.com',phone = '0123456789'}) async {
  await tester.enterText(find.byKey(const Key('nameInput')), name);
  await tester.enterText(find.byKey(const Key('usernameInput')), username);
  await tester.enterText(
      find.byKey(const Key('passwordInput')), password);
  await tester.enterText(
      find.byKey(const Key('confirmPasswordInput')), confirmPassword);
  await tester.enterText(
      find.byKey(const Key('emailInput')), email);
  await tester.enterText(find.byKey(const Key('phoneInput')), phone);
}
