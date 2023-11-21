import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final String title;

  const MenuTile({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title),
        onTap: () {
          //
          Navigator.pop(context);
        });
  }
}
