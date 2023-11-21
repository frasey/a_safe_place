import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StandardInputField extends StatelessWidget {
  final String name;
  final TextInputType keyboardType;

  const StandardInputField(
      {super.key, required this.name, required this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Event title',
                    hintStyle: const TextStyle(
                      fontSize: 20,
                    ),
                    filled: true,
                    fillColor:
                        Colors.white, //MIGHT WANT TO CHANGE THIS IF HAVE THEME
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
                  },
                  );
  }