import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? displayName;
  String? email;
  String? photoUrl;
  String? phone;

  UserModel({this.id, this.displayName, this.email, this.photoUrl, this.phone});

  UserModel.fromJson(json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    displayName = json['displayName'];
    photoUrl = json['photoUrl'];
   }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['phone'] = phone;
    data['displayName'] = displayName;
    data['photoUrl'] = photoUrl;
    return data;
  }
}
