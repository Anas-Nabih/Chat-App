import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/widgets/user_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UsersScreen extends StatelessWidget {
  UsersScreen({Key? key}) : super(key: key);

  final CollectionReference users = FirebaseFirestore.instance.collection(
      "users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User Screen"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          List<UserModel> users = [];
          for(int i = 0; i<snapshot.data!.docs.length ; i++){
            users.add(UserModel.fromJson(snapshot.data!.docs![i]));
          }
          if (snapshot.hasData) {
            return ListView.builder(itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => UserItem(
                userName: users[index]!.name!,
                userIMG: users[index]!.img!,
                lastMSG: users[index]!.lastMSG!,
              ),);
          } else {
            return CircularProgressIndicator();
          }
        },),
    );
  }
}


