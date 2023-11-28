import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';


class DateTimePicker extends StatefulWidget{
   DateTimePicker({super.key, callback}){
    this.callback = callback;
  }
  Function callback = (d,t){print("what?");};

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.callback(picked, selectedTime);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
      widget.callback( selectedDate , picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date & Time'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Date: ${DateFormat('dd-MM-yyy').format(selectedDate)}',
            ),
            Text(
              'Selected Time: ${selectedTime.format(context)}',
            ),
            const SizedBox(height:20),
            ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text(
                  'Select date'
                ),
            ),
            ElevatedButton(
                onPressed: () => _selectTime(context),
                child: const Text(
                  'Select time'
                ))
          ],
        ),
      ),
      ),
    );
  }
}