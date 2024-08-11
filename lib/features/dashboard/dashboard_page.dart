import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:green_bank/features/dashboard/user_details_bloc.dart';
import 'package:green_bank/ui/app_loader.dart';
import 'package:green_bank/ui/card/card_widget.dart';
import 'package:green_bank/utils/assets.dart';

class DashboardPage extends StatefulWidget{
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UserDetailsBloc,UserDetailsBlocState>(
      listener: (BuildContext context, state) {
        if(state is UserDetailsLoadingBlocState){
          showDialog(
              context: context,
              builder: (context)=>const AppLoader(),
              barrierDismissible: false,
          );
        }else if(state is UserDetailsSuccessBlocState){
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar:
        AppBar(
          backgroundColor: Colors.green,
          title: BlocBuilder<UserDetailsBloc,UserDetailsBlocState>(
              builder: (context,state){
                String name = "User";
                if(state is UserDetailsSuccessBlocState){
                  name = state.name;
                }
                return Text(key: const Key("user-greet"),"Hello, $name");
              }
          ),
        ),
        body: Column(
          children: [
            AspectRatio(

              aspectRatio: 2.1,
              child: CarouselSlider(
                items: [
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                ], options: CarouselOptions(),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

