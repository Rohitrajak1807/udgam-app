import 'package:flutter/material.dart';
import 'package:udgam/models/splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Udgam 2020",
      theme: ThemeData.dark(),
      home: Splash(),
    );
  }
}

