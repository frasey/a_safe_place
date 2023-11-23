import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'MenuTile.dart';
import '../Events/Event.dart';

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
                // CALL DRAWER OPEN FUNCTION HERE
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // NEXT EVENT PREVIEW
            const Placeholder(
              fallbackHeight: 80,
              fallbackWidth: 150,
            ),
            // When functionality for the above section has been added, include below code for route animation:
            // onPressed: () => Navigator.of(context).push(PageTransition(
            //                 type: PageTransitionType.scale,
            //                 alignment: Alignment.topCenter,
            //                 child: const PAGE-YOU-WANT-TO-LINK-TO(),

            ElevatedButton(
              child: const Text('Create new event'),
              onPressed: () => Navigator.of(context).push(PageTransition(
                type: PageTransitionType.rightToLeftJoined,
                childCurrent: this,
                duration: const Duration(milliseconds: 600),
                reverseDuration: const Duration(milliseconds: 600),
                child: const HomePage(),
              )),
            ),
            // SEE ALL EVENTS
            ElevatedButton(
              child: const Text('Show all events'),
              onPressed: () => Navigator.of(context).push(PageTransition(
                type: PageTransitionType.rightToLeftJoined,
                childCurrent: this,
                duration: const Duration(milliseconds: 600),
                reverseDuration: const Duration(milliseconds: 600),
                child: const HomePage(),
              )),
            ),
            // NOTES
            const Placeholder(
              fallbackHeight: 80,
              fallbackWidth: 150,
            ),
          ],
        ));
  }
}
