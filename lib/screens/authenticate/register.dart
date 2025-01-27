import 'dart:io';
import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:headhunting_flutter/customWidgets/slideRight.dart';
import 'package:headhunting_flutter/models/Employee.dart';
import 'package:headhunting_flutter/models/skill.dart';
import 'package:headhunting_flutter/models/user.dart';
import 'package:headhunting_flutter/screens/authenticate/sign_in.dart';
import 'package:headhunting_flutter/services/registrationService.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';


class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final RegExp nameRe = new RegExp(r"^[a-zA-Z ,.'-]+$");
  final RegExp passRe = new RegExp(r"^(?=.*[A-Z])(?=.*\d)[a-zA-Z0-9@]{6,12}$");
  List<Skill> skills = new List<Skill>();
  List<String> skillStrings = new List<String>();
  Map<String,Skill> skillStringMap = new Map<String,Skill>();
  List<Skill> tempSkillsForEmployee = new List<Skill>();
  List<Skill> savedSkillsForEmployee = new List<Skill>();
  
  String name = '';
  String surname = '';
  String email = '';
  String pasword = '';

  void _loadData() async {
    await SkillViewModel.loadSkills();
    skills = SkillViewModel.skills;
    skillStrings = SkillViewModel.skills.map((skill) => skill.name).toList();
    for (var skl in skills) {
      skillStringMap.putIfAbsent(skl.name, () => skl);
    }
  }

  _showSkillsDialog(BuildContext scaffoldContext){
    showDialog(
      context: scaffoldContext,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0)),
          child: new AnimatedContainer(
            duration: Duration(seconds: 2),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.6,
            curve: Curves.fastOutSlowIn,
            
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(child : new ButtonTheme(
                  minWidth: 100,
                  height: 30,
                  child: RaisedButton(
                      onPressed: () {
                        savedSkillsForEmployee = tempSkillsForEmployee.map((i) => new Skill(id: i.id, name : i.name, fieldOfExpertise: i.fieldOfExpertise)).toList();
                        Scaffold.of(scaffoldContext).showSnackBar(
                                        SnackBar(content: Text('Skills successfully saved')));
                              //signIn(emailController.text, passwordController.text);
                        Navigator.pop(scaffoldContext);
                      },
                      elevation: 0.0,
                      child:
                          Text("Save", style: TextStyle(color: Colors.white70)),
                      color: Color.fromRGBO(55, 63, 81, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    )
                )),
                Expanded(
                    child: Tags(
                      spacing: 15,
                      runAlignment: WrapAlignment.end,
                      alignment: WrapAlignment.center,
                      key: _tagStateKey,
                      textField: TagsTextField(   
                        suggestionTextColor: Colors.teal,
                        hintText: 'Enter a skill',
                        duplicates: false,
                        width: 200,
                        helperTextStyle: TextStyle(fontSize: 12),
                        textStyle: TextStyle(fontSize: 14),
                        constraintSuggestion: true,
                        suggestions: skillStrings,
                        onSubmitted: (String str){
                          setState(() {
                            
                            Skill newSkill = skillStringMap[str];
                            tempSkillsForEmployee.add(newSkill);
                          }
                          );
                        }
                      ),
                      itemCount: tempSkillsForEmployee.length,
                      itemBuilder: (int index){
                        final skill = tempSkillsForEmployee[index];

                        return ItemTags(
                          key: Key(index.toString()),
                          alignment: MainAxisAlignment.end,

                          activeColor: Colors.teal,
                          index: index,
                          title: skill.name,
                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          textStyle: TextStyle(fontSize: 14),
                          combine: ItemTagsCombine.withTextBefore,
                          removeButton: ItemTagsRemoveButton(
                            onRemoved: (){
                              setState(() {
                                tempSkillsForEmployee.removeAt(index);
                              });
                              return true;
                            }
                          ),
                        );
                      },
                    ),
                  )

              ],
            ),
          ),
        );
      });
  }

  @override
  void initState(){
    _loadData();
  }

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
                                Employee employee = new Employee(
                                  name: name,
                                  surname: surname,
                                  email: email,
                                  password: pasword,
                                  skills: savedSkillsForEmployee);
                                Future<String> responseUser =
                                    RegistrationService().registerEmployee(employee);
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
                          RaisedButton(
                            color: Color.fromRGBO(55, 63, 81, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                            child : Text(
                              'Add skills'
                              , style: TextStyle(color: Colors.white)
                              ),
                            onPressed: () => _showSkillsDialog(scafoldContext),
                          )
                        ],
                      ),
                    )))));
  }
}
