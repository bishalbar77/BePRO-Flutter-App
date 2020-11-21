import 'package:flutter/cupertino.dart';

class Sign {
  String name;
  String phone;
  String password;
  String email;
  String type;

  Sign ({
    @required this.name,
    @required this.phone,
    @required this.password,
    @required this.email,
    @required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone" : phone,
      "password": password,
      "email" : email,
      "type": type,
    };
  }
  factory Sign.fromJson(Map<String, dynamic> item) {
    return Sign(
        name: item['name'],
        phone: item['phone'],
        password: item['password'],
        email: item['email'],
        type: item['type']
    );
  }
}