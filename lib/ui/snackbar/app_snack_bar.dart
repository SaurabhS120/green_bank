import 'package:flutter/material.dart';
import 'package:green_bank/ui/snackbar/app_snack_bar_impl.dart';
import 'package:green_bank/ui/snackbar/app_snack_bar_types.dart';
export 'package:green_bank/ui/snackbar/app_snack_bar_types.dart';

class AppSnackBar{
  static const SnackBarFactory _snackBarFactory = SnackBarFactoryImpl();
  static showSnackBar(BuildContext context, {required String message, required SnackBarType type}){
    SnackBarShower snackBarShower = _snackBarFactory.createSnackBar(type);
    snackBarShower.showSnackBar(context, message: message);
  }
}
abstract class SnackBarFactory{
  const SnackBarFactory();
  SnackBarShower createSnackBar(SnackBarType type);
}
abstract class SnackBarShower{
  void showSnackBar(BuildContext context, {required String message,});
}