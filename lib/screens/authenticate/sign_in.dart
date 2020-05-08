import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:headhunting_flutter/customWidgets/slideRight.dart';
import 'package:headhunting_flutter/screens/authenticate/register.dart';
import 'package:headhunting_flutter/screens/home/home.dart';
import 'package:headhunting_flutter/services/auth.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  final RegExp passRe = new RegExp(r"^(?=.*[A-Z])(?=.*\d)[a-zA-Z0-9@]{6,12}$");

  String email = '';
  String password = '';
  String error = '';
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container( child : ListView(
        children: <Widget>[
          header(),
          formSection(),
          buttonSection(),
        ],
      )),
    );
  }

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  Container formSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Form(
        key: _formKey,
        child: Column(children : <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.black,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.email, color: Colors.black),
                hintText: "Email",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black)),
            validator: (String value) {
              return EmailValidator.validate(value) ? null : 'Invalid e-mail';
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.black,
            obscureText: true,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
                icon: Icon(Icons.enhanced_encryption, color: Colors.black),
                hintText: "Password",
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black)),
            validator: (String value){
              return passRe.hasMatch(value)
                ? null
                : 'Not a valid password';
            },
          ),
        ],
      ),
    ));
  }

  Container header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      margin: EdgeInsets.only(top: 15.0),
      alignment: Alignment.center,
      child: Text(
        "HeadHunting",
        style: TextStyle(
            color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
      ),
    );
  }

  Container buttonSection() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        margin: EdgeInsets.only(top: 15.0),
        child: Column(
          children: <Widget>[
            ButtonTheme(
                height: 30,
                minWidth: 190,
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                          setState(() {
                            _isLoading = true;
                            print(emailController.text);
                          });
                          var signIn = AuthService().signIn(emailController.text, passwordController.text);
                          signIn.then((onvalue){
                            Navigator.push(context, SlideRightRoute(page: Home(client: onvalue)));
                          });
                          //signIn(emailController.text, passwordController.text);
                        }      
                  },
                  elevation: 0.0,
                  color: Color.fromRGBO(55, 63, 81, 1),
                  child:
                      Text("Sign In", style: TextStyle(color: Colors.white70)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                )),
            SizedBox(height: 10),
            Text("Don't have an account? Register now."),
            SizedBox(height: 10),
            ButtonTheme(
              height: 30,
              minWidth: 190,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context, SlideRightRoute(page: Registration()));
                },
                //signIn(emailController.text, passwordController.text);
                elevation: 0.0,
                color: Color.fromRGBO(55, 63, 81, 1),
                child: Text("Register as Employee",
                    style: TextStyle(color: Colors.white70)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            )
          ],
        ));
  }
}
