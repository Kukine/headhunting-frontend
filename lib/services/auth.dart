import 'package:flutter/material.dart';
import 'package:headhunting_flutter/models/user.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'package:oauth2/oauth2.dart' as oauth2;

class AuthService {

  final String identifier = "user";
  final String secret = "user";
  final Uri authorizationEndpoint =Uri.parse("https://kukine-headhunting.herokuapp.com/oauth/token");
  final String registraonUrl = "https://kukine-headhunting.herokuapp.com/api/user/register";
  oauth2.Client client;

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

  Future signIn (String username, String password) async {
     this.client = await oauth2.resourceOwnerPasswordGrant(authorizationEndpoint, username, password, identifier: identifier, secret: secret);
     return this.client;
  }

}