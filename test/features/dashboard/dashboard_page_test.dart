import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/domain/model/user_details_model.dart';
import 'package:green_bank/features/dashboard/dashboard_page.dart';
import 'package:green_bank/features/dashboard/user_details_bloc.dart';
import 'package:green_bank/ui/app_loader.dart';
import 'package:mockito/mockito.dart';

import 'user_details_bloc_test.mocks.dart';

class DashboardPageTestWidget extends StatelessWidget {
  final UserDetailsBloc userDetailsBloc;

  const DashboardPageTestWidget({super.key, required this.userDetailsBloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => userDetailsBloc,
        child: const DashboardPage(),
      ),
    );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Name success test", (WidgetTester tester) async {
    MockGetUserDetailsUsecase mockGetUserDetailsUsecase = MockGetUserDetailsUsecase();
    UserDetailsBloc userDetailsBloc = UserDetailsBloc(getUserDetailsUsecase: mockGetUserDetailsUsecase);
    DashboardPageTestWidget testPage = DashboardPageTestWidget(userDetailsBloc: userDetailsBloc,);
    when(mockGetUserDetailsUsecase.execute()).thenAnswer((_) async => const UserDetailsModel(name: "admin"));
    await tester.pumpWidget(testPage);
    testPage.userDetailsBloc.add(FetchUserDetailsBlocEvent());
    await tester.pumpAndSettle(); // Wait for all animations and frames to settle

    const userGreetKey = Key("user-greet");
    expect(find.byKey(userGreetKey), findsOneWidget);
    expect(tester.widget(find.byKey(userGreetKey)), isA<Text>());
    final userGreetWidget = tester.widget<Text>(find.byKey(userGreetKey));
    expect(userGreetWidget.data, "Hello, admin");
  });

  testWidgets('Login Loader test', (WidgetTester tester) async {
    MockGetUserDetailsUsecase mockGetUserDetailsUsecase = MockGetUserDetailsUsecase();
    Future<UserDetailsModel> call = Future.delayed(const Duration(seconds: 1), () => const UserDetailsModel(name: 'admin'));
    when(mockGetUserDetailsUsecase.execute()).thenAnswer((_) => call);
    UserDetailsBloc userDetailsBloc = UserDetailsBloc(getUserDetailsUsecase: mockGetUserDetailsUsecase);
    DashboardPageTestWidget testPage = DashboardPageTestWidget(userDetailsBloc: userDetailsBloc,);
    await tester.pumpWidget(testPage);
    testPage.userDetailsBloc.add(FetchUserDetailsBlocEvent());

    // Use pump and settle to wait for the future to complete
    await tester.pump(); // Start the animation frame
    expect(find.byType(AppLoader), findsOneWidget);

    await tester.pumpAndSettle(); // Allow all timers and animations to complete
  });
}
