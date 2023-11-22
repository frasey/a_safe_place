import 'package:flutter/material.dart';
import 'MenuTile.dart';
import '../Events/OLD.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // APPBAR
        appBar: AppBar(
          centerTitle: true,
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
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                //OPEN PROFILE PAGE HERE
              },
            )
          ],
        ),

        // ** HAMBURGER MENU **
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueGrey),
                child: Text('Menu'),
              ),
              MenuTile(title: 'Home'),
              MenuTile(title: 'Profile'),
              MenuTile(title: 'Your tags'),
              MenuTile(title: 'Your docs/images'),
              MenuTile(title: 'All events'),
              MenuTile(title: 'Create new event'),
              MenuTile(title: 'Log out')
            ],
          ),
        ),

        // HOMEPAGE BODY
        body: const Column(
          children: [
            // Event(),         OR EVENT PREVIEW?
          ],
        ));
  }
}
