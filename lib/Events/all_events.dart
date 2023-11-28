import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../database/firebase_data_service.dart';
import '../models/event_item.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({super.key});

  @override
  State<AllEvents> createState() => _AllEventsState();
}

class _AllEventsState extends State<AllEvents> {
  List<EventItem> events = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<EventItem> newEvents = await FBDataService.getEvents();
      setState(() {
        events = newEvents;
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
            child: Column(
              children: [
                Text(
                  'All Events',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('Total Events: ${events.length}'),
                SizedBox(height: 30),
                ...events.map((event) => eventRow(event)),

                //TODO search and filter functionality here

                //TODO render list of all upcoming events here (or next 25 without filtering)
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDay(EventItem event) =>
      DateFormat("EEEE").format(event.dateTime);

  String formatDate(EventItem event) =>
      DateFormat("d MMMM y").format(event.dateTime);

  Widget eventRow(EventItem event) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Expanded(
                    child: Text(
                      event.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Column(
                  children: [
                    Text(
                      formatDay(event),
                      style: TextStyle(
                          fontSize: 15), // change to show date in other format
                    ),
                    Text(
                      formatDate(event),
                      style: TextStyle(
                          fontSize: 15), // change to show date in other format
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
