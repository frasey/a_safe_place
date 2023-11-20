import 'package:flutter/material.dart';

class Event extends StatefulWidget {
  const Event({super.key});

  @override
  State<Event> createState() => _EventState();
}

class _EventState extends State<Event> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Event title',
                      hintStyle: TextStyle(
                        fontSize: 20,
                      ),
                      filled: true,
                      fillColor: Colors
                          .white, // MIGHT WANT TO CHANGE THIS IF SET THEME
                      contentPadding: EdgeInsets.all(5),
                      focusedBorder: border,
                      enabledBorder: border,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
