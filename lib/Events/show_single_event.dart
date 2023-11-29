import 'package:a_safe_place/Events/all_events.dart';
import 'package:a_safe_place/Events/new_event_form.dart';
import 'package:a_safe_place/database/firebase_data_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import '../models/event_item.dart';

class SingleEvent extends StatefulWidget {
  final String eventId;

  const SingleEvent({required this.eventId, Key? key}) : super(key: key);

  @override
  State<SingleEvent> createState() => _SingleEventState();
}

class _SingleEventState extends State<SingleEvent> {
  EventItem? myEvent;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      EventItem? thisEvent = await FBDataService.getEventById(widget.eventId);
      setState(() {
        myEvent = thisEvent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    "Your Event",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(250, 75, 184, 137)),
                  ),
                  SizedBox(height: 30),
                  myEvent != null
                      ? CardUI(
                          myEvent!.name,
                          myEvent!.dateTime,
                          myEvent!.location,
                          myEvent!.description,
                          myEvent!.contactName,
                          myEvent!.contactNumber,
                        )
                      : CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget CardUI(String name, DateTime dateTime, String location,
      String description, String contactName, String contactNumber) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            margin: EdgeInsets.all(1.5),
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          color: Color.fromARGB(250, 119, 104, 133),
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Date:  ', style: TextStyle(fontSize: 18)),
                    Text(dateTime.toString(), style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Location:  ', style: TextStyle(fontSize: 18)),
                    Text(location, style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Description:  ', style: TextStyle(fontSize: 18)),
                Text(description, style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Contact Name:  ', style: TextStyle(fontSize: 18)),
                    Text(contactName, style: TextStyle(fontSize: 18)),
                  ],
                ),
                SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Contact Number:  ', style: TextStyle(fontSize: 18)),
                    Text(contactNumber, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        // SEE ALL EVENTS
        ElevatedButton(
          child: const Text('Back to all events'),
          onPressed: () => Navigator.of(context).push(PageTransition(
            type: PageTransitionType.rightToLeftJoined,
            duration: const Duration(milliseconds: 800),
            reverseDuration: const Duration(milliseconds: 800),
            child: AllEvents(),
            childCurrent: Container(),
          )),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          child: const Text('Create new event'),
          // style: ElevatedButton.styleFrom(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(100),
          //   ),
          // ),
          onPressed: () => Navigator.of(context).push(
            PageTransition(
              type: PageTransitionType.rightToLeftJoined,
              duration: const Duration(milliseconds: 800),
              reverseDuration: const Duration(milliseconds: 800),
              child: NewEventForm(),
              childCurrent: Container(),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  String formatDay(EventItem event) =>
      DateFormat("EEEE").format(event.dateTime);

  String formatDate(EventItem event) =>
      DateFormat("d MMMM y").format(event.dateTime);
}
