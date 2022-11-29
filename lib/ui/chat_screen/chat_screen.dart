import 'package:chat_app/commanUtils/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/res/colors.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({required this.email});

  String email;

  String msgTime = DateFormat.jm().format(DateTime.now());
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(CONST.messagesCollection);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(CONST.createdAt,descending: true).snapshots(),
        builder: (context, snapshot) {
          List<MessageModel> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(MessageModel.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Chat"),
              centerTitle: true,
              backgroundColor: MColors.primaryColor,
            ),
            body: snapshot.hasData
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: _scrollController,
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            print("focus here: email from const $email and firebase email is ${messageList[index].email}");
                            return ChatBubble(msg: messageList[index],
                                color: email == "anas@gmail.com" ? MColors.primaryColor: Colors.red );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 2.w),
                        child: TextField(
                          controller: _controller,
                          onSubmitted: (val) {
                            messages.add({
                              "msg": val,
                              CONST.createdAt: DateTime.now(),
                              "email":email
                            });
                            _controller.clear();
                            _scrollController.jumpTo(0);

                          },
                          decoration: InputDecoration(
                              hintText: "Send Message",
                              suffixIcon:
                                  Icon(Icons.send, color: MColors.primaryColor),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: MColors.primaryColor)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: MColors.primaryColor)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide:
                                      BorderSide(color: MColors.primaryColor))),
                        ),
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          );
        });
  }
}
