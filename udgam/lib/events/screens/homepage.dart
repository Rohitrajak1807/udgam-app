import 'package:flutter/material.dart';
import 'package:events/eventDashboards/Dashboard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  var selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DashboardPage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: Color(0xFFC2185B),
        iconSize:30.0,
        currentIndex: selectedItem,
        unselectedLabelStyle: TextStyle(color: Color(0xFF1B1B1B)),
        unselectedItemColor: Colors.black87,
        onTap: (currIndex) {
          setState(() {
            selectedItem = currIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1B1B1B),
            icon: Icon(Icons.extension),
            title: Container(
              height: 0.0,
              width: 0.0,
              ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1B1B1B),
            icon: Icon(Icons.whatshot),
            title: Container(
              height: 0.0,
              width: 0.0,
              ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1B1B1B),
            icon: Icon(Icons.person_outline),
            title: Container(
              height: 0.0,
              width: 0.0,
              ),
          ),
        ],
      ),
    );
  }
}
