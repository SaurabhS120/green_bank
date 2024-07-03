import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bank/domain/usecase/login/login_usecase.dart';
import 'package:green_bank/features/login/login_bloc.dart';
import 'package:green_bank/features/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Green Bank',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: RepositoryProvider(
        create: (context) => LoginUsecase(),
        child: BlocProvider(
          create: (context) => LoginBloc(context.read<LoginUsecase>()),
          child: const LoginPage(),
        ),
      ),
    );
  }
}