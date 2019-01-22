/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/screens/school_screen/school_screen.dart';
import 'package:flutter/material.dart';

class SelectedSchoolButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectedSchoolButtonState();
}

class SelectedSchoolButtonState extends State<SelectedSchoolButton> {
  @override
  Widget build(BuildContext context) {
    final jsonManager = ManagerContext.of(context).jsonManager;
    final school = jsonManager.personalData.school;
    return Card(
      elevation: school != null ? 4.0 : 1.0,
      child: InkWell(
        onTap: school != null
            ? () =>
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) => SchoolScreen(school)))
            : {},
        child: Container(
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
                    school != null ? school.translatedName : "Keine Schule ausgewählt",
                    style: TextStyle(
                      color: school != null ? Colors.grey[800] : Colors.grey[600],
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: school != null ? Colors.blueAccent : Colors.grey[400],
                ),
                onPressed: school != null
                    ? () =>
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) => SchoolScreen(school)))
                    : {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
