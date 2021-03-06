/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:convert';

import 'package:erasmus_doc/managers/manager_context.dart';
import 'package:erasmus_doc/models/activity.dart';
import 'package:erasmus_doc/screens/activity_screen/widgets/select_country_dropdown.dart';
import 'package:erasmus_doc/util/common_widgets_util.dart';
import 'package:erasmus_doc/util/form_helper.dart';
import 'package:erasmus_doc/widgets/custom_app_bar.dart';
import 'package:erasmus_doc/widgets/date_picker_tile.dart';
import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class ActivityScreen extends StatefulWidget {
  final Activity activity;
  final Mode mode;

  ActivityScreen({this.activity, this.mode});

  @override
  State<StatefulWidget> createState() => ActivityScreenState(activity: activity, mode: mode);
}

class ActivityScreenState extends State<ActivityScreen> {
  var page = 0;

  Activity activity;
  final Mode mode;

  ActivityScreenState({this.activity, this.mode});

  //Zefyr
  ZefyrController _controller;
  NotusDocument _notusDocument;
  FocusNode _focusNode;

  //Form
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (mode == Mode.create) activity = Activity("", DateTime.now(), "", "");
    if (mode == Mode.view) page = 1;

    _focusNode = FocusNode();
    _notusDocument = mode == Mode.create
        ? NotusDocument()
        : NotusDocument.fromJson(json.decode(utf8.decode(base64.decode(activity.data))));
    _controller = ZefyrController(_notusDocument);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final zefyrTheme = ZefyrThemeData(
      cursorColor: Colors.black,
      selectionColor: theme.primaryColorLight,
      indentSize: 0.0,
      toolbarTheme: ZefyrToolbarTheme.fallback(context).copyWith(
        color: theme.primaryColor,
        toggleColor: theme.primaryColorLight,
      ),
    );
    final jsonManager = ManagerContext.of(context).jsonManager;

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
            mode == Mode.create ? "Neue Aktivität" : mode == Mode.edit ? "Aktivität bearbeiten" : "Aktivität ansehen"),
        centerTitle: true,
        actions: <Widget>[
          mode != Mode.view && page != 0
              ? IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    activity.data = base64.encode(utf8.encode(json.encode(_controller.document.toJson())));
                    jsonManager.saveActivity(activity).then((v) => Navigator.of(context).pop());
                  },
                )
              : Container(),
        ],
      ),
      body: page == 0
          ? Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Expanded(
                    child: ListView(
                      children: <Widget>[
                        CommonWidgetsUtil.buildStickyHeader(
                          context,
                          "Name",
                          FormHelper.buildTextField(
                            focus: mode == Mode.create ? true : false,
                            initialValue: activity.name,
                            onSaved: (value) => activity.name = value,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                        ),
                        CommonWidgetsUtil.buildStickyHeader(
                          context,
                          "Land",
                          SelectCountryDropdownButton(
                            jsonManager.countries.firstWhere((c) => c.fileName == activity.country, orElse: () => null),
                            (value) => activity.country = value.fileName,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
                        ),
                        DatePickerTile(
                          "Datum",
                          "Bitte wähle ein Datum aus.",
                          initialValue: activity.when,
                          onSaved: (value) => activity.when = value,
                          validator: (value) => null,
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              RaisedButton(
                                child: Text("Weiter"),
                                textColor: theme.primaryTextTheme.button.color,
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
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Padding(
              padding: EdgeInsets.all(2.0),
              child: Container(
                padding: EdgeInsets.all(4.0),
                decoration: mode != Mode.view
                    ? BoxDecoration(
                        border: Border.all(color: theme.primaryColor, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      )
                    : null,
                child: mode == Mode.view
                    ? SingleChildScrollView(
                        child: ZefyrView(
                        document: _notusDocument,
                        imageDelegate: ZefyrDefaultImageDelegate(),
                      ))
                    : ZefyrScaffold(
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

enum Mode { create, edit, view }
