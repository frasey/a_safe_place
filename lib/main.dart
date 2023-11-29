import 'dart:ui';
import 'package:a_safe_place/Events/all_events.dart';
import 'package:a_safe_place/Events/show_single_event.dart';
import 'package:a_safe_place/authentication/login_page.dart';
import 'package:a_safe_place/features/splash_screen.dart';
import 'package:a_safe_place/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'A Safe Place',
      home: SplashScreen(child: HomePage()),
    );
  }
}
