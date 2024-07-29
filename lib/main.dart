import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bank/data/repo_impl/user_details_repo_impl.dart';
import 'package:green_bank/domain/repo/user_details_repo.dart';
import 'package:green_bank/domain/usecase/login/login_usecase.dart';
import 'package:green_bank/domain/usecase/register/register_usecase.dart';
import 'package:green_bank/domain/usecase/user_details/get_user_details_usecase.dart';
import 'package:green_bank/features/dashboard/dashboard_page.dart';
import 'package:green_bank/features/dashboard/user_details_bloc.dart';
import 'package:green_bank/features/login/login_bloc.dart';
import 'package:green_bank/features/login/login_page.dart';
import 'package:green_bank/features/register/register_bloc.dart';
import 'package:green_bank/features/register/register_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<LoginUsecase>(
          create: (context) => LoginUsecase(),
        ),
        RepositoryProvider<RegisterUsecase>(
          create: (context) => RegisterUsecase(),
        ),
        RepositoryProvider<UserDetailsRepo>(create: (context)=>UserDetailsRepoImpl()),
        RepositoryProvider<GetUserDetailsUsecase>(
          create: (context) => GetUserDetailsUsecase(repo: context.read<UserDetailsRepo>()),
        ),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(context.read<LoginUsecase>()),
            ),
            BlocProvider<RegisterBloc>(
              create: (context) => RegisterBloc(context.read<RegisterUsecase>()),
            ),
            BlocProvider<UserDetailsBloc>(
              create: (context){
                final bloc = UserDetailsBloc(getUserDetailsUsecase:context.read<GetUserDetailsUsecase>());
                return bloc;
              },
            ),
          ],
          child:MaterialApp(
            title: 'Green Bank',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            routes: {
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/dashboard': (context) => const DashboardPage(),
            },
            initialRoute: '/login',
          ),
      ),
    );
  }
}