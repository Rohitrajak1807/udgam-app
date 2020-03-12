import 'package:flutter/material.dart';
import 'package:udgam/widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Udgam"),
      ),
      drawer: MainDrawer(),
    );
  }
}
