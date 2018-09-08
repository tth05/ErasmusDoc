/*
    Created by Tim Theisinger on 08.09.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/globals.dart' as globals;
import 'package:flutter/material.dart';

class SelectSchoolDropdownButton extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectSchoolDropdownButtonState();
}

class SelectSchoolDropdownButtonState extends State<SelectSchoolDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: globals.schools.map((String val) {
        return DropdownMenuItem(
          value: val,
          child: Text(val),
        );
      }).toList(),
      hint: Text(
        globals.selectedSchool == "" ? "Schule" : globals.selectedSchool,
        style: TextStyle(
          fontSize: 20.0,
          color: globals.selectedSchool == "" ? Colors.grey : Colors.black,
        ),
      ),
      onChanged: (String s) {
        setState(() {
          globals.selectedSchool = s;
        });
      },
    );
  }
}
