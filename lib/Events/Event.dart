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
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  PlatformFile? pickedFile;

  Future uploadFile() async {
    final path = 'files/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    // final ref = FirebaseStorage.instance.ref().child(path);
    // ref.putFile(file);
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

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
                  if (pickedFile != null)
                    Expanded(
                      child: Container(
                        child: Image.file(
                          File(pickedFile!.path!),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
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
                      maxLines: 4,
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
                  
                  // UPLOAD BUTTONS
                  const Text('Want to add a file?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
    ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child:
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                        onPressed: selectFile,
                        child: const Text('Select'),

                    // {
                    //     final result = await FilePicker.platform.pickFiles();
                    //     if (result == null) return;
                    //
                    //     final file = result.files.first;
                    //     final newFile = await saveFilePermanently(file);
                    //   },
                        ),
                        ElevatedButton(
                          onPressed: uploadFile,
                          child: const Text('Upload'),
                        ),
                  ]
                ),
              ),

                  // ADD TAGS BUTTON
                  ElevatedButton(
                        child: const Text('Add Tag'),
                        onPressed: () async {
                        Tag? newTag = await showAddTagDialog(context);
                        if (newTag != null) {
                          print("New Tag: ${newTag.name}");
                        }
                      },
                  ),

                  // SAVE FORM
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //if currentState value is true, then trigger the scaffold messenger to trigger the validator of every text form field
                          saveJsonToFirestore();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Great!'),
                            ),
                          );
                          _formKey.currentState!.reset();
                        }
                      },
                      child: const Text('Save'),
                  ),
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
  // can save a thing with this func?
  Future<void> saveJsonToFirestore() async {
    Map<String, dynamic> dummyData = {
      'name': 'John Doe',
      'age': 25,
      'city': 'Example City',
      // Add more fields as needed
    };
    await _firestore.collection('a-safe-test').add(dummyData);
  }

  void openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}

// TODO reminders
// TODO image uploads
// TODO save to db
// TODO make upload/submit image form buttons smaller? or move tags somewhere else?
// TODO make sure images are saving to the event and not just db
