import 'package:flutter/material.dart';

class Utils{
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar({required BuildContext context,required String msg}){
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}