import 'package:flutter/material.dart';
import 'package:udgam/services/authentication.dart';
import 'package:udgam/pages/root_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner:false,
        title: 'Udgam 2020',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new RootPage(
            auth: new Auth()
        )
    );
  }
}