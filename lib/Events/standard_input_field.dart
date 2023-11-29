import 'package:flutter/material.dart';


class StandardInputField extends StatelessWidget {
  final String name;
  final TextInputType keyboardType;
  final int? maxLines;
  final TextEditingController controller;
  final bool requireValidation;


  const StandardInputField(
      {super.key, required this.name, required this.keyboardType, required this.maxLines,
        required this.controller, this.requireValidation = false});

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
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: name,
          hintStyle: const TextStyle(
            fontSize: 20,
          ),
          filled: true,
          fillColor: Colors.white,    //TODO MIGHT WANT TO CHANGE THIS IF HAVE THEME
          contentPadding: const EdgeInsets.all(5.0),
          focusedBorder: border,
          enabledBorder: border,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        validator: requireValidation
          ? (value) {
          // validator will return the value of all the information entered in the text field
          if (value == null || value.isEmpty) {
            return 'Please enter $name';
          }
          return null;
        }
        : null,
      ),
    );
  }
}
