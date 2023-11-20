import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'A Safe Place',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Builder(builder: (BuildContext context) {
          // leading is for a widget to display before the appBar's title
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // CALL DRAWER OPEN FUNTION HERE
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
    );
  }
}
