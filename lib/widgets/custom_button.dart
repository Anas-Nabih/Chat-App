import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    required this.text,
  }) ;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1.w)),
      child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
          )),
    );
  }
}