/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/globals.dart' as globals;
import 'package:erasmus_app/screens/school_screen/school_screen.dart';
import 'package:flutter/material.dart';

class SelectedSchoolButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectedSchoolButtonState();
}

class SelectedSchoolButtonState extends State<SelectedSchoolButton> {
  @override
  Widget build(BuildContext context) {
    if (globals.selectedSchool != null) {
      return Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Meine Schule:",
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Text(
                    globals.selectedSchool.translatedName,
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.blueAccent,
                ),
                onPressed: () => Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) => SchoolScreen(globals.selectedSchool))),
              ),
            ],
          ),
        ),
      );
    } else {
      return Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Meine Schule:",
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Text(
                    "Keine Schule ausgewählt",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                ),
                onPressed: null,
              ),
            ],
          ),
        ),
      );
    }
  }
}
