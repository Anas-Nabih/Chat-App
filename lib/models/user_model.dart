import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? name;
  String? email;
  String? img;
  String? phone;
  String? lastMSG;
  Timestamp? lastMSGTime;

  UserModel({this.name, this.email, this.img, this.phone});

  UserModel.fromJson(json) {
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    img = json['img'];
    lastMSG = json['lastMsg'];
    lastMSGTime = json['lastMsgTime'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['img'] = this.img;
    data['phone'] = this.phone;
    data['lastMsg'] = this.lastMSG;
    data['lastMsgTime'] = this.lastMSGTime;
    return data;
  }
}