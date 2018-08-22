/*
    Created by Tim Theisinger on 22.08.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:async';

import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatelessWidget {
  var _fieldFont = TextStyle(fontSize: 15.0, color: Colors.black);
  var _textFont = TextStyle(fontSize: 20.0);

  Widget buildTitle(String title) {
    return ListTile(
      contentPadding: EdgeInsets.only(top: 10.0),
      title: Text(
        title,
        style: _textFont,
      ),
    );
  }

  Widget buildTextField() {
    return TextField(
      style: _fieldFont,
    );
  }

  Future<DateTime> waitForDatePicker(BuildContext context) {
    return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daten"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(children: <Widget>[
          Flexible(
            child: ListView(
              padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              children: <Widget>[
                buildTitle("Name:"),
                buildTextField(),
                buildTitle("Geburtsdatum:"),
                RaisedButton(
                  child: Text("Auswählen"),
                  color: Theme.of(context).buttonColor,
                  splashColor: Colors.lightBlueAccent,
                  onPressed: () {
                    Future<DateTime> result = waitForDatePicker(context);
                    if (result == null) return;
                    result.then((dateTime) => print(dateTime));
                  },
                ),
                buildTitle("Wohnort:"),
                buildTextField(),
                buildTitle("Über mich:"),
                buildTextField(),
              ],
            ),
          ),
          RaisedButton(
            child: Text("Fertig"),
            color: Theme.of(context).buttonColor,
            splashColor: Colors.lightBlueAccent,
            onPressed: () => Navigator.of(context).pushReplacementNamed("/home"),
          ),
        ]),
      ),
    );
  }
}
