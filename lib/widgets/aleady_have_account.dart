import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({required this.onTapped});
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Text.rich(TextSpan(
          text: "already have an account?\t",
          style: TextStyle(
              color: Colors.white,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400),
          children: [
            TextSpan(
                text: "Sigin in",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600))
          ])),
    );
  }
}
