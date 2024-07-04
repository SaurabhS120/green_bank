import 'package:flutter/material.dart';
import 'package:green_bank/ui/snackbar/app_snack_bar.dart';


class SnackBarFactoryImpl extends SnackBarFactory{
  const SnackBarFactoryImpl();
  @override
  SnackBarShower createSnackBar(SnackBarType type){
    switch(type){
      case SnackBarType.success:
        return SuccessSnackBarShower();
      case SnackBarType.error:
        return ErrorSnackBarShower();
      case SnackBarType.warning:
        return WarningSnackBarShower();
    }
  }
}

abstract class DefaultSnackBarShower extends SnackBarShower{
  @override
  void showSnackBar(BuildContext context, {required String message,}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(key:const Key('snackBarTitle'),message),
        backgroundColor: getColor(),
      ),
    );
  }
  Color getColor();
}

class SuccessSnackBarShower extends DefaultSnackBarShower{
  @override
  Color getColor() => Colors.green;
}
class ErrorSnackBarShower extends DefaultSnackBarShower{
  @override
  Color getColor() => Colors.red;
}
class WarningSnackBarShower extends DefaultSnackBarShower{
  @override
  Color getColor() => Colors.yellow;
}