import 'dart:ui';
import 'package:a_safe_place/Database/mongodb.dart';
import 'package:a_safe_place/Events/Event.dart';
import 'package:flutter/material.dart';
import 'Homepage/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'A Safe Place',
      home: Event(),
      // home: HomePage(),
    );
  }
}
