import 'package:flutter/material.dart';
// One EventListTiles in the multilevel list displayed by this app.
class EventListTiles {
  EventListTiles(this.title, [this.children = const <EventListTiles>[]]);

  final String title;
  final List<EventListTiles> children;
}


class EventListTilesItem extends StatelessWidget {
  const EventListTilesItem(this.listTiles);
  final EventListTiles listTiles;
  Widget _buildTiles(EventListTiles root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title, textAlign: TextAlign.justify,style: TextStyle(fontSize: 17,color: Colors.black.withBlue(20))));
    return ExpansionTile(
      key: PageStorageKey<EventListTiles>(root),
      title: Text(root.title, style: TextStyle(fontWeight:FontWeight.bold,fontSize: 18,color: Colors.black.withBlue(20)), textAlign: TextAlign.justify),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(listTiles);
  }
}