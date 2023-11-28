import 'package:flutter/material.dart';

import 'Tags/Tag.dart';

class UserInfo{
  String userName;
  late Tag tags;
  late EventItem events;
  // user docs/images

  UserInfo({
    required this.userName,
    required this.tags,
    this.events});
  
}

