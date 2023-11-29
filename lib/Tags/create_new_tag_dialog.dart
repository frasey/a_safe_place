import 'package:flutter/material.dart';
import 'package:a_safe_place/models/tag.dart';
import 'package:a_safe_place/tags/create_new_tag_widget.dart';


Future<Tag?> showCreateNewTagDialog(BuildContext context) async {
  return showDialog<Tag>(
    context: context,
    builder: (BuildContext context) {
      return CreateNewTagDialog();
    },
  );
}

//fix useState/setState
//have a way to select from already created tags?
//make sure the primary vs secondary thing is working