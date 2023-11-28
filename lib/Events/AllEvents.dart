import 'package:flutter/material.dart';

import '../Database/FBDataService.dart';
import '../Models/EventItem.dart';

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

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   WidgetsBinding.instance?.addPostFrameCallback((_) async {
  //     setState(() {
  //       // Write your code here
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0),
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

  Widget eventRow(EventItem event) {
    return Padding(
      //add gesturedetector
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(event.name),
          Text(
              event.dateTime.toString()), // change to show date in other format
        ],
      ),
    );
  }
}
