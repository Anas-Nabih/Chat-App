import 'package:bloc/bloc.dart';
import 'package:chat_app/commanUtils/const.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  CollectionReference messages =
      FirebaseFirestore.instance.collection(CONST.messagesCollection);

  sendMessage({required String msg, required String email}) {
    messages.add({"msg": msg, CONST.createdAt: DateTime.now(), "email": email});
     controller.clear();
   scrollController.jumpTo(0);
  }

  getMessages() {
    emit(ChatLoading());
    messages
        .orderBy(CONST.createdAt, descending: true).snapshots().listen((event) {
      List<MessageModel> messagesList = [];

      for (var doc in event.docs) {
        messagesList.add(MessageModel.fromJson(doc));
      }

      emit(ChatSuccess(messagesList: messagesList));
    });
  }
}
