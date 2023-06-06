import 'package:bloc/bloc.dart';
import 'package:chat_app/commanUtils/const.dart';
import 'package:chat_app/models/caht_messages.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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
        .orderBy(CONST.createdAt, descending: true)
        .snapshots()
        .listen((event) {
      List<MessageModel> messagesList = [];

      for (var doc in event.docs) {
        messagesList.add(MessageModel.fromJson(doc));
      }

      emit(ChatSuccess(messagesList: messagesList));
    });
  }

  void sendChatMessage(String content, int type, String groupChatId,
      String currentUserId, String peerId) {
    DocumentReference documentReference = firebaseFirestore
        .collection("messages")
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());
    ChatMessages chatMessages = ChatMessages(
        idFrom: currentUserId,
        idTo: peerId,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        content: content,
        type: type);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatMessages.toJson());
    });
  }

  getChatMessages(String groupChatId, int limit) {
    return firebaseFirestore
        .collection("messages")
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy("timestamp", descending: true)
        .limit(limit)
        .snapshots();
  }

  Future<void> updateFirestoreData(
      String collectionPath, String docPath, Map<String, dynamic> dataUpdate) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(docPath)
        .update(dataUpdate);
  }
}
