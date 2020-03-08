import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            child: UserAccountsDrawerHeader(
              accountName: Text("Name", style: Theme.of(context).textTheme.title,),
              accountEmail: Text("Email", style: Theme.of(context).textTheme.caption,),
              currentAccountPicture: CircleAvatar(
                minRadius: 20,
                maxRadius: 40,
                child: Text(
                  "A",
                  style: Theme.of(context).textTheme.title,
                ),
                backgroundColor: Theme.of(context).appBarTheme.color,
              ),
            ),
          ),
          buildListTile(context, "Feed", Icons.chrome_reader_mode),
          buildListTile(context, "Events", Icons.event),
          buildListTile(context, "Gallery", Icons.photo),
          buildListTile(context, "Teams", Icons.people),
          buildListTile(context, "Sponsors", Icons.attach_money),
          buildListTile(context, "About", Icons.info),
        ],
      ),
    );
  }

  ListTile buildListTile(context, title, icon) {
    return ListTile(
      selected: true,
      leading: Icon(
        icon,
        color: Theme.of(context).iconTheme.color,
        size: Theme.of(context).iconTheme.size,
      ),
      title: Text(title, style: Theme.of(context).textTheme.subtitle),
    );
  }
}
