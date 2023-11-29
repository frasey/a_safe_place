import 'package:flutter/material.dart';
import 'package:a_safe_place/tags/create_new_tag_dialog.dart';
import 'package:a_safe_place/models/tag.dart';


Future<void> showAddTagDialog(
    BuildContext context,
    List<Tag> allUserTags,
    {required Function(List<Tag>) updateEventTags}
   ) async {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  List<DropdownMenuItem<Tag?>> items = [];
  List<Tag> selectedTags = [];

  if (allUserTags.isNotEmpty) {
    for (var tag in allUserTags) {
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
    }
    items.add(const DropdownMenuItem<Tag?>(
      child: Divider(),
    ));
  }

  await showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            key: formKey,
            title: const Text('Add tags'),
            content: Column(
              children: [
                DropdownButton<Tag?>(
                  hint: const Text('Choose from your tags'),
                  items: items,
                  onChanged: (Tag? selectedTag) {
                    setState(() {
                      if (selectedTag != null) {
                        selectedTags.add(selectedTag);
                      }
                    });
                  },
                ),
                ElevatedButton(
                  child: const Text('Create new tag'),
                  onPressed: () async {
                    Tag? newTag = await showCreateNewTagDialog(context);
                    if (newTag != null) {
                      setState(() {
                        allUserTags.add(newTag);
                        selectedTags.add(newTag);
                      });
                    }
                  },
                ),
                if (selectedTags.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text('Selected tags:'),
                      for (var selectedTag in selectedTags)
                        Container(
                          width: 200,
                          child: ListTile(
                            title: Text(selectedTag.name),
                            tileColor: selectedTag.isPrimary ? selectedTag.color : null,
                            leading: selectedTag.isPrimary
                                ? null
                                : Icon(
                              selectedTag.icon,
                              color: selectedTag.color,
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  formKey.currentState?.save();
                  updateEventTags(selectedTags);
                  Navigator.of(context).pop(selectedTags);
                },
                child: const Text('Add tags'),
              ),
            ],
          );
        },
      );
    },
  );
}