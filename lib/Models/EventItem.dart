import 'dart:collection';

class EventItem {
  String name;
  DateTime dateTime;

  EventItem(this.name, this.dateTime);

  // EventItem.newFromJson(some_json)
  // new EventItem('ssa','213211')

  static EventItem newFromJson(HashMap<String, dynamic> jsonFromDB) {
    String name = jsonFromDB["name"];
    DateTime dateTime = jsonFromDB["dateTime"];
    return new EventItem(name, dateTime);
  }
}
