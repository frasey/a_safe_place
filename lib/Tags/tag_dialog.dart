import 'package:flutter/material.dart';
import 'package:a_safe_place/tags/create_new_tag_dialog.dart';
import 'package:a_safe_place/models/tag.dart';



Future<void> showAddTagDialog(
    BuildContext context,
    List<Tag> allUserTags,
    List<Tag> eventTags, {
      required Function(List<Tag>) updateEventTags,
      required Function(List<Tag>) updateAllUserTags,
    }
  ) async {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<Tag?>> items = [];
  List<Tag> selectedTags = [];
  List<Tag> newTags = [];
  List<Tag> displayTags = [];
  displayTags.addAll(eventTags);


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
                const Text('Choose from your tags'),
                if (allUserTags.isNotEmpty)
                  DropdownButton<Tag?>(
                    items: [
                      ...items,
                    ],
                    onChanged: (Tag? selectedTag) {
                      setState(() {
                        if (selectedTag != null) {
                          displayTags.add(selectedTag);
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
                        // allUserTags.add(newTag);
                        selectedTags.add(newTag);
                        displayTags.add(newTag);
                        newTags.add(newTag);
                      });
                    }
                  },
                ),
                if (displayTags.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text('Event tags:'),
                      for (var displayTag in displayTags)
                        Container(
                          width: 200,
                          child: ListTile(
                            title: Text(displayTag.name),
                            tileColor: displayTag.isPrimary ? displayTag.color : null,
                            leading: displayTag.isPrimary
                                ? null
                                : Icon(
                              displayTag.icon,
                              color: displayTag.color,
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
                  updateAllUserTags(newTags);
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

// TODO: check for later
// DropdownMenuItem<Tag?>(
// value: null,
// child: const Text('Choose from your tags'),
// ),