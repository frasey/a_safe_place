import 'package:flutter/material.dart';
import 'package:a_safe_place/tags/create_new_tag_dialog.dart';
import 'package:a_safe_place/tags/tag.dart';

Future<Tag?> showAddTagDialog(BuildContext context, List<Tag> existingTags) async {

  List<DropdownMenuItem<Tag?>> items = [];

  if (existingTags.isNotEmpty) {
    for (var tag in existingTags) {
      items.add(
        DropdownMenuItem(
          value: tag,
          child: Text(tag.name),
        ),
      );
    }
    items.add(const DropdownMenuItem<Tag?>(
      child: Divider(),
    ));
  }

  Tag? newTag = await showDialog<Tag?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Add a tag'),
        content: Column(
          children: [
            DropdownButton<Tag?>(
              hint: const Text('Select existing tag'),
              items: items,
              onChanged: (Tag? selectedTag) {
                Navigator.of(context).pop(selectedTag);
              },
            ),
            ElevatedButton(
              child: const Text('Create new tag'),
              onPressed: () async {
                Tag? newTag = await showCreateNewTagDialog(context);
                if (newTag != null) {
                  existingTags.add(newTag);
                  Navigator.of(context).pop(newTag);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}