import 'package:flutter/material.dart';

class AllEvents extends StatelessWidget {
  const AllEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: SafeArea(
            child: Column(
              children: [

                Text('All Events',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
                ),

                //TODO search and filter functionality here

                //TODO render list of all upcoming events here (or next 25 without filtering)

              ],
            ),
          ),

        ),
      ),

    );
  }
}