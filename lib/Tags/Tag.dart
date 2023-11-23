import 'package:flutter/material.dart';

class Tag{
  String name;
  Color color;
  bool isPrimary;
  IconData icon;

  Tag({required this.name, required this.color, this.isPrimary = false, this.icon = Icons.circle});
}

