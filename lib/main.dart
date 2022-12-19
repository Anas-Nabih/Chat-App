import 'package:chat_app/ui/chat_screen/chat_screen.dart';
import 'package:chat_app/ui/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/ui/cubit/login_cubit/login_cubit.dart';
import 'package:chat_app/ui/cubit/register_cubit/register_cubit.dart';
import 'package:chat_app/ui/user/login_page.dart';
import 'package:chat_app/ui/users_screen/users_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => LoginCubit()),
              BlocProvider(create: (context) => RegisterCubit()),
              BlocProvider(create: (context) => ChatCubit()),
            ],
            child: MaterialApp(
              title: 'Chat App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: LoginPage(),
            ),
          ),
    );
  }
}
