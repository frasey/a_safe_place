import 'package:flutter/material.dart';

class UserImages extends StatelessWidget {
  const UserImages({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text('Your photos and documents',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // TODO list/tiles of uploaded images
                // TODO search by attached event/tag?

              ],
            ),
          ),

        ),
      ),

    );
  }
}