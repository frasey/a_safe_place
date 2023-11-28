import 'package:flutter/material.dart';
import 'package:a_safe_place/tags/tag.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CreateNewTagDialog extends StatefulWidget {
  const CreateNewTagDialog({super.key});

  @override
  _CreateNewTagDialogState createState() => _CreateNewTagDialogState();
}

class _CreateNewTagDialogState extends State<CreateNewTagDialog> {
  TextEditingController nameController = TextEditingController();
  Color selectedColor = Colors.blue;
  bool isPrimary = false;
  IconData selectedIcon = Icons.circle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add a new tag'),
      content: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Tag name'),
          ),
          Row(
            children: [
              const Text('Tag Color:'),
              const SizedBox(width: 10),
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
                              setState(() {
                                selectedColor = color;
                              });
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(selectedColor);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Choose colour'),
              ),
            ],
          ),
          CheckboxListTile(
            title: const Text('Primary tag'),
            value: isPrimary,
            onChanged: (value) {
              setState(() {
                isPrimary = value ?? false;
              });
            },
          ),
          if (!isPrimary)
            Row(
              children: [
                const Text('Tag shape:'),
                const SizedBox(width: 10),
                DropdownButton<IconData>(
                  value: selectedIcon,
                  onChanged: (value) {
                    setState(() {
                      selectedIcon = value ?? Icons.circle;
                    });
                  },
                  items: const [
                     DropdownMenuItem(
                      value: Icons.circle,
                      child: Icon(Icons.circle),
                    ),
                     DropdownMenuItem(
                      value: Icons.square_foot,
                      child: Icon(Icons.square_foot),
                    ),
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
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            Tag newTag = Tag(name: nameController.text, color: selectedColor, isPrimary: isPrimary,  icon: selectedIcon);
            Navigator.of(context).pop(newTag);
          },
          child: const Text('Add Tag'),
        ),
      ],
    );
  }
}