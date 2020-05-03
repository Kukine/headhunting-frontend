
import 'dart:convert';

import 'package:flutter/widgets.dart';

class User{

  User({
    this.id,
    @required this.name,
    @required this.surname,
    @required this.email,
    @required this.password,
  });

  final String id;
  final String name;
  final String surname;
  final String email;
  final String password;

  String toJson() => jsonEncode({
    'id' : id,
    'name': name,
    'surname' : surname,
    'email' : email,
    'password' : password 
  });


  User fromJson(String jsonString){
    Map<String,dynamic> userMap = jsonDecode(jsonString);
    return User(
      id: userMap['id'].toString(),
      name: userMap['name'],
      surname: userMap['surname'],
      email: userMap['email'],
      password: userMap['password']
    );

  }
}