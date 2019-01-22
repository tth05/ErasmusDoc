/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/screens/personal_info/widgets/widgets.dart';
import 'package:erasmus_app/util/form_helper.dart';
import 'package:erasmus_app/widgets/custom_app_bar.dart';
import 'package:erasmus_app/widgets/date_picker_tile.dart';
import 'package:flutter/material.dart';

class PersonalInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonalInfoScreenState();
}

class PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final jsonManager = ManagerContext.of(context).jsonManager;

    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Daten"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Navigator.of(context).pushReplacementNamed("/");
              }
            },
          ),
        ],
      ),
      //TODO: Add maxLength checks for all TextFields
      //TODO: Disallow special characters to not break anything for all TextFields
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormHelper.buildTitle("Name:"),
              FormHelper.buildTextField(focus: false),
              Divider(
                color: Colors.grey[50],
              ),
              FormHelper.buildTitle("Wohnort:"),
              FormHelper.buildTextField(),
              Divider(
                color: Colors.grey[50],
              ),
              FormHelper.buildTitle("Über mich:"),
              FormHelper.buildTextField(),
              Divider(
                color: Colors.grey[50],
              ),
              DatePickerTile(
                "Geburtsdatum:",
                "Bitte wähle dein Geburtsdatum aus.",
                initialValue: jsonManager.personalData.userBirthdayDate,
              ),
              Divider(
                color: Colors.grey[50],
              ),
              SelectSchoolDropdownButton(),
            ],
          ),
        ),
      ),
    );
  }
}
