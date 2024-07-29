import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bank/features/dashboard/user_details_bloc.dart';

class DashboardPage extends StatefulWidget{
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BlocBuilder<UserDetailsBloc,UserDetailsBlocState>(
              builder: (context,state){
                String name = "User";
                if(state is UserDetailsSuccessBlocState){
                  name = state.name;
                }
                return Text(key: const Key("user-greet"),"Hello,$name");
              }
          )
        ],
      ),
    );
  }
}