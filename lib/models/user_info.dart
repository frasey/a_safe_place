import 'event_item.dart';
import '../tags/tag.dart';

class UserInfo{
  String userName;
  late Tag tags;
  late EventItem events;
  // user docs/images

  UserInfo({
    required this.userName,
    required this.tags,
    required this.events});

}

