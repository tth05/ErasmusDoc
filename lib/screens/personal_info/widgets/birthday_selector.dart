/*
    Created by Tim Theisinger on 08.09.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:async';

import 'package:erasmus_app/globals.dart' as globals;
import 'package:flutter/material.dart';

class BirthdaySelector extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BirthdaySelectorState();
}

class BirthdaySelectorState extends State<BirthdaySelector> {
  Future<DateTime> waitForDatePicker(BuildContext context) {
    return showDatePicker(
        context: context,
        locale: Locale("de"),
        initialDate: globals.userBirthdayDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Geburtsdatum:",
        style: TextStyle(fontSize: 20.0),
      ),
      subtitle: Text(globals.userBirthdayAsString),
      contentPadding: EdgeInsets.all(0.0),
      onTap: () {
        Future<DateTime> result = waitForDatePicker(context);
        if (result == null) return;
        result.then((dateTime) {
          if (dateTime == null) return;
          setState(() {
            globals.userBirthdayDate = dateTime;
          });
        });
      },
    );
  }
}
