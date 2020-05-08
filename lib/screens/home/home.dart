import 'package:flutter/material.dart';
import 'package:headhunting_flutter/screens/authenticate/authenticate.dart';
import 'package:headhunting_flutter/services/auth.dart';
import 'package:oauth2/oauth2.dart';

class Home extends StatelessWidget {

  String body;
  Client client;
  Home({this.client});

  @override
  Widget build(BuildContext context) {
    client.get(Uri.parse("https://kukine-headhunting.herokuapp.com/api/employee"))
    .then((onValue) {
      body = onValue.body;
    });
    return Container(
      child : Text(body)
    );
  }
}