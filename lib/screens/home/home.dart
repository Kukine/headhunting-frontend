import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:headhunting_flutter/customWidgets/employeeCard.dart';
import 'package:headhunting_flutter/models/Employee.dart';
import 'package:headhunting_flutter/screens/authenticate/authenticate.dart';
import 'package:headhunting_flutter/services/auth.dart';
import 'package:oauth2/oauth2.dart';

class Home extends StatelessWidget {

  List<Employee> employees;
  Client client;
  Home({this.client});

  @override
  Widget build(BuildContext context) {
    client.get(Uri.parse("https://kukine-headhunting.herokuapp.com/api/employee"))
    .then((onValue) {
      print(onValue.body);
      var employeesJson = jsonDecode(onValue.body) as List;
      employees = employeesJson.map((empJson) => Employee.fromJson(empJson)).toList();
    });

    return Container(
      child : ListView.builder(
        itemCount: employees.length,
        itemBuilder: (BuildContext context, int index){
          print(employees.length);
          return EmployeeCard(employee: employees[index]);
        },
      )
    );
  }
}