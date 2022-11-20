import 'package:chat_app/ui/user/login_page.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) =>  MaterialApp(
        title: 'Chat App',
        theme: ThemeData(
          primarySwatch: Colors.blue,

        ),
        home: LoginPage(),
      ),
    );
  }
}
