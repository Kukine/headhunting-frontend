import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:headhunting_flutter/models/skill.dart';

class Employee{

  int id;
  String name;
  String surname;
  String email;
  String password;
  List<Skill> skills;

  Employee({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.skills
  });

  String toJson() {
    List<String> skills = this.skills != null ? this.skills.map((i) => i.toJson()).toList() : null;

    return jsonEncode({'id' : id,
    'name' : name,
    'surname' : surname,
    'email' : email,
    'password' : password,
    'skills' : skills
    });

  }

  factory Employee.fromJson(dynamic json){
    if(json['skills'] != null){
      var skillObjsJson = json['skills'] as List;
      List<Skill> _skills = skillObjsJson.map((skillJson) => Skill.fromJson(skillJson)).toList();

      return Employee(
        id : json['id'],
        name : json['name'],
        surname: json['surname'],
        email: json['email'],
        password: json['password'],
        skills: _skills
      );
    }
    else{
      return Employee(
        id : json['id'],
        name : json['name'],
        surname: json['surname'],
        email: json['email'],
        password: json['password']);
    }
  }
}