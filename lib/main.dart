import 'package:a_safe_place/Database/mongodb.dart';
import 'package:flutter/material.dart';
import 'Homepage/HomePage.dart';
import 'Events/Event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
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
    );
  }
}
