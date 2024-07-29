import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_bank/domain/model/user_details_model.dart';
import 'package:green_bank/features/dashboard/dashboard_page.dart';
import 'package:green_bank/features/dashboard/user_details_bloc.dart';
import 'package:mockito/mockito.dart';

import 'user_details_bloc_test.mocks.dart';

class DashboardPageTestWidget extends StatelessWidget{
  final MockGetUserDetailsUsecase getUserDetailsUsecase;

  const DashboardPageTestWidget({super.key, required this.getUserDetailsUsecase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context){
          final bloc = UserDetailsBloc(getUserDetailsUsecase: getUserDetailsUsecase);
          bloc.add(FetchUserDetailsBlocEvent());
          return bloc;
        },
        child: const DashboardPage(),
      ),
    );
  }

}
void main(){
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockGetUserDetailsUsecase mockGetUserDetailsUsecase;
  setUpAll((){
    mockGetUserDetailsUsecase = MockGetUserDetailsUsecase();
  });
  testWidgets("Name success test", (WidgetTester tester) async {
    when(mockGetUserDetailsUsecase.execute()).thenAnswer((invocation) async => const UserDetailsModel(name: "admin"));
    await tester.pumpWidget(DashboardPageTestWidget(getUserDetailsUsecase: mockGetUserDetailsUsecase));
    await tester.pumpAndSettle();
    const userGreetKey = Key("user-greet");
    expect(find.byKey(userGreetKey),findsOneWidget);
    expect(tester.widget(find.byKey(userGreetKey)),isA<Text>());
    final userGreetWidget = tester.widget<Text>(find.byKey(userGreetKey));
    expect(userGreetWidget.data,"Hello,admin");
  });
}