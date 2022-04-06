import 'package:flutter/foundation.dart';

class NoteManipulation {
  String name;
  String description;
  String icon;
  String backgroundColor;
  String imageURL;
  String status;

  NoteManipulation({
    @required this.name,
    @required this.description,
    @required this.icon,
    @required this.backgroundColor,
    @required this.imageURL,
    @required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "icon": icon,
      "backgroundColor": backgroundColor,
      "imageURL": imageURL,
      "status": status
    };
  }
}
