/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/screens/personal_info/widgets/select_school_dropdown.dart';
import 'package:erasmus_app/util/common_widgets_util.dart';
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
    final contentPadding = EdgeInsets.symmetric(horizontal: 6.0);

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
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  CommonWidgetsUtil.buildStickyHeader(
                    context,
                    "Name",
                    FormHelper.buildTextField(
                        initialValue: jsonManager.personalData.name, onSaved: (v) => jsonManager.personalData.name = v),
                    contentPadding: contentPadding
                  ),
                  CommonWidgetsUtil.buildStickyHeader(
                    context,
                    "Straße/Hausnummer",
                    FormHelper.buildTextField(
                        initialValue: jsonManager.personalData.addressPart1,
                        onSaved: (v) => jsonManager.personalData.addressPart1 = v),
                      contentPadding: contentPadding
                  ),
                  CommonWidgetsUtil.buildStickyHeader(
                    context,
                    "PLZ/Ort",
                    FormHelper.buildTextField(
                        initialValue: jsonManager.personalData.addressPart2,
                        onSaved: (v) => jsonManager.personalData.addressPart2 = v),
                      contentPadding: contentPadding
                  ),
                  CommonWidgetsUtil.buildStickyHeader(
                    context,
                    "E-Mail",
                    FormHelper.buildTextField(
                        initialValue: jsonManager.personalData.email,
                        onSaved: (v) => jsonManager.personalData.email = v),
                      contentPadding: contentPadding
                  ),
                  DatePickerTile("Geburtsdatum", "Bitte wähle dein Geburtsdatum aus.",
                      initialValue: jsonManager.personalData.userBirthdayDate,
                      onSaved: (v) => jsonManager.personalData.userBirthdayDate = v),
                  CommonWidgetsUtil.buildStickyHeader(
                    context,
                    "Schule",
                    SelectSchoolDropdownButton(jsonManager.personalData.school,
                        onSaved: (v) => jsonManager.personalData.school = v),
                      contentPadding: contentPadding
                  ),
                  CommonWidgetsUtil.buildStickyHeader(
                    context,
                    "Meine Interessen",
                    FormHelper.buildTextField(
                        initialValue: jsonManager.personalData.interests,
                        maxLines: 3,
                        onSaved: (v) => jsonManager.personalData.interests = v),
                      contentPadding: contentPadding
                  ),
                  CommonWidgetsUtil.buildStickyHeader(
                    context,
                    "Meine Stärken",
                    FormHelper.buildTextField(
                        initialValue: jsonManager.personalData.strengths,
                        maxLines: 3,
                        onSaved: (v) => jsonManager.personalData.strengths = v),
                      contentPadding: contentPadding
                  ),
                  CommonWidgetsUtil.buildStickyHeader(
                    context,
                    "Meine Berufsziele",
                    FormHelper.buildTextField(
                        initialValue: jsonManager.personalData.jobGoals,
                        maxLines: 3,
                        onSaved: (v) => jsonManager.personalData.jobGoals = v),
                      contentPadding: contentPadding
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
