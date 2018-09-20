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
    return GestureDetector(
      onTap: globals.selectedSchool != null
          ? () =>
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) => SchoolScreen(globals.selectedSchool)))
          : null,
      child: Card(
        elevation: globals.selectedSchool != null ? 4.0 : 1.0,
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
                    globals.selectedSchool != null ? globals.selectedSchool.translatedName : "Keine Schule ausgewählt",
                    style: TextStyle(
                      color: globals.selectedSchool != null ? Colors.grey[800] : Colors.grey[600],
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: globals.selectedSchool != null ? Colors.blueAccent : Colors.grey[400],
                ),
                onPressed: globals.selectedSchool != null
                    ? () =>
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) => SchoolScreen(globals.selectedSchool)))
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
