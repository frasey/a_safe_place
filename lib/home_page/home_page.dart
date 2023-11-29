import 'package:a_safe_place/events/new_event_form.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'menu_tile.dart';
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
          title: Text(
            'A Safe Place',
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Color.fromARGB(255, 75, 184, 137),
            ),
          ),
          leading: Builder(builder: (BuildContext context) {
            // leading is for a widget to display before the appBar's title
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Color.fromARGB(255, 75, 184, 137),
              onPressed: () {
                // CALL DRAWER OPEN FUNCTION HERE
                Scaffold.of(context).openDrawer();
              },
            );
          }),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              color: Color.fromARGB(255, 75, 184, 137),
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
                decoration: BoxDecoration(
                  color: Color.fromARGB(250, 119, 104, 133),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FaIcon(
                      FontAwesomeIcons.houseLock,
                      size: 50,
                      color: Color.fromARGB(255, 220, 214, 247),
                    ),
                    Text(
                      'Menu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 220, 214, 247),
                      ),
                    ),
                    Text(
                      'Username', //TODO update to ${username}
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 220, 214, 247),
                      ),
                    ),
                  ],
                ),
              ),
              MenuTile(
                title: 'Home',
                linkedPage: HomePage(),
                textColor: Color.fromARGB(250, 119, 104, 133),
              ),
              MenuTile(
                title: 'Profile',
                linkedPage: Profile(),
                textColor: Color.fromARGB(250, 119, 104, 133),
              ),
              MenuTile(
                title: 'Your events',
                linkedPage: AllEvents(),
                textColor: Color.fromARGB(250, 119, 104, 133),
              ),
              MenuTile(
                title: 'Your tags',
                linkedPage: HomePage(),
                textColor: Color.fromARGB(250, 119, 104, 133),
              ),
              MenuTile(
                title: 'Your docs/images',
                linkedPage: UserImages(),
                textColor: Color.fromARGB(250, 119, 104, 133),
              ),
              MenuTile(
                title: 'Create new event',
                linkedPage: NewEventForm(),
                textColor: Color.fromARGB(250, 119, 104, 133),
              ),
              MenuTile(
                title: 'Log out',
                linkedPage: Profile(),
                textColor: Color.fromARGB(250, 119, 104, 133),
              )
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
              // style: ElevatedButton.styleFrom(
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(100),
              //   ),
              // ),
              onPressed: () => Navigator.of(context).push(
                PageTransition(
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
