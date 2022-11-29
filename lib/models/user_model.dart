class UserModel {
  String? name;
  String? email;
  String? img;
  String? phone;

  UserModel({this.name, this.email, this.img, this.phone});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    img = json['img'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['img'] = this.img;
    data['phone'] = this.phone;
    return data;
  }
}