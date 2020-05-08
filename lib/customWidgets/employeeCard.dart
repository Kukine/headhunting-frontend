import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:headhunting_flutter/models/Employee.dart';
import 'package:headhunting_flutter/models/user.dart';

class EmployeeCard extends StatelessWidget {
  
  final Employee employee;

  EmployeeCard({
    this.employee
  });

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();


  Widget employeeCard(){
    return new Card(
      child: Row(children: <Widget>[
        Container(), // image
        SizedBox(width: 10),
        Container(
          child: Column(
            children : <Widget>[
              userInfoSection(),
              SizedBox(height: 10),
              skillsSectionTags()
            ]
          ),
        )
      ],)
    );
  }

  Widget userInfoSection(){
    return Container(
      child: Column(
        children : <Widget>[
          Text('${employee.name}' + ' ' + '${employee.surname}'),
          Text('${employee.email}')
        ]
      ),
    );
  }

  Widget skillsSectionTags(){
    if(employee.skills != null){
      return Tags(
        key: _tagStateKey,
        // textField: TagsTextField(
        //   textStyle: TextStyle(fontSize: 10),
        //   constraintSuggestion: true, suggestions:  [],
        //   ),
        itemCount: employee.skills.length,
        itemBuilder: (int index){
          final skill = employee.skills[index];
          return ItemTags(
            key: Key(index.toString()), 
            index: index,
            title: skill.name,
            textStyle: TextStyle(fontSize: 8),
            combine: ItemTagsCombine.withTextBefore
          );
        },
          
      );
    }
    else return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: employeeCard(),
    );
  }
}