import 'package:chat_app/commanUtils/utils.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/res/colors.dart';
import 'package:chat_app/ui/chat_screen/chat_screen.dart';
import 'package:chat_app/ui/user/login_page.dart';
import 'package:chat_app/widgets/user_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MColors.primaryColor,
        title: Text("Users Screen"),
        actions: [
          GestureDetector(
              onTap: () {
                Utils.push(
                    context: context,
                    navigationScreen: LoginPage(),
                    replace: true);
                FirebaseAuth.instance.signOut();
              },
              child: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          List<UserModel> users = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            users.add(UserModel.fromJson(snapshot.data!.docs![i]));
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => UserItem(
                onTapped: () => Utils.push(
                    context: context,
                    navigationScreen: ChatScreen(email: users[index].email!)),
                userName: users[index].displayName!,
                userIMG: users[index].photoUrl!,
                lastMSG: "users[index].lastMSG!",
              ),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
