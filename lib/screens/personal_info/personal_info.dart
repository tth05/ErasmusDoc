/*
    Created by Tim Theisinger on 22.08.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:async';

import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonalInfoScreenState();
}

class PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _fieldFont = TextStyle(fontSize: 15.0, color: Colors.black);
  final _textFont = TextStyle(fontSize: 20.0);

  final _formKey = GlobalKey<FormState>();

  var _savedDate = DateTime.now();

  Widget buildTitle(String title) {
    return Text(
      title,
      style: _textFont,
    );
  }

  Widget buildTextField({bool focus = true}) {
    return TextFormField(
      style: _fieldFont,
      autofocus: focus,
      validator: (s) {
        if (s.isEmpty) {
          return "Bitte fülle dieses Feld aus.";
        }
      },
    );
  }

  Future<DateTime> waitForDatePicker(BuildContext context) {
    return showDatePicker(
        context: context,
        locale: Locale("de"),
        initialDate: _savedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.year);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daten"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.of(context).pushReplacementNamed("/home");
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView(
                  padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
                  children: <Widget>[
                    buildTitle("Name:"),
                    buildTextField(focus: true),
                    Divider(),
                    buildTitle("Wohnort:"),
                    buildTextField(),
                    Divider(),
                    buildTitle("Über mich:"),
                    buildTextField(),
                    Divider(),
                    ListTile(
                      title: buildTitle("Geburtsdatum:"),
                      subtitle: Text(_savedDate.toString().substring(0, 10)),
                      contentPadding: EdgeInsets.all(0.0),
                      onTap: () {
                        Future<DateTime> result = waitForDatePicker(context);
                        if (result == null) return;
                        result.then((dateTime) {
                          if (dateTime == null) return;
                          setState(() {
                            _savedDate = dateTime;
                          });
                        });
                      },
                    ),
                  ],
                ),
              ),
//              FlatButton(
//                child: Text("Speichern"),
//                color: Theme
//                    .of(context)
//                    .buttonColor,
//                splashColor: Colors.lightBlueAccent,
//                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                onPressed: () {
//                  if (_formKey.currentState.validate()) {
//                    Navigator.of(context).pushReplacementNamed("/home");
//                  }
//                },
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
