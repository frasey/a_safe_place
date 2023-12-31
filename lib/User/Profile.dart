import 'package:a_safe_place/Events/all_events.dart';
import 'package:a_safe_place/authentication/login_page.dart';
import 'package:a_safe_place/Global/common/toast.dart';
import 'package:a_safe_place/home_page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import '../models/tag.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundColor: Color.fromARGB(255, 75, 184, 137),
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),

                Text(
                  'My Profile', //$user.name
                  style: GoogleFonts.nunitoSans(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 75, 184, 137),
                  ),
                ),
                SizedBox(height: 30),
                // MY TAGS BUTTON
                TextButton(
                  onPressed: () => {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: this,
                        duration: const Duration(milliseconds: 800),
                        reverseDuration: const Duration(milliseconds: 800),
                        child:
                            const HomePage(), // TODO - this is calling the tag class rather than the page. I don't think it will work because it wants arguments
                      ),
                    ),
                  },
                  child: const Text(
                    'My Tags',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),

                // SEE ALL EVENTS BUTTON
                TextButton(
                  onPressed: () => {
                    Navigator.of(context).push(
                      PageTransition(
                        type: PageTransitionType.rightToLeftJoined,
                        childCurrent: this,
                        duration: const Duration(milliseconds: 800),
                        reverseDuration: const Duration(milliseconds: 800),
                        child:
                            const AllEvents(), //TODO - this is calling the tag class rather than the page. I don't think it will work because it wants arguments
                      ),
                    ),
                  },
                  child: const Text(
                    'My Events',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),

                TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                    showToast(message: "User has been signed out");

                    // PageTransition(
                    //   type: PageTransitionType.rightToLeftJoined,
                    //   childCurrent: this,
                    //   duration: const Duration(milliseconds: 800),
                    //   reverseDuration: const Duration(milliseconds: 800),
                    // ),
                  },
                  child: const Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
