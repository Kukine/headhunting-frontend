import 'dart:io';
import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:headhunting_flutter/customWidgets/background.dart';
import 'package:headhunting_flutter/models/user.dart';
import 'package:headhunting_flutter/services/registrationService.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}


class _RegistrationState extends State<Registration> {

  final _formKey = GlobalKey<FormState>();
  final RegExp nameRe = new RegExp(r"^[a-zA-Z ,.'-]+$");
  final RegExp passRe = new RegExp(r"^(?=.*[A-Z])(?=.*\d)[a-zA-Z0-9@]{6,12}$");

  String name = '';
  String surname = '';
  String email = '';
  String pasword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Register'),
        elevation: 0.0,
      ),
      body: Builder(
        builder: (scafoldContext) => CustomDecorationImage().bluredImageContainer(
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration : const InputDecoration(
                    icon: Icon(Icons.face, color: Colors.black),
                    labelText: 'First name'
                  ),
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                  validator: (String  value){
                    return nameRe.hasMatch(value) ? null : 'Not a valid name';
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration : const InputDecoration(
                    icon: Icon(Icons.face, color: Colors.black),
                    labelText: 'Last name'
                  ),
                  onChanged: (val) {
                    setState(() => surname = val);
                  },
                  validator: (String  value){
                    return nameRe.hasMatch(value) ? null : 'Not a valid last name';
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  decoration : const InputDecoration(
                    icon: Icon(Icons.email, color: Colors.black),
                    labelText: 'e-mail'
                  ),
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  validator: (String  value){
                     return EmailValidator.validate(value) ? null : 'Not a valid e-mail adress';
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  obscureText: true,
                  decoration : const InputDecoration(
                    icon: Icon(Icons.enhanced_encryption, color: Colors.black),
                    labelText: 'Password'
                  ),
                  onChanged: (val) {
                    setState(() => pasword = val);
                  },
                  validator: (String  value){
                     return passRe.hasMatch(value) ? null : 'Not a valid password';
                  },
                ),
                SizedBox(height : 5),
                RaisedButton(
                  color: Colors.black,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Scaffold.of(scafoldContext).showSnackBar(
                          SnackBar(content: Text('Processing Data')));
                    }
                    User user = new User(
                      name: name,
                      surname: surname,
                      email: email,
                      password: pasword
                    );
                    print(user.toJson());
                    Future<String> responseUser = RegistrationService().registerUser(user);
                    responseUser.then(
                      (onValue) {
                        Scaffold.of(scafoldContext).showSnackBar(
                          SnackBar(content: Text(onValue)));
                        if(onValue == 'Registration succesfull'){
                          Navigator.pop(context);
                        }
                      },
                      onError: (error) {
                        print(error);
                      });
                  },
                )
              ],
            ),
          )
        )
      )
    );
  }
}