import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:headhunting_flutter/customWidgets/employeeCard.dart';
import 'package:headhunting_flutter/models/Employee.dart';
import 'package:headhunting_flutter/models/skill.dart';
import 'package:headhunting_flutter/screens/authenticate/authenticate.dart';
import 'package:headhunting_flutter/services/auth.dart';
import 'package:headhunting_flutter/services/dataServices.dart';
import 'package:oauth2/oauth2.dart';

final key = new GlobalKey<_SkillDropDownState>();
final GlobalKey<_FutureUserBuilderState> futureKey = new GlobalKey<_FutureUserBuilderState>();

class Home extends StatelessWidget {
  Client client;
  Home({this.client});
  String selectedSkill = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Employee search"),
          backgroundColor: Colors.purple.shade900,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  SkillDropDown(client: this.client, key: key),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    onPressed: () {
                      print(key.currentState.selectedSkill);
                      futureKey.currentState.setState(() {
                        futureKey.currentState.limitBySkill = key.currentState.selectedSkill;
                        print(futureKey.currentState.limitBySkill);
                      });
                                         
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              FutureUserBuilder(client: this.client, key: futureKey,),
            ],
          ),
        ));
  }
}

class SkillDropDown extends StatefulWidget {
  Client client;
  Key key;

  SkillDropDown({this.client, this.key});

  @override
  _SkillDropDownState createState() => _SkillDropDownState();
}

class _SkillDropDownState extends State<SkillDropDown> {
  String selectedSkill = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DataServices().loadSkillList(widget.client),
        builder: (BuildContext context, AsyncSnapshot<List<Skill>> snapshot) {
          if (snapshot.hasData) {
            if (selectedSkill.isEmpty) {
              selectedSkill = snapshot.data[0].name;
            }
            return new Builder(
                builder: (context) => Container(
                    width: 200,
                    child: DropdownButton<String>(
                      isExpanded: true,
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      value: selectedSkill,
                      items: snapshot.data
                          .map((x) => DropdownMenuItem(
                                child: Text(x.name),
                                value: x.name,
                              ))
                          .toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          selectedSkill = newValue;
                        });
                      },
                    )));
          } else {
            return new Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class FutureUserBuilder extends StatefulWidget {
  Client client;
  Key key;
  
  FutureUserBuilder({this.client, this.key});

  @override
  _FutureUserBuilderState createState() => _FutureUserBuilderState();
}

class _FutureUserBuilderState extends State<FutureUserBuilder> {
  String limitBySkill = "";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
                  future: DataServices().loadEmployees(widget.client, limitBySkill),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Employee>> snapshot) {
                    return snapshot.hasData
                        ? new Builder(
                            builder: (context) => Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 10),
                                        EmployeeCard(
                                            employee: snapshot.data[index]),
                                      ],
                                    ));
                                  },
                                )))
                        : new Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          );
                  });
  }
}
