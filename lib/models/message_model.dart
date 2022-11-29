import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? msg;
  Timestamp? createdAt;

  MessageModel({this.msg, this.createdAt});

  MessageModel.fromJson(json) {
    msg = json['msg'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['createdAt'] = this.createdAt;
    return data;
  }
}