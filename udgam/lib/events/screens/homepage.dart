import 'package:flutter/material.dart';
import 'package:udgam/events/eventDashboards/Dashboard.dart';

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
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.transparent,
        selectedItemColor: Color(0xFFC2185B),
        iconSize: 30.0,
        currentIndex: selectedItem,
        unselectedLabelStyle: TextStyle(color: Color(0xFF1B1B1B)),
        unselectedItemColor: Colors.black87,
        onTap: (currIndex) {
          setState(() {
            selectedItem = currIndex;
          });
        },
        items: [
          buildNavBarItems(context, Icons.extension, "title"),
          buildNavBarItems(context, Icons.whatshot, "title"),
          buildNavBarItems(context, Icons.person_outline, "title"),
        ],
      ),
    );
  }

  BottomNavigationBarItem buildNavBarItems(
      BuildContext context, IconData icon, String title) {
    return BottomNavigationBarItem(
        backgroundColor: Theme.of(context).toggleButtonsTheme.color,
        icon: Icon(icon),
        title: Text(
          title,
          style: Theme.of(context).textTheme.button,
        )
        );
  }
}
