import 'package:a_safe_place/Events/StandardInputField.dart';
import 'package:flutter/material.dart';



class Event extends StatefulWidget {
  Event({Key? key}) : super(key: key);

  @override
  _CreateEventState createState() => _CreateEventState();

  class _CreateEventState extends State<Event>

  final _formKey = GlobalKey<FormState>();   // handles the validator

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
    );

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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Great!'),
                          ),
                        );
                      }
                    },
                    child: const Text('Validate')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// CONTACT NAME
                // Row(children: <Widget> [

                // TextFormField(validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Enter something';
                //   }
                //   return null;
                // }),


                // ]
                // ),
