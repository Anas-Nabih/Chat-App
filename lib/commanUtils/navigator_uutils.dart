import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorUtils{
  static void push(BuildContext context, Widget widget){
    Navigator.push(context, CupertinoPageRoute(builder: (context) => widget,));
  }

  static void pop(BuildContext context){
    Navigator.pop(context);
  }
}