/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/models/activity.dart';
import 'package:erasmus_app/screens/activity_screen/activity_screen.dart';
import 'package:flutter/material.dart';

class ActivityListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActivityListViewState();
}

class ActivityListViewState extends State<ActivityListView> {
  @override
  Widget build(BuildContext context) {
    final jsonManager = ManagerContext.of(context).jsonManager;

    return Column(
      children: <Widget>[
        Text(
          "Aktivitäten",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
          ),
        ),
        FutureBuilder<List<Activity>>(
          future: jsonManager.loadActivities(),
          builder: (BuildContext context, AsyncSnapshot<List<Activity>> snapshot) {
            if (snapshot.hasData && snapshot.data != null && snapshot.data.isNotEmpty) {
              return Column(
                children: snapshot.data
                    .map(
                      (activity) => Card(
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ActivityScreen(activity: activity, mode: Mode.view))),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        bottomLeft: Radius.circular(4.0),
                                      ),
                                    ),
                                    width: 20.0,
                                    height: 60.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        "Name: ${activity.name}",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      showDialog(
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
                                                  jsonManager.deleteActivity(activity);
                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => ActivityScreen(activity: activity, mode: Mode.edit))),
                                  )
                                ],
                              ),
                            ),
                          ),
                    )
                    .toList(),
              );
            } else
              return Text(
                "Keine vorhandenen Aktivitäten",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 20.0,
                ),
              );
          },
        ),
      ],
    );
  }
}
