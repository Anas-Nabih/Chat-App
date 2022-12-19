import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class DoNotHaveAccount extends StatelessWidget {
  const DoNotHaveAccount({required this.onTapped}) ;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  onTapped ,
      child: Text.rich(TextSpan(
          text: "don't have an account?\t",
          style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400),
          children: [
            TextSpan(
                text: "Sigin Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600))
          ])),
    );
  }
}
