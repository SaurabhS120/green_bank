
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/domain/usecase/login/login_dummy_usecase.dart';
import 'package:green_bank/features/login/login_bloc.dart';
import 'package:green_bank/features/login/login_page.dart';

import '../../ui/snackbar/app_snack_bar_test_helper.dart';

class LoginTestPage extends StatelessWidget{
  const LoginTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => LoginBloc(LoginDummyUsecase()),
        child: const LoginPage(),
      ),
    );
  }
}
Future<void> enterLoginDetails(WidgetTester tester,
    {required String username, required String password}) async {
  await tester.enterText(find.byKey(const Key('usernameInput')), username);
  await tester.enterText(find.byKey(const Key('passwordInput')), password);
}
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Login success test', (WidgetTester tester) async {
    await tester.pumpWidget(const LoginTestPage());
    await enterLoginDetails(tester, username: 'admin', password: 'admin');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();

    const String startText = 'Login successful';
    AppSnackBarTestHelper.verifySnackBarTitle(tester, titleStartsWith: startText);
  });
  testWidgets('Login fail test', (WidgetTester tester) async {
    await tester.pumpWidget(const LoginTestPage());
    await enterLoginDetails(tester, username: 'fail', password: 'fail');
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pump();
    const String startText = 'Login failed:';
    AppSnackBarTestHelper.verifySnackBarTitle(tester, titleStartsWith: startText);
  });
}