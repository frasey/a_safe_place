import 'package:a_safe_place/design/design_service.dart';
import 'package:flutter/material.dart';
import 'package:a_safe_place/models/tag.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';


class CreateNewTagDialog extends StatefulWidget {
  const CreateNewTagDialog({super.key});

  @override
  _CreateNewTagDialogState createState() => _CreateNewTagDialogState();
}

class _CreateNewTagDialogState extends State<CreateNewTagDialog> {
  TextEditingController nameController = TextEditingController();
  Color selectedColor = Colors.transparent;
  bool isPrimary = false;
  IconData? selectedIcon;
  Color initialShapeColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: isPrimary ? selectedColor : null,
                    child: Stack(
                      children: [
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'Tag name',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        if (!isPrimary && selectedIcon != null)
                          Positioned(
                            right: 8.0,
                            top: 8.0,
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                ),
                              child: Icon(
                                selectedIcon,
                                color:  isPrimary ? Colors.transparent : selectedColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
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
                              availableColors: isPrimary ? DesignService.getPrimaryColours() : DesignService.getSecondaryColours(),
                              pickerColor: selectedColor,
                              onColorChanged: (color) {
                                setState(() {
                                  selectedColor = color;
                                  initialShapeColor = color;
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
                child: Text('Choose colour'),
                style: ElevatedButton.styleFrom(
                  primary: selectedColor,
                ),
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
                  items: buildShapeDropdownItems(initialShapeColor),
                ),
              ],
            ),
        ],
      ),
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
            if (!isPrimary && selectedIcon == null) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('Please pick a shape for the tag.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else {
              Tag newTag = Tag(
                  name: nameController.text,
                  color: selectedColor,
                  isPrimary: isPrimary,
                  icon: selectedIcon);
              Navigator.of(context).pop(newTag);
            }
          },
          child: const Text('Add Tag'),
        ),
      ],
    );
  }
  List<DropdownMenuItem<IconData>> buildShapeDropdownItems(Color color) {
    List<IconData> shapeIcons = [
      Icons.circle,
      Icons.square_foot,
      Icons.crop_square,
      Icons.change_history,
      Icons.arrow_forward,
      Icons.rectangle,
      Icons.filter_drama,
      Icons.star,
      Icons.pentagon,
    ];
    return shapeIcons.map((icon) {
      return DropdownMenuItem<IconData>(
        value: icon,
        child: Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 8.0), // Adjust spacing as needed
          ],
        ),
      );
    }).toList();
  }
}