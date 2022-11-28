import 'package:chat_app/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({required this.msg});

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 25.w),
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
            color: MColors.primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
              topRight: Radius.circular(12),
            )
        ),
        child: Text(msg, style: TextStyle(
            color: Colors.white, fontSize: 12.sp
        ),),
      ),
    );
  }
}