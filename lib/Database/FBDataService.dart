import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class FBDataService{

  // INITIALISE AN INSTANCE OF THE CLOUD STORE
  FirebaseFirestore db = FirebaseFirestore.getInstance;

  // GET ALL EVENTS
  static Future<List<Event>> getEvents() async {
    List<Event> result = [];
    // code to retrieve all events from firebase
    return result;
  }

  // ADD OR EDIT EVENT
    Map<String, Object> event = new HashMap<>();
    FBDataService.put("event", /*controller info here?*/);

    // why can't this see the db?
    db.collection("users").document("event")
        .set(event)
        .addOnSuccessListener(new OnSuccessListener<Void>() {
          @Override
          public void onSuccess(Void aVoid) {
          Log.d(TAG, "Event saved!");
          }
        },
      )
        .addOnFailureListener(new OnFailureListener() {
          @Override
          public void onFailure(@NonNull Exception e) {
          Log.w(TAG, "Error writing document", e);
          }
        },
        )

    // DELETE EVENT

}
