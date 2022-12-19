import 'package:chat_app/commanUtils/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/res/colors.dart';
import 'package:chat_app/ui/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({required this.email});

  String email;
  String message = "";
  bool isLoading = true;

  List<MessageModel> messagesList = [];

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
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatLoading) {
                  isLoading = true;
                } else if (state is ChatSuccess) {
                  messagesList = state.messagesList;
                  isLoading = false;
                }
              },
              builder: (context, state) {
                return !isLoading
                    ? ListView.builder(
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        controller: BlocProvider.of<ChatCubit>(context)
                            .scrollController,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return ChatBubble(
                              msg: messagesList[index],
                              color: messagesList[index].email == email
                                  ? MColors.primaryColor
                                  : Colors.red);
                        },
                      )
                    : Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
            child: TextField(
              controller: BlocProvider.of<ChatCubit>(context).controller,
              onSubmitted: (msg) {
                if(msg != "") {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMessage(msg: msg, email: email);
                  message = "";
                }
              },
              onChanged: (msg)=> message = msg,
              decoration: InputDecoration(
                  hintText: "Send Message",
                  suffixIcon: GestureDetector(
                      onTap: () {
                        if(message !="") {
                          BlocProvider.of<ChatCubit>(context)
                              .sendMessage(msg: message, email: email);
                          message = "";
                        }
                      },
                      child: Icon(Icons.send, color: MColors.primaryColor)),
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
