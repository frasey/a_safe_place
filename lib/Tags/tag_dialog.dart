import 'package:flutter/material.dart';
import 'package:a_safe_place/Tags/create_new_tag_dialog.dart';
import 'package:a_safe_place/Tags/Tag.dart';

Future<Tag?> showAddTagDialog(BuildContext context, List<Tag> existingTags) async {

  List<DropdownMenuItem<Tag?>> items = [];

  if (existingTags.isNotEmpty) {
    existingTags.forEach((tag) {
      items.add(
        DropdownMenuItem(
          value: tag,
          child: Container(
            width: 200,
            child: ListTile(
          title: Text(tag.name),
          tileColor: tag.isPrimary ? tag.color : null,
          leading: tag.isPrimary
              ? null
              : Icon(
                  tag.icon,
                  color: tag.color,
                ),
            ),
          ),
        ),
      );
    });
    items.add(DropdownMenuItem<Tag?>(
      child: Divider(),
    ));
  }

  Tag? newTag = await showDialog<Tag?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add a tag'),
        content: Column(
          children: [
            DropdownButton<Tag?>(
              hint: Text('Select existing tag'),
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