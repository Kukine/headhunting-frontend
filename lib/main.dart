import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:headhunting_flutter/screens/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}
