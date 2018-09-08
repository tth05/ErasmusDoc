/*
    Created by Tim Theisinger on 22.08.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/screens/personal_info/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonalInfoScreenState();
}

class PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _fieldFont = TextStyle(fontSize: 15.0, color: Colors.black);
  final _textFont = TextStyle(fontSize: 20.0);

  final _formKey = GlobalKey<FormState>();

  Widget buildTitle(String title) {
    return Text(
      title,
      style: _textFont,
    );
  }

  Widget buildTextField({bool focus = false}) {
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
                    buildTextField(focus: false),
                    Divider(
                      color: Colors.white,
                    ),
                    buildTitle("Wohnort:"),
                    buildTextField(),
                    Divider(
                      color: Colors.white,
                    ),
                    buildTitle("Über mich:"),
                    TextFormField(
                      style: _fieldFont,
                      maxLines: 1,
                      maxLengthEnforced: true,
                      maxLength: 500,
                      validator: (s) {
                        if (s.isEmpty) {
                          return "Bitte fülle dieses Feld aus.";
                        }
                      },
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    BirthdaySelector(),
                    Divider(
                      color: Colors.white,
                    ),
                    SelectSchoolDropdownButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
