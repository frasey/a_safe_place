import 'dart:io';

import 'package:a_safe_place/Events/StandardInputField.dart';
import 'package:a_safe_place/Database/mongodb.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:a_safe_place/Tags/Tag.dart';
import 'package:a_safe_place/Tags/tag_dialog.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateAndTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController uploadController = TextEditingController();

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Create New",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  StandardInputField(
                      name: 'Title (required)',
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      controller: titleController,
                      requireValidation: true),
                  // DATE * TIME
                  StandardInputField(
                      name: 'DD/MM/YYYY 00:00 (required)',
                      keyboardType: TextInputType.datetime,
                      maxLines: 1,
                      controller: dateAndTimeController,
                      requireValidation: true),
                  // LOCATION
                  StandardInputField(
                      name: 'Location',
                      keyboardType: TextInputType.multiline,
                      maxLines: 2,
                      controller: locationController),
                  // DESCRIPTION
                  StandardInputField(
                      name: 'Description',
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      controller: descriptionController),
                  // REMINDER - PLACEHOLDER
                  StandardInputField(
                      name: 'Reminder',
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      controller: reminderController),
                  // CONTACT NAME
                  StandardInputField(
                      name: 'Contact name',
                      keyboardType: TextInputType.text,
                      maxLines: 1,
                      controller: contactNameController),
                  // CONTACT NUMBER
                  StandardInputField(
                      name: 'Contact number',
                      keyboardType: TextInputType.phone,
                      maxLines: 1,
                      controller: contactNumberController),
                  // // UPLOAD DOCS/IMAGES - PLACEHOLDER
                  // StandardInputField(
                  //     name: 'upload',
                  //     keyboardType: TextInputType.text,
                  //     maxLines: 1,
                  //     controller: uploadController),

                  ElevatedButton(
                    child: const Text('Attach File or Photo to Event'),
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result == null) return;

                      final file = result.files.first;
                      final newFile = await saveFilePermanently(file);
                    },
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      Tag? newTag = await showAddTagDialog(context);
                      if (newTag != null) {
                        print("New Tag: ${newTag.name}");
                      }
                    },
                    child: const Text('Add Tag'),
                  ),

                  // ELEVATED BUTTON
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //if currentState value is true, then trigger the scaffold messenger to trigger the validator of every text form field
                          // setState(() {
                          // Form.handler.saveAll(<all fields here>)}
                          // collection.insertMany()
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Great!'),
                            ),
                          );
                          _formKey.currentState!.reset();
                        }
                      },
                      child: const Text('Save')),
                ],
              ),
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

// TODO reminders
// TODO image uploads
// TODO save to db
// TODO need a vertical scroll
// TODO make sure upload is included in form submission - do we still need the upload controller?
