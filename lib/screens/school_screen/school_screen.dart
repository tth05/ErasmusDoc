/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/data/school.dart';
import 'package:flutter/material.dart';

class SchoolScreen extends StatefulWidget {
  final School school;

  @override
  State<StatefulWidget> createState() => SchoolScreenState(school);

  SchoolScreen(this.school);
}

class SchoolScreenState extends State<SchoolScreen> {
  final School school;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacementNamed("/"),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/schools/${school.fileName}/3.0x/small_logo.png",
            fit: BoxFit.scaleDown,
          ),
        ],
      ),
    );
  }

  SchoolScreenState(this.school);
}
