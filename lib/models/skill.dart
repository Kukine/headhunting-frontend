
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:headhunting_flutter/services/dataServices.dart';

class Skill{

  Skill({
    this.id,
    @required this.name,
    @required this.fieldOfExpertise,
  });

  final int id;
  final String name;
  final String fieldOfExpertise;

  String toJson() => jsonEncode({
    'id' : id,
    'name': name,
    'fieldOfExpertise' : fieldOfExpertise,
  });

  Skill fromJson(String jsonString){
    Map<String,dynamic> skillMap = jsonDecode(jsonString);
    return Skill(
      id : skillMap['id'],
      name: skillMap['name'],
      fieldOfExpertise: skillMap['fieldOfExpertise']);
  }

  factory Skill.fromJson(Map<String,dynamic> parsedJson){
    return Skill(
      id : parsedJson['id'],
      name: parsedJson['name'],
      fieldOfExpertise: parsedJson['fieldOfExpertise']
    );
  }
}

class SkillViewModel{
  static List<Skill> skills;

  static Future loadSkills() async{
    try{
        skills = new List<Skill>();
        String jsonString = await DataServices().loadSkills();
        List<dynamic> parsedJson = json.decode(jsonString);
        print('tu');
        parsedJson.toString();
        for(int i=0; i < parsedJson.length; i++){
          skills.add(new Skill.fromJson(parsedJson[i]));
          print(parsedJson[i]);
        }
        print(skills.length);
    }catch(e){
      print(e);
    }
  }
}