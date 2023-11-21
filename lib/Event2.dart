import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class Event2 extends StatelessWidget {
  const Event2({Key? key}) : super(key: key);

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
                TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Event title',
                      hintStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      filled: true,
                      fillColor: Colors
                          .white, //MIGHT WANT TO CHANGE THIS IF HAVE THEME
                      contentPadding: const EdgeInsets.all(5.0),
                      focusedBorder: border,
                      enabledBorder: border,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    validator: (value) {
                      // validator will return the value of all the information entered in the text field
                      if (value == null || value.isEmpty) {
                        return 'Enter something';
                      }
                      return null;
                    }),

                // DATE * TIME
                TextFormField(validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                }),

                // LOCATION
                TextFormField(validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                }),

                // DESCRIPTION
                TextFormField(validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                }),

                // REMINDER
                TextFormField(validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                }),

                // CONTACT NAME
                TextFormField(validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                }),

                // CONTACT NUMBER
                TextFormField(validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                }),

                // UPLOAD DOCS/IMAGES
                TextFormField(validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter something';
                  }
                  return null;
                }),

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
