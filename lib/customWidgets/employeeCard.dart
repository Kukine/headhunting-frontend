import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:headhunting_flutter/customWidgets/slideRight.dart';
import 'package:headhunting_flutter/models/Employee.dart';
import 'package:headhunting_flutter/models/user.dart';
import 'package:headhunting_flutter/screens/profile.dart';

class EmployeeCard extends StatelessWidget {
  
  final Employee employee;

  EmployeeCard({
    this.employee
  });

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  Widget employeeCard(BuildContext context){
    return new GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(employee : employee))),
      child :Card(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      elevation: 15.0,
      child: Row(children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(horizontal: 10),),
        Container(
          child : Hero(
            tag: "${employee.email}",
            child: CircleAvatar(backgroundColor: Colors.purple.shade700, child: Text('${this.employee.name.substring(0,1)}' + '${this.employee.surname.substring(0,1)}'),),)
        ), // image
        SizedBox(width: 60),
        Container(
          child: Column(
            children : <Widget>[
              SizedBox(height: 30,),
              userInfoSection(),
              SizedBox(height: 30),
              // skillsSectionTags()
            ]
          ),
        )
      ],)
    ));
  }

  Widget userInfoSection(){
    return Container(
      child: Column(
        children : <Widget>[
          Text('${employee.name}' + ' ' + '${employee.surname}',style: TextStyle(fontSize: 16,),),
          // SizedBox(height: 20),
          // Text('${employee.email}')
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
      child: employeeCard(context),
    );
  }
}