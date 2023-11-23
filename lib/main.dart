import 'dart:ui';

import 'package:a_safe_place/Database/mongodb.dart';
import 'package:a_safe_place/Events/Event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Homepage/HomePage.dart';

void main() async {
  // Future<void>
//   await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'A Safe Place',
      home: HomePage(),
    );
  }
}
