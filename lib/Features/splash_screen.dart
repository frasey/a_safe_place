import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  final Widget? child;
  const SplashScreen({super.key, this.child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color.fromARGB(255, 26, 58, 58)),
          ),
          SizedBox(height: 50),
          FaIcon(
            FontAwesomeIcons.houseLock,
            size: 100,
            color: Color.fromARGB(255, 75, 184, 137),
          ),
          SizedBox(height: 40),
          Text(
            "A Safe Place",
            style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Color.fromARGB(255, 75, 184, 137)),
          )
        ],
      ),
    ));
  }
}
