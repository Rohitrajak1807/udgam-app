import 'package:flutter/material.dart';
import 'package:udgam/screens/home_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Udgam 2020",
      theme: ThemeData.dark(),
      routes: {
        "/": (context) => HomeScreen(),
      },
    );
  }
}

