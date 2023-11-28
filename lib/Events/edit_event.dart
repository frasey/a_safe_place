import 'package:flutter/material.dart';

class EditEvent extends StatelessWidget {
  const EditEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: SafeArea(
            child: Column(
              children: [

                Text('Edit Your Event',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // TODO edit event content here

              ],
            ),
          ),

        ),
      ),

    );
  }
}