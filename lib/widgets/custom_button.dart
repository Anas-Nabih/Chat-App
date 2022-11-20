import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomBtn extends StatelessWidget {
   CustomBtn({
    this.onTapped,required this.text,
  }) ;

   VoidCallback? onTapped;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped ?? (){},
      child: Container(
        height: 8.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(1.w)),
        child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            )),
      ),
    );
  }
}