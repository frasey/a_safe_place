import 'dart:collection';
import 'package:flutter/material.dart';


class Tag{
  String name;
  Color color;
  bool isPrimary;
  IconData? icon;

  Tag({
    required this.name,
    required this.color,
    this.isPrimary = false,
    this.icon
  });


  // RETURN TAG FROM DB
  static Tag newFromJson(HashMap<String, dynamic> jsonFromDB) {
    String name = jsonFromDB["name"];
    Color color = jsonFromDB["color"];
    bool isPrimary = jsonFromDB["isPrimary"];
    IconData? icon = jsonFromDB["icon"];
    return Tag(name: name, color: color, isPrimary: isPrimary, icon: icon);
  }

  // ADD TAG TO DB
  Map<String, dynamic> toJson() {
    return {
      if (name != null) "name": name,
      if (color != null) "color": color,
      if (isPrimary != null) "isPrimary": isPrimary,
      if (icon != null) "icon": icon,
    };
  }
}

