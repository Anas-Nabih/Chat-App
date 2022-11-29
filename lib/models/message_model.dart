import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? msg;
  Timestamp? createdAt;
  String? email;

  MessageModel({this.msg, this.createdAt});

  MessageModel.fromJson(json) {
    msg = json['msg'];
    createdAt = json['createdAt'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['createdAt'] = this.createdAt;
    data['email'] = this.email;
    return data;
  }
}