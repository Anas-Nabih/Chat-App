import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Utils{
  static void push({required BuildContext context, required Widget navigationScreen, bool replace = false}){
    if(replace){
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => navigationScreen),(Route route) => false);
      print("remove all routes");
    }else{
      Navigator.push(context, CupertinoPageRoute(builder: (context) => navigationScreen,));
      print("save pervious routes");
    }
  }

  static void pop(BuildContext context){
    Navigator.pop(context);
  }
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({required BuildContext context,required String msg}){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}