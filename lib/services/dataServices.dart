
import 'dart:convert';

import 'package:headhunting_flutter/models/Employee.dart';
import 'package:headhunting_flutter/models/Employer.dart';
import 'package:headhunting_flutter/models/skill.dart';
import 'package:http/http.dart';
import 'package:oauth2/oauth2.dart' as oauth2;


class DataServices{

  static final String baseUrl = "https://kukine-headhunting.herokuapp.com";

  Future<String> loadSkills() async {
    Map<String,String> headers = {"Content-type": "application/json"};
    Response response = await get(baseUrl + "/api/skills");
    return response.body;
  }

  Future<List<Skill>> loadSkillList(oauth2.Client client) async {
    var skills = new List<Skill>();
    var future = await client.get(Uri.parse("https://kukine-headhunting.herokuapp.com/api/skills"));
    var skillJson = jsonDecode(future.body) as List;
    skills = skillJson.map((skill) => Skill.fromJson(skill)).toList();
    return skills;

  }

  Future<List<Employee>> loadEmployees(oauth2.Client client, String limitByString) async{
    print("Reload" + limitByString);
    var employees = new List<Employee>();
    var future;
    if(limitByString.isEmpty){
      future = await client.get(Uri.parse("https://kukine-headhunting.herokuapp.com/api/employee"));

    }else{
      future = await client.get(Uri.parse("https://kukine-headhunting.herokuapp.com/api/employee/bySkill?skillName=" + limitByString));
    }
    var employeesJson = jsonDecode(future.body) as List;
    employees = employeesJson.map((empJson) => Employee.fromJson(empJson)).toList();
    return employees;
  }

  Future<List<String>> loadOrganizations() async {
    var organizations = new List<String>();
    var future = await get(Uri.parse("https://kukine-headhunting.herokuapp.com/api/organization"));
    var organizationsJson = jsonDecode(future.body) as List;
    organizations = organizationsJson.map((org) => Organization.fromJson(org).name).toList();
    return organizations;
  }
}