import 'package:flutter/material.dart';

class StandardInputField extends StatelessWidget {
  final String name;
  final TextInputType keyboardType;

  const StandardInputField(
      {super.key, required this.name, required this.keyboardType});

  @override
  Widget build(BuildContext context) {

    TextEditingController textEditingController = TextEditingController();

    const border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: name,
          hintStyle: const TextStyle(
            fontSize: 20,
          ),
          filled: true,
          fillColor: Colors.white, //MIGHT WANT TO CHANGE THIS IF HAVE THEME
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
      ),
    );
  }
}
