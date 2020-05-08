import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:headhunting_flutter/models/Employee.dart';
import 'package:headhunting_flutter/models/user.dart';

class EmployeeCard extends StatelessWidget {
  
  final Employee employee;

  EmployeeCard({
    this.employee
  });

  Widget employeeCard(){
    return new Card(
      child: Row(children: <Widget>[
        Container(), //
        SizedBox(width: 10),
        Container(
          child: Column(
            children : <Widget>[
              
            ]
          ),
        )
      ],)
    );
  }

  Widget userInfoSection(){
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}