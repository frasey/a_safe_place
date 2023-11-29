import 'dart:io';
import 'package:a_safe_place/events/standard_input_field.dart';
import 'package:a_safe_place/models/event_item.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:a_safe_place/models/tag.dart';
import 'package:a_safe_place/tags/tag_dialog.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../database/firebase_data_service.dart';
import 'date_time_picker.dart';

class NewEventForm extends StatefulWidget {
  const NewEventForm({Key? key}) : super(key: key);

  @override
  State<NewEventForm> createState() => _NewEventFormState();
}

class _NewEventFormState extends State<NewEventForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateAndTimeController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController reminderController = TextEditingController();
  final TextEditingController contactNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController uploadController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();

  // !!!TEMPORARY TAG STORAGE!!!
  List<Tag> selectedTags = [];

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
      //TODO await db connect here?
      print("post db");
    });
  }

  // DateTime selectedDate = DateTime.now();
  // TimeOfDay selectedTime = TimeOfDay.now();

  void dateTimeChanged(DateTime newDate, TimeOfDay newTime) {
    print("callback!");
    setState(() {
      dateTime = newDate;
      timeOfDay = newTime;
    });
    print("dateTimeChanged! $newDate $newTime");
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
                  // DATE & TIME
                  InkWell(
                    onTap: () {
                      // Show the DateTimePicker as a dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 300,
                              child: DateTimePicker(callback: dateTimeChanged),
                            ),
                          );
                        },
                      );
                    },
                    child: const SizedBox(
                      width: 300,
                      height: 50,
                      child: Center(
                        child: Text(
                          'Select Date and Time',
                        ),
                      ),
                    ),
                  ),

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
                  const Text(
                    'Want to add a file?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: selectFile,
                            child: const Text('Select'),
                            // TODO code to select image here?
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
                        ]),
                  ),

                  // ADD TAGS BUTTON
                  ElevatedButton(
                    child: const Text('Add tag'),
                    onPressed: () async {
                      Tag? newTag =
                          await showAddTagDialog(context, selectedTags);
                      if (newTag != null) {
                        setState(() {
                          selectedTags.add(newTag);
                        });
                      }
                    },
                  ),

                  // SAVE FORM
                  ElevatedButton(
                    child: const Text('Create Event'),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        //if currentState value is true, then trigger the scaffold messenger to trigger the validator of every text form field
                        saveToDB();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Saved!'),
                          ),
                        );
                        _formKey.currentState!.reset();
                      }
                    },
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
  Future<void> saveToDB() async {
    DateTime combineDateTime = DateTime(dateTime.year, dateTime.month,
        dateTime.day, timeOfDay.hour, timeOfDay.minute);
    EventItem newEvent = EventItem(
      titleController.value.text,
      combineDateTime,
      locationController.value.text,
      descriptionController.value.text,
      //reminderController.value.text,
      contactNameController.value.text,
      contactNumberController.value.text,
      // TODO tag needs to go in here somehow
    );
    FBDataService.addEvent(newEvent);
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
