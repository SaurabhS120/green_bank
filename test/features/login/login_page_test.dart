import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/domain/usecase/login/login_dummy_usecase.dart';
import 'package:green_bank/features/login/login_bloc.dart';
import 'package:green_bank/features/login/login_page.dart';

void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Login success test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (context) => LoginBloc(LoginDummyUsecase()),
        child: const LoginPage(),
      ),
    ));
    await tester.enterText(find.byKey(const Key('usernameInput')), 'admin');
    await tester.enterText(find.byKey(const Key('passwordInput')), 'admin');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    final Finder snackBarTitleMatcher = find.byKey(const Key('snackBarTitle'));
    expect(snackBarTitleMatcher, findsOneWidget);
    final String snackBarTitleText = tester.widget<Text>(snackBarTitleMatcher).data!;
    const String startText = 'Login successful';
    expect(snackBarTitleText.contains(startText), true, reason: "Snackbar title ($snackBarTitleText) should start with '$startText'");
  });
  testWidgets('Login fail test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BlocProvider(
        create: (context) => LoginBloc(LoginDummyUsecase()),
        child: const LoginPage(),
      ),
    ));
    await tester.enterText(find.byKey(const Key('usernameInput')), 'fail');
    await tester.enterText(find.byKey(const Key('passwordInput')), 'fail');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
    final Finder snackBarTitleMatcher = find.byKey(const Key('snackBarTitle'));
    expect(snackBarTitleMatcher, findsOneWidget);
    final String snackBarTitleText = tester.widget<Text>(snackBarTitleMatcher).data!;
    const String startText = 'Login failed:';
    expect(snackBarTitleText.contains('Login failed:'), true, reason: "Snackbar title ($snackBarTitleText) should start with '$startText'");
  });
}