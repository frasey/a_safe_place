import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/event_item.dart';

// FBDataService dbs = new FBDataService();
// dbs.addEvent();
//
// FBDataService.addEvent(???);

class FBDataService {
  // INITIALISE AN INSTANCE OF THE CLOUD STORE
  FirebaseFirestore db = FirebaseFirestore.instance;

  // GET ALL EVENTS
  static Future<List<EventItem>> getEvents() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection('events').get();
    final allDocs = querySnapshot.docs.map((doc) => doc.data()).toList();

    List<EventItem> itemsFromDB = [];
    for (var dataMap in allDocs) {
      if (dataMap is Map) {
        // add a type check to ensure dataMap is a Map
        DateTime dateTimeObject = dataMap['dateTime'].toDate();
        EventItem eventItem = EventItem(
            dataMap['name'],
            dateTimeObject,
            dataMap['location'],
            dataMap['description'],
            dataMap['contactName'],
            dataMap['contactNumber']
            // dataMap['tag']
            );
        itemsFromDB.add(eventItem);
      }
    }
    return itemsFromDB;
  }

  //GET FIRST EVENT IN COLLECTION
  static Future<EventItem?> getOneEvent() async {
    CollectionReference eventFireStoreRef =
        FirebaseFirestore.instance.collection('events');

    try {
      // Get the first document from the 'events' collection
      QuerySnapshot querySnapshot = await eventFireStoreRef.limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        // Convert the document data to EventItem
        Map<String, dynamic> eventData =
            querySnapshot.docs.first.data() as Map<String, dynamic>;

        EventItem eventItem = EventItem(
          eventData['name'] as String? ?? '',
          eventData['dateTime'] != null
              ? (eventData['dateTime'] is Timestamp
                  ? (eventData['dateTime'] as Timestamp).toDate()
                  : DateTime.parse(eventData['dateTime'] as String))
              : DateTime.now(),
          eventData['location'] as String? ?? '',
          eventData['description'] as String? ?? '',
          eventData['contactName'] as String? ?? '',
          eventData['contactNumber'] as String? ?? '',
        );

        return eventItem;
      } else {
        // No document found
        print('Error fetching event: $e');
        return null;
      }
    } catch (e) {
      // Handle any errors that occurred during the fetch
      print('Error fetching event: $e');
      return null;
    }
  }

  // GET EVENT BY DOCUMENT ID
  static Future<EventItem?> getEventById(eventId) async {
    CollectionReference eventFirestoreRef =
        FirebaseFirestore.instance.collection('events');

    try {
      // Get the document from the 'events' collection based on the document ID (which is the event ID)
      DocumentSnapshot documentSnapshot =
          await eventFirestoreRef.doc(eventId).get();

      if (documentSnapshot.exists) {
        // Convert the document data to EventItem
        Map<String, dynamic> eventData =
            documentSnapshot.data() as Map<String, dynamic>;

        EventItem eventItem = EventItem(
          eventData['name'] as String? ?? '',
          eventData['dateTime'] != null
              ? (eventData['dateTime'] is Timestamp
                  ? (eventData['dateTime'] as Timestamp).toDate()
                  : DateTime.parse(eventData['dateTime'] as String))
              : DateTime.now(),
          eventData['location'] as String? ?? '',
          eventData['description'] as String? ?? '',
          eventData['contactName'] as String? ?? '',
          eventData['contactNumber'] as String? ?? '',
        );

        return eventItem;
      } else {
        // No document found
        return null;
      }
    } catch (e) {
      // Handle any errors that occurred during the fetch
      print('Error fetching event: $e');
      return null;
    }
  }

  // ADDS ONE EVENT
  static void addEvent(EventItem newEvent) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection('events').get();

    Random random = new Random();
    String newId =
        "${newEvent.name.replaceAll(' ', '-')} ${random.nextInt(10000000)}";

    Map<String, dynamic> eventAsJson = newEvent.toJson();
    db
        .collection("events")
        .doc(newId)
        .set(eventAsJson)
        .onError((e, _) => print("Error writing document: $e"));
  }
}

//
//
// List<Event> result = [];
// // code to retrieve all events from firebase
// db.collection("users").doc("event")
//
//     .document("event")
//     .set(event)
//     .addOnSuccessListener(new OnSuccessListener<Void>() {
// @Override
// public void onSuccess(Void aVoid) {
// Log.d(TAG, "Event saved!");
//
// return result;

// ADD OR EDIT EVENT
// static Null addToDB( Event event) {
// Map<String, Object> event = new HashMap();
// FBDataService.put("event", /*controller info here?*/);
//
// // why can't this see the db?
// db.collection("users").document("event")
//     .set(event)
//     .addOnSuccessListener(new OnSuccessListener<Void>() {
// @Override
// public void onSuccess(Void aVoid) {
// Log.d(TAG, "Event saved!");
// }
// },
// )
//     .addOnFailureListener(new OnFailureListener() {
// @Override
// public void onFailure(@NonNull Exception e) {
// Log.w(TAG, "Error writing document", e);
// }
// },
// );
// }
// DELETE EVENT

// }
