import 'package:a_safe_place/events/new_event_form.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'menu_tile.dart';
import '../events/new_event_form.dart';
import 'package:a_safe_place/user/profile.dart';
import 'package:a_safe_place/events/all_events.dart';
import 'package:a_safe_place/user/user_images.dart';

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
              onPressed: () => {
                Navigator.of(context).push(
                  PageTransition(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Menu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'USERNAME', //TODO update to ${username}
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              MenuTile(title: 'Home', linkedPage: HomePage()),
              MenuTile(title: 'Profile', linkedPage: Profile()),
              MenuTile(title: 'Your tags', linkedPage: HomePage()),
              MenuTile(title: 'Your docs/images', linkedPage: UserImages()),
              MenuTile(title: 'All events', linkedPage: AllEvents()),
              MenuTile(title: 'Create new event', linkedPage: NewEventForm()),
              MenuTile(title: 'Log out', linkedPage: Profile())
            ],
          ),
        ),

        // HOMEPAGE BODY
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // NEXT EVENT PREVIEW
            const SizedBox(height: 20),
            const Placeholder(
              fallbackHeight: 80,
              fallbackWidth: 150,
            ),
            // When functionality for the above section has been added, include below code for route animation:
            // onPressed: () => Navigator.of(context).push(PageTransition(
            //                 type: PageTransitionType.scale,
            //                 alignment: Alignment.topCenter,
            //                 child: const PAGE-YOU-WANT-TO-LINK-TO(),
            const SizedBox(height: 40),
            ElevatedButton(
              child: const Text('Create new event'),
              onPressed: () => Navigator.of(context).push(PageTransition(
                type: PageTransitionType.rightToLeftJoined,
                childCurrent: this,
                duration: const Duration(milliseconds: 800),
                reverseDuration: const Duration(milliseconds: 800),
                child: NewEventForm(),
                  ),
                ),
            ),
            const SizedBox(height: 40),
            // SEE ALL EVENTS
            ElevatedButton(
              child: const Text('Show all events'),
              onPressed: () => Navigator.of(context).push(PageTransition(
                type: PageTransitionType.rightToLeftJoined,
                childCurrent: this,
                duration: const Duration(milliseconds: 800),
                reverseDuration: const Duration(milliseconds: 800),
                child: const AllEvents(),
              )),
            ),
            // NOTES
            // TODO space for user notes here
            // const Placeholder(
            //   fallbackHeight: 80,
            //   fallbackWidth: 150,
            // ),
          ],
        ));
  }
}
