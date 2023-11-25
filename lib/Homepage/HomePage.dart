import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'MenuTile.dart';
import '../Events/Event.dart';
import 'package:a_safe_place/Profile.dart';
import 'package:a_safe_place/Tags/tag_dialog.dart';

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
              onPressed: () =>
              {
                Navigator.of(context).push(PageTransition(
                  type: PageTransitionType.rightToLeftJoined,
                  childCurrent: this,
                  duration: const Duration(milliseconds: 800),
                  reverseDuration: const Duration(milliseconds: 800),
                  child: const Profile(),
                  ),
                )
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
              MenuTile(title: 'Home', linkedPage: HomePage() ),
              MenuTile(title: 'Profile', linkedPage: Profile() ),
              MenuTile(title: 'Your tags', linkedPage: HomePage() ),
              MenuTile(title: 'Your docs/images', linkedPage: HomePage() ),
              MenuTile(title: 'All events', linkedPage: HomePage() ),
              MenuTile(title: 'Create new event', linkedPage: Event() ),
              MenuTile(title: 'Log out', linkedPage: Profile() )
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
                duration: const Duration(milliseconds: 800),
                reverseDuration: const Duration(milliseconds: 800),
                child: const Event(),
              )),
            ),
            // SEE ALL EVENTS
            ElevatedButton(
              child: const Text('Show all events'),
              onPressed: () => Navigator.of(context).push(PageTransition(
                type: PageTransitionType.rightToLeftJoined,
                childCurrent: this,
                duration: const Duration(milliseconds: 800),
                reverseDuration: const Duration(milliseconds: 800),
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
