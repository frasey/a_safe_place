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
  FBDataService.put("event", );
  FBDataService.put("state", "CA");
  FBDataService.put("country", "USA");

  db.collection("cities").document("LA")
      .set(city)
      .addOnSuccessListener(new OnSuccessListener<Void>() {
  @Override
  public void onSuccess(Void aVoid) {
  Log.d(TAG, "DocumentSnapshot successfully written!");
  }
  })
      .addOnFailureListener(new OnFailureListener() {
  @Override
  public void onFailure(@NonNull Exception e) {
  Log.w(TAG, "Error writing document", e);
  }
  });
}
