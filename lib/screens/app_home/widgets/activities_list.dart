/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:math';

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/models/activity.dart';
import 'package:erasmus_app/screens/activity_screen/activity_screen.dart';
import 'package:erasmus_app/util/common_widgets_util.dart';
import 'package:flutter/material.dart';
import 'package:erasmus_app/globals.dart' as globals;

class ActivitiesList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActivitiesListState();
}

class ActivitiesListState extends State<ActivitiesList> {
  @override
  Widget build(BuildContext context) {
    final jsonManager = ManagerContext.of(context).jsonManager;
    final theme = Theme.of(context);
    final random = Random();

    return CommonWidgetsUtil.buildStickyHeader(
      context,
      "Aktivitäten",
      FutureBuilder<List<Activity>>(
        future: jsonManager.loadActivities(),
        builder: (BuildContext context, AsyncSnapshot<List<Activity>> snapshot) {
          if (snapshot.hasData && snapshot.data != null && snapshot.data.isNotEmpty) {
            return Column(
              children: snapshot.data.map((a) {
                return CommonWidgetsUtil.buildSimpleInfoCard(
                  leading: Image.asset(
                    "assets/countries/${jsonManager.countries[random.nextInt(5)].fileName}/flag.png",
                    width: 40.0,
                  ),
                  title: a.name,
                  subtitle: "Land\n${globals.dateFormat.format(a.when)}",
                  dense: true,
                  divider: snapshot.data.indexOf(a) != snapshot.data.length - 1,
                  dividerIndent: 60.0,
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => ActivityScreen(activity: a, mode: Mode.view))),
                  trailing: Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => ActivityScreen(activity: a, mode: Mode.edit))),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Möchtest du diese Aktivität wirklich löschen?"),
                                    content: Text("Alle vorhandenen Daten gehen verloren."),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Abbrechen"),
                                        onPressed: () => Navigator.of(context).pop(),
                                      ),
                                      FlatButton(
                                        child: Text("Ja"),
                                        onPressed: () {
                                          jsonManager.deleteActivity(a);
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          } else
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Keine vorhandenen Aktivitäten",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontSize: 20.0,
                  ),
                ),
              ],
            );
        },
      ),
    );
  }
}
