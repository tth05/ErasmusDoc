/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/screens/personal_info/widgets/select_school_dropdown.dart';
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
              _formKey.currentState.save();
              jsonManager.savePersonalData();
              Navigator.of(context).pushReplacementNamed("/");
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormHelper.buildTitle("Name:"),
              FormHelper.buildTextField(
                  initialValue: jsonManager.personalData.name, onSaved: (v) => jsonManager.personalData.name = v),
              FormHelper.divider,
              FormHelper.buildTitle("Straße, Hausnummer:"),
              FormHelper.buildTextField(
                  initialValue: jsonManager.personalData.addressPart1,
                  onSaved: (v) => jsonManager.personalData.addressPart1 = v),
              FormHelper.divider,
              FormHelper.buildTitle("PLZ, Ort:"),
              FormHelper.buildTextField(
                  initialValue: jsonManager.personalData.addressPart2,
                  onSaved: (v) => jsonManager.personalData.addressPart2 = v),
              FormHelper.divider,
              FormHelper.buildTitle("E-Mail:"),
              FormHelper.buildTextField(
                  initialValue: jsonManager.personalData.email, onSaved: (v) => jsonManager.personalData.email = v),
              FormHelper.divider,
              DatePickerTile("Geburtsdatum:", "Bitte wähle dein Geburtsdatum aus.",
                  initialValue: jsonManager.personalData.userBirthdayDate,
                  onSaved: (v) => jsonManager.personalData.userBirthdayDate = v),
              FormHelper.divider,
              SelectSchoolDropdownButton(jsonManager.personalData.school,
                  onSaved: (v) => jsonManager.personalData.school = v),
              FormHelper.divider,
              FormHelper.buildTitle("Meine Interessen:"),
              FormHelper.buildTextField(
                  initialValue: jsonManager.personalData.interests,
                  maxLines: 3,
                  onSaved: (v) => jsonManager.personalData.interests = v),
              FormHelper.divider,
              FormHelper.buildTitle("Meine Stärken:"),
              FormHelper.buildTextField(
                  initialValue: jsonManager.personalData.strengths,
                  maxLines: 3,
                  onSaved: (v) => jsonManager.personalData.strengths = v),
              FormHelper.divider,
              FormHelper.buildTitle("Meine Berufsziele:"),
              FormHelper.buildTextField(
                  initialValue: jsonManager.personalData.jobGoals,
                  maxLines: 3,
                  onSaved: (v) => jsonManager.personalData.jobGoals = v),
            ],
          ),
        ),
      ),
    );
  }
}
