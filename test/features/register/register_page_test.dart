import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/features/register/register_bloc.dart';
import 'package:green_bank/features/register/register_page.dart';
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

void main(){
  MockRegisterUsecase mockRegisterUsecase = MockRegisterUsecase();

  testWidgets("Register success test", (WidgetTester tester) async {
    when(mockRegisterUsecase.execute(any)).thenAnswer((_) async => true);
    await tester.pumpWidget(BlocProvider(create: (context) => RegisterBloc(mockRegisterUsecase), child: const MaterialApp(home: RegisterPage())));
    await tester.enterText(find.byKey(const Key('nameInput')), 'test');
    await tester.enterText(find.byKey(const Key('usernameInput')), 'admin');
    await tester.enterText(find.byKey(const Key('passwordInput')), 'Password123!');
    await tester.enterText(find.byKey(const Key('confirmPasswordInput')), 'Password123!');
    await tester.enterText(find.byKey(const Key('emailInput')), 'test@gmail.com');
    await tester.enterText(find.byKey(const Key('phoneInput')), '0123456789');
    await tester.tap(find.byKey(const Key('registerButton')));
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    final Finder snackBarTitleMatcher = find.byKey(const Key('snackBarTitle'));
    expect(snackBarTitleMatcher, findsOneWidget);
    final String snackBarTitleText = tester.widget<Text>(snackBarTitleMatcher).data!;
    print('Snackbar title: $snackBarTitleText');
    const String startText = RegisterSnackBarMessages.registerSuccess;
    expect(snackBarTitleText.contains(startText), true, reason: "Snack bar title ($snackBarTitleText) should start with '$startText'");
  });
  testWidgets("Register failure test", (WidgetTester tester) async {
    when(mockRegisterUsecase.execute(any)).thenAnswer((_) async => false);
    await tester.pumpWidget(BlocProvider(create: (context) => RegisterBloc(mockRegisterUsecase), child: const MaterialApp(home: RegisterPage())));
    await tester.enterText(find.byKey(const Key('nameInput')), 'test');
    await tester.enterText(find.byKey(const Key('usernameInput')), 'admin');
    await tester.enterText(find.byKey(const Key('passwordInput')), 'Password123!');
    await tester.enterText(find.byKey(const Key('confirmPasswordInput')), 'Password123!');
    await tester.enterText(find.byKey(const Key('emailInput')), 'test@gmail.com');
    await tester.enterText(find.byKey(const Key('phoneInput')), '0123456789');
    await tester.tap(find.byKey(const Key('registerButton')));
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    final Finder snackBarTitleMatcher = find.byKey(const Key('snackBarTitle'));
    expect(snackBarTitleMatcher, findsOneWidget);
    final String snackBarTitleText = tester.widget<Text>(snackBarTitleMatcher).data!;
    const String startText = RegisterSnackBarMessages.registerFailed;
    expect(snackBarTitleText.contains(startText), true, reason: "Snack bar title ($snackBarTitleText) should start with '$startText'");

  });
}