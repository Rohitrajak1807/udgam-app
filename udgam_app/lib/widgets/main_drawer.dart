import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(child: UserAccountsDrawerHeader(
            accountEmail: Text("Email"),
            accountName: Text("Name"),
            currentAccountPicture: CircleAvatar(
              minRadius: 20,
              maxRadius: 40,
              child: Text("A"),
              backgroundColor: Theme
                  .of(context)
                  .accentColor,
            ),
          ),
          ),
          buildListTile("Feed", Icons.chrome_reader_mode),
          buildListTile("Events", Icons.event),
          buildListTile("Gallery", Icons.photo),
          buildListTile("Teams", Icons.people),
          buildListTile("Sponsors", Icons.attach_money),
          buildListTile("About", Icons.info),
        ],
      ),
    );
  }

  ListTile buildListTile(title, icon) {
    return ListTile(
      selected: true,
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(title),
    );
  }
}
