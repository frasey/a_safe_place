import 'dart:collection';
import 'package:a_safe_place/models/tag.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventItem {
  String name;
  DateTime dateTime;
  String location;
  String description;
  // reminder
  String contactName;
  String contactNumber;
  // images
  // Tag tag;

  EventItem(
    this.name,
    this.dateTime,
    this.location,
    this.description,
    this.contactName,
    this.contactNumber,
  );

  // RETURN EVENT FROM DB
  static EventItem newFromJson(HashMap<String, dynamic> jsonFromDB) {
    String name = jsonFromDB["name"];
    DateTime dateTime = jsonFromDB["dateTime"];
    String location = jsonFromDB["location"];
    String description = jsonFromDB["description"];
    String contactName = jsonFromDB["contactName"];
    String contactNumber = jsonFromDB["contactNumber"];
    // Tag tag = jsonFromDB["tag"];
    return EventItem(
        name, dateTime, location, description, contactName, contactNumber);
  }

  // ADD EVENT TO DB
  Map<String, dynamic> toJson() {
    return {
      if (name != null) "name": name,
      if (dateTime != null) "dateTime": dateTime,
      if (location != null) "location": location,
      if (description != null) "description": description,
      if (contactName != null) "contactName": contactName,
      if (contactNumber != null) "contactNumber": contactNumber,
      // if (tag != null) "tag": tag,
    };
  }
}
