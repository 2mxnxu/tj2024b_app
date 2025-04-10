import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/day04/task/detail.dart';
import 'package:tj2024b_app/example/day04/task/home.dart';
import 'package:tj2024b_app/example/day04/task/update.dart';
import 'package:tj2024b_app/example/day04/task/wirte.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/" : (context) => Home(),
        "/write" : (context) => Write(),
        "/detail" : (context) => Detail(),
        "/update" : (context) => Update(),
      },
    );
  }
}