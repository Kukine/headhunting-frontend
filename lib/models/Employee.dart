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
  String description;
  int type;

  Employee({
    this.id,
    this.name,
    this.surname,
    this.email,
    this.password,
    this.skills,
    this.description,
    this.type
  });

  Map toJson() {
    List<Map> experiences = this.skills != null ? this.skills.map((i) => new Experience(skill : i, years : 1).toJson()).toList() : null;

    return {'id' : id,
    'name' : name,
    'surname' : surname,
    'email' : email,
    'password' : password,
    'experienceList' : experiences,
    'description' : description,
    'type' : 1
    };

  }

  factory Employee.fromJson(dynamic json){
    if(json['experienceList'] != null){
      var experienceObjJson = json['experienceList'] as List;
      List<Skill> _skills = experienceObjJson.map((experienceJson) => Skill.fromJson(experienceJson['skill'])).toList();
      

      return Employee(
        id : json['id'],
        name : json['name'],
        surname: json['surname'],
        email: json['email'],
        password: json['password'],
        description: json['description'],
        skills: _skills,
        type : json['type']
      );
    }
    else{
      return Employee(
        id : json['id'],
        name : json['name'],
        surname: json['surname'],
        email: json['email'],
        description: json['description'],
        password: json['password'],
        type: json['type']);
    }
  }
}

 class Experience{
    int id;
    Skill skill;
    int years;

    Experience({
      this.id,
      this.skill,
      this.years
    });

    Map toJson(){
      return {
        'id' : id,
        'skill' : skill.toJson(),
        'years' : years
      };
    }
  }