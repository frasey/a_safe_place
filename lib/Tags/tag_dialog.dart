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
          child: Text(tag.name),
        ),
      );
    });
    items.add(DropdownMenuItem<Tag?>(
      child: Divider(),
    ));
  }

  ElevatedButton(
    child: const Text('Create new tag'),
    onPressed: () async {
      Tag? newTag = await showCreateNewTagDialog(context);
      if (newTag != null) {
        // setState(() {
          existingTags.add(newTag);
        // });
      }
    }
  );
}