import 'dart:io';

import 'package:a_safe_place/Events/StandardInputField.dart';
import 'package:a_safe_place/Database/mongodb.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  void initState() {
    super.initState();
    print("initState");
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print("WidgetsBinding");
      // await MongoDatabase.connect();
      print("post db");
    });
  }

  final _formKey = GlobalKey<FormState>(); // handles the validator

  @override
  Widget build(BuildContext context) {
    print("build");

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  "Create New",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SingleChildScrollView(scrollDirection: Axis.vertical),
                // EVENT TITLE
                const StandardInputField(
                    name: 'Event title', keyboardType: TextInputType.text),
                // DATE * TIME
                const StandardInputField(
                    name: 'Date and Time',
                    keyboardType: TextInputType.datetime),
                // LOCATION
                const StandardInputField(
                    name: 'Location', keyboardType: TextInputType.text),
                // DESCRIPTION
                const StandardInputField(
                    name: 'Description', keyboardType: TextInputType.multiline),
                // REMINDER - PLACEHOLDER
                const StandardInputField(
                    name: 'Reminder', keyboardType: TextInputType.text),
                // CONTACT NAME
                const StandardInputField(
                    name: 'Contact name', keyboardType: TextInputType.text),
                // CONTACT NUMBER
                const StandardInputField(
                    name: 'Contact number', keyboardType: TextInputType.phone),
                // UPLOAD DOCS/IMAGES - PLACEHOLDER
                ElevatedButton(
                  child: const Text('Attach File or Photo to Event'),
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    if (result == null) return;

                    final file = result.files.first;
                    final newFile = await saveFilePermanently(file);
                  },
                ),

                // ELEVATED BUTTON
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //if currentState value is true, then trigger the scaffold messenger to trigger the validator of every text form field
                        // collection.insertMany()
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Great!'),
                          ),
                        );
                      }
                    },
                    child: const Text('Save')),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // needs path_provider dep in pubspec.yaml
  Future<File> saveFilePermanently(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path!).copy(newFile.path);
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}

// TODO stop form overflow
// TODO alter description field to larger size
// TODO reminders
// TODO image uploads
// TODO save to db
