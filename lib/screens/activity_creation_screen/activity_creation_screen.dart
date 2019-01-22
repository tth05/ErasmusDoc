/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:convert';

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/models/activity.dart';
import 'package:erasmus_app/util/form_helper.dart';
import 'package:erasmus_app/widgets/custom_app_bar.dart';
import 'package:erasmus_app/widgets/date_picker_tile.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class ActivityCreationScreen extends StatefulWidget {
  Activity activity;

  ActivityCreationScreen({this.activity});

  @override
  State<StatefulWidget> createState() => ActivityCreationScreenState(activity: activity);
}

class ActivityCreationScreenState extends State<ActivityCreationScreen> {
  var page = 0;

  Activity activity;

  ActivityCreationScreenState({this.activity});

  //Zefyr
  ZefyrController _controller;
  FocusNode _focusNode;

  //Form
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = ZefyrController(activity == null ? NotusDocument() : NotusDocument.fromJson(
        json.decode(utf8.decode(base64.decode(activity.data)))));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zefyrTheme = new ZefyrThemeData(
      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: Colors.blueAccent,
        toggleColor: Colors.blueAccent[400],
      ),
    );
    final jsonManager = ManagerContext.of(context).jsonManager;

    if (activity == null) activity = Activity("", DateTime.now(), "");

    return Scaffold(
      appBar: CustomAppBar(
        title: Text("Neue Aktivität"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              activity.data = base64.encode(utf8.encode(json.encode(_controller.document.toJson())));
              jsonManager.saveActivity(activity);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: page == 0
          ? Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FormHelper.buildTitle("Name:"),
                  FormHelper.buildTextField(
                      focus: true,
                      initialValue: activity.name,
                      onSaved: (value) => activity.name = value),
                  Divider(color: Colors.grey[50]),
                  DatePickerTile(
                    "Datum:",
                    "Bitte wähle ein Datum aus.",
                    initialValue: activity.when,
                    onSaved: (value) => activity.when = value,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text("Weiter"),
                  textColor: Colors.white,
                  elevation: 4.0,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      setState(() {
                        page = 1;
                      });
                    }
                  },
                ),
              ],
            )
          ],
        ),
      )
          : Padding(
        padding: EdgeInsets.all(2.0),
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: ZefyrScaffold(
            child: ZefyrTheme(
              data: zefyrTheme,
              child: ZefyrEditor(
                padding: EdgeInsets.all(0),
                autofocus: true,
                controller: _controller,
                focusNode: _focusNode,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
