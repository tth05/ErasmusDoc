/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/globals.dart' as globals;
import 'package:erasmus_app/models/activity.dart';
import 'package:flutter/material.dart';

class ActivityListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActivityListViewState();
}

class ActivityListViewState extends State<ActivityListView> {

  @override
  Widget build(BuildContext context) {
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
          future: globals.jsonManager.loadActivities(),
          builder: (BuildContext context, AsyncSnapshot<List<Activity>> snapshot) {
            if(snapshot.hasData && snapshot.data != null && snapshot.data.isNotEmpty) {
                return Column(
                  children: snapshot.data.map(
                        (activity) => Card(
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
                              globals.jsonManager.deleteActivity(activity);
                              setState(() {});
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => {},
                          )
                        ],
                      ),
                    ),
                  ).toList(),
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
