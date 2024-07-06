import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class AppSnackBarTestHelper{
  static void verifySnackBarTitle(WidgetTester tester, {required String titleStartsWith}){
    expect(find.byType(SnackBar), findsOneWidget);
    final Finder snackBarTitleMatcher = find.byKey(const Key('snackBarTitle'));
    expect(snackBarTitleMatcher, findsOneWidget);
    final String snackBarTitleText =
    tester.widget<Text>(snackBarTitleMatcher).data!;
    expect(snackBarTitleText.contains(titleStartsWith), true,
        reason:
        "Snack bar title ($snackBarTitleText) should start with '$titleStartsWith'");
  }
}