import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:headhunting_flutter/customWidgets/slideRight.dart';
import 'package:headhunting_flutter/models/Employer.dart';
import 'package:headhunting_flutter/screens/authenticate/sign_in.dart';
import 'package:headhunting_flutter/services/dataServices.dart';
import 'package:headhunting_flutter/services/registrationService.dart';

class RegisterEmployer extends StatefulWidget {
  @override
  _RegisterEmployerState createState() => _RegisterEmployerState();
}

class _RegisterEmployerState extends State<RegisterEmployer> {
  final _formKey = GlobalKey<FormState>();
  final RegExp nameRe = new RegExp(r"^[a-zA-Z ,.'-]+$");
  final RegExp passRe = new RegExp(r"^(?=.*[A-Z])(?=.*\d)[a-zA-Z0-9@]{6,12}$");
  String name = '';
  String surname = '';
  String email = '';
  String pasword = '';
  String organiationName = '';

  final TextEditingController _typeAheadController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Register'),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.person),tooltip: "Sign in", onPressed: (){
              Navigator.push(
                      context, SlideRightRoute(page: SignIn()));
            })
          ],
        ),
        body: Builder(
            builder: (scafoldContext) =>
                Container( child : Form(
                    key: _formKey,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15)),
                      child: ListView(
                        padding: const EdgeInsets.all(10),
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: TextFormField(
                                decoration: const InputDecoration(
                                    icon: Icon(Icons.face, color: Color.fromRGBO(55, 63, 81, 1)),
                                    labelText: 'First name'),
                                onChanged: (val) {
                                  setState(() => name = val);
                                },
                                validator: (String value) {
                                  return nameRe.hasMatch(value)
                                      ? null
                                      : 'Not a valid name';
                                },
                              )),
                              SizedBox(width: 15.0),
                              Expanded(
                                  child: TextFormField(
                                decoration: const InputDecoration(
                                    labelText: 'Last name'),
                                onChanged: (val) {
                                  setState(() => surname = val);
                                },
                                validator: (String value) {
                                  return nameRe.hasMatch(value)
                                      ? null
                                      : 'Not a valid last name';
                                },
                              ))
                            ],
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.email, color: Color.fromRGBO(55, 63, 81, 1)),
                                labelText: 'e-mail'),
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            validator: (String value) {
                              return EmailValidator.validate(value)
                                  ? null
                                  : 'Not a valid e-mail adress';
                            },
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.enhanced_encryption,
                                    color: Color.fromRGBO(55, 63, 81, 1)),
                                labelText: 'Password'),
                            onChanged: (val) {
                              setState(() => pasword = val);
                            },
                            validator: (String value) {
                              return passRe.hasMatch(value)
                                  ? null
                                  : 'Not a valid password';
                            },
                          ),
                          SizedBox(height: 5),
                          TypeAheadFormField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: this._typeAheadController,
                              decoration: InputDecoration(labelText: 'Organization')
                            ),
                            onSuggestionSelected: (suggestion) {
                              this._typeAheadController.text = suggestion;
                            }, 
                            itemBuilder: (context, suggestion){
                              return ListTile(
                                title: Text(suggestion),
                              );
                            }, 
                            suggestionsCallback: (value) {
                              return DataServices().loadOrganizations();
                            },
                            validator: (value){
                              if(value.isEmpty){
                                return 'Select an organization';
                              }
                            },
                            onSaved: (value) => this.organiationName = value,
                            )
                            ,
                          RaisedButton(
                            color: Color.fromRGBO(55, 63, 81, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                Scaffold.of(scafoldContext).showSnackBar(
                                    SnackBar(content: Text('Processing Data')));
                                Employer employer = new Employer(
                                  name: name,
                                  surname: surname,
                                  email: email,
                                  password: pasword,
                                  organizationName: organiationName);
                                Future<String> responseUser =
                                    RegistrationService().registerEmployer(employer);
                                responseUser.then((onValue) {
                                
                                    Scaffold.of(scafoldContext).showSnackBar(
                                      SnackBar(content: Text(onValue)));
                                    Navigator.of(context).pop();

                                
                                }, onError: (error) {
                                  print(error);
                              });
                              }
                            },
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 250),)
                       ],
                      ),
                    )))));
  }
}