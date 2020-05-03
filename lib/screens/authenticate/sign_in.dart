import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:headhunting_flutter/customWidgets/background.dart';
import 'package:headhunting_flutter/customWidgets/slideRight.dart';
import 'package:headhunting_flutter/screens/authenticate/register.dart';
import 'package:headhunting_flutter/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0.0,
          title: Text('Sign in to HeadHunter'),
        ),
        body: Builder(
          builder: (scaffoldContext) => CustomDecorationImage().bluredImageContainer(
            Form(
                key: _formKey,
                child: Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email, color: Colors.black),
                      labelText: 'e-mail',
                    ),
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    validator: (String value) {
                      return EmailValidator.validate(value)
                          ? null
                          : 'Not a valid e-mail';
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.enhanced_encryption,
                            color: Colors.black),
                        labelText: 'password'),
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.black,
                          child: Text(
                            'Sign in',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              Scaffold.of(scaffoldContext).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));
                            }
                          },
                        ),
                        SizedBox(width: 50),
                        RaisedButton(
                          color: Colors.black,
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.push(context, SlideRightRoute(page: Registration()));
                          },
                        ),
                      ])
                ])),
          ),
        ));
  }
}
