import 'package:chat_app/res/colors.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({Key? key}) : super(key: key);



  CollectionReference messages = FirebaseFirestore.instance.collection("messages");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
        backgroundColor: MColors.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => ChatBubble(msg: "Hey i am anas"),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Send Message",
                  suffixIcon: Icon(Icons.send, color: MColors.primaryColor),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: MColors.primaryColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: MColors.primaryColor)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: MColors.primaryColor))),
            ),
          ),
        ],
      ),
    );
  }
}
