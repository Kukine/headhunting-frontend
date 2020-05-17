import 'dart:convert';

import 'package:headhunting_flutter/models/Employee.dart';
import 'package:headhunting_flutter/models/Employer.dart';
import 'package:headhunting_flutter/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class RegistrationService{

  final String registraonUrl = "https://kukine-headhunting.herokuapp.com/api/user/register";
  final String employeeRegistrationUrl = "https://kukine-headhunting.herokuapp.com/api/employee/register";
  final String employerRegistrationUrl = "https://kukine-headhunting.herokuapp.com/api/employer/register";

  Future<String> registerUser(User user) async{
    Map<String,String> headers = {"Content-type": "application/json"};
    String jsonBody = user.toJson();
    Response response = await post(registraonUrl, headers: headers, body: jsonBody);
    print('Status code for user registration: ' + response.statusCode.toString());
    print('Response Body : ' + response.body);                           
    if(response.statusCode==200){
      return 'Registration succesfull';
    }else if(response.body == "EMAIL_EXISTS"){
      return 'Registration failed: User with e-mail adress exists';
    } else{
      return 'Registration failed: Unknown reason';
    }
  }

  Future registerEmployee(Employee employee) async {
    Map<String,String> headers = {"Content-type" : "application/json"};
    String jsonBody = jsonEncode(employee.toJson());
    Response response = await post(employeeRegistrationUrl, headers: headers, body: jsonBody);
    print('Status code for employee registration: ' + response.statusCode.toString());
    print('Response body : ' + response.body);
    return response.statusCode;
  }

  Future registerEmployer(Employer employer) async {
    Map<String,String> headers = {"Content-type" : "application/json"};
    String jsonBody = jsonEncode(employer.toJson());
    Response response = await post(employerRegistrationUrl, headers: headers, body: jsonBody);
    print('Status code for employee registration: ' + response.statusCode.toString());
    print('Response body : ' + response.body);
    return response.statusCode;
  }

}