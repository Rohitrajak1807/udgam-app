import 'package:flutter/foundation.dart';

class EventDetails {
  final String title;
  final String imageAssetPath;
  final String description;
  final List<String> rules;
  final Map<String, String> venue;
  final List<Map<String, Object>> coordinators;
  int registeredCounter = 0;

  EventDetails(
      {@required this.title,
      @required this.imageAssetPath,
      @required this.description,
      @required this.rules,
      @required this.venue,
      @required this.coordinators,
      this.registeredCounter = 0});
}
