import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tj2024b_app/example/book/detail.dart';
import 'package:tj2024b_app/example/book/home.dart';
import 'package:tj2024b_app/example/book/update.dart';
import 'package:tj2024b_app/example/book/write.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/":(context)=>Home(),
        "/write" : (context) => Write(),
        "/detail" : (context) => Detail(),
        "/update" : (context) => Update(),
      },
    );
  }
}