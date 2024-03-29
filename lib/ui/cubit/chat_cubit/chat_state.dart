part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  ChatSuccess({required this.messagesList});

  final List<MessageModel> messagesList;
}
