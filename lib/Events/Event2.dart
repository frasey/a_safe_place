import 'package:a_safe_place/Events/StandardInputField.dart';
import 'package:a_safe_place/Database/mongodb.dart';
import 'package:flutter/material.dart';

class Event2 extends StatefulWidget {
  const Event2 ({Key? key}) : super(key: key);

  @override
  _CreateEventState<> createState() => _CreateEventState();
}

class _CreateEventState extends State<Event2> {

  final _formKey = GlobalKey<FormState>();   // handles the validator
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
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
                const StandardInputField(
                    name: 'Upload docs/images',
                    keyboardType: TextInputType.text),

                // ELEVATED BUTTON
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        //if currentState value is true, then trigger the scaffold messenger to trigger the validator of every text form field
                        collection.insertMany()
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
}
