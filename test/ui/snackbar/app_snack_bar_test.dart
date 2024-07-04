import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/ui/snackbar/app_snack_bar.dart';
import 'package:green_bank/ui/snackbar/app_snack_bar_impl.dart';

void main() {
  group("Default Snack bar tests", (){
    test("Success snack bar unit test", (){
      const SnackBarType snackBarType = SnackBarType.success;
      SnackBarFactory snackBarFactory = const SnackBarFactoryImpl();
      SnackBarShower snackBarShower = snackBarFactory.createSnackBar(snackBarType);
      expect(snackBarShower, isA<SuccessSnackBarShower>());
    });
    test("Warning snack bar unit test", (){
      const SnackBarType snackBarType = SnackBarType.warning;
      SnackBarFactory snackBarFactory = const SnackBarFactoryImpl();
      SnackBarShower snackBarShower = snackBarFactory.createSnackBar(snackBarType);
      expect(snackBarShower, isA<WarningSnackBarShower>());
    });
    test("Error snack bar unit test", (){
      const SnackBarType snackBarType = SnackBarType.error;
      SnackBarFactory snackBarFactory = const SnackBarFactoryImpl();
      SnackBarShower snackBarShower = snackBarFactory.createSnackBar(snackBarType);
      expect(snackBarShower, isA<ErrorSnackBarShower>());
    });
    testWidgets("Success Snack Bar Test", (WidgetTester tester) async {
      const Key targetKey = Key('showSnackBarButton');
      const String title = "Success";
      const SnackBarType snackBarType = SnackBarType.success;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Builder(builder: (context) {
                return ElevatedButton(
                  key: targetKey,
                  onPressed: () {
                    AppSnackBar.showSnackBar(context,
                        message: title, type: snackBarType);
                  },
                  child: const Text('Show SnackBar'),
                );
              }),
            ),
          ),
        ),
      );
      await tester.tap(find.byKey(targetKey));
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      Finder snackBarTitleFinder = find.byKey(const Key('snackBarTitle'));
      expect(snackBarTitleFinder, findsOneWidget);
      Text snackBarTitleText = tester.widget(snackBarTitleFinder);
      expect(snackBarTitleText.data, title);
    });
    testWidgets("Warning Snack Bar Test", (WidgetTester tester) async {
      const Key targetKey = Key('showSnackBarButton');
      const String title = "Warning";
      const SnackBarType snackBarType = SnackBarType.warning;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Builder(builder: (context) {
                return ElevatedButton(
                  key: targetKey,
                  onPressed: () {
                    AppSnackBar.showSnackBar(context,
                        message: title, type: snackBarType);
                  },
                  child: const Text('Show SnackBar'),
                );
              }),
            ),
          ),
        ),
      );
      await tester.tap(find.byKey(targetKey));
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      Finder snackBarTitleFinder = find.byKey(const Key('snackBarTitle'));
      expect(snackBarTitleFinder, findsOneWidget);
      Text snackBarTitleText = tester.widget(snackBarTitleFinder);
      expect(snackBarTitleText.data, title);
    });
    testWidgets("Error Snack Bar Test", (WidgetTester tester) async {
      const Key targetKey = Key('showSnackBarButton');
      const String title = "Error";
      const SnackBarType snackBarType = SnackBarType.error;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Builder(builder: (context) {
                return ElevatedButton(
                  key: targetKey,
                  onPressed: () {
                    AppSnackBar.showSnackBar(context,
                        message: title, type: snackBarType);
                  },
                  child: const Text('Show SnackBar'),
                );
              }),
            ),
          ),
        ),
      );
      await tester.tap(find.byKey(targetKey));
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      Finder snackBarTitleFinder = find.byKey(const Key('snackBarTitle'));
      expect(snackBarTitleFinder, findsOneWidget);
      Text snackBarTitleText = tester.widget(snackBarTitleFinder);
      expect(snackBarTitleText.data, title);
    });
  });
}
