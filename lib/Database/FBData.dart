import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FBData extends StatefulWidget {
  @override
  _FBDataState createState() => _FBDataState();
}

class _FBDataState extends State<FBData> {
  final databaseReference = FirebaseDatabase.instance.ref();

  void saveData() {
    databaseReference.child('users').set({
      'name': 'John Doe',
      'email': 'john.doe@example.com',
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            saveData();
          },
          child: Text('Save to Firebase'),
        ),
      ),
    );
  }
}