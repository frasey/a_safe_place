import 'package:flutter/material.dart';
import 'package:a_safe_place/Tags/Tag.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// altered name to reflect restructuring...
Future<Tag?> showCreateNewTagDialog(BuildContext context) async {
  TextEditingController nameController = TextEditingController();
  Color selectedColor = Colors.blue;
  bool isPrimary = false;
  IconData selectedIcon = Icons.circle;

  await showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
        title: Text('Add a new tag'),
        content: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Tag name'),
            ),
            Row(
              children: [
                Text('Tag Color:'),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () async {
                    Color pickedColor = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Pick a colour'),
                          content: SingleChildScrollView(
                            child: BlockPicker(
                              pickerColor: selectedColor,
                              onColorChanged: (color) {
                                selectedColor = color;
                              },
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(selectedColor);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    // setState(() {
                    //   selectedColor = pickedColor;
                    // });
                  },
                  child: Text('Choose colour'),
                ),
              ],
            ),
            CheckboxListTile(
              title: Text('Primary tag'),
              value: isPrimary,
              onChanged: (value) {
                // setState(() {
                //   isPrimary = value ?? false;
                // });
              },
            ),
            if (!isPrimary)
              Row(
                children: [
                  Text('Tag shape:'),
                  SizedBox(width: 10),
                  DropdownButton<IconData>(
                    value: selectedIcon,
                    onChanged: (value) {
                      // setState(() {
                      //   selectedIcon = value ?? Icons.circle;
                      // });
                    },
                    items: [
                      DropdownMenuItem(
                        value: Icons.circle,
                        child: Icon(Icons.circle),
                      ),
                      DropdownMenuItem(
                        value: Icons.square_foot,
                        child: Icon(Icons.square_foot),
                      ),
                    //   add more shape icon options here...
                    ],
                  ),
                ],
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Tag newTag = Tag(name: nameController.text, color: selectedColor, isPrimary: isPrimary,  icon: selectedIcon);
              // setState(() {
              // existingTags.add(newTag);
              // });
              Navigator.of(context).pop(newTag);
            },
            child: Text('Add Tag'),
          ),
        ],
      );
    },
  );
  return null;
}

//fix useState/setState
//have a way to select from already created tags?
//make sure the primary vs secondary thing is working