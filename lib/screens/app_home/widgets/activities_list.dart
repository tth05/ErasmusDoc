/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

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
        Column(
          children: List.generate(
            10,
            (index) => Card(
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
                            "Projekt $index",
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => {},
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.of(context).pushNamed("/create_activity"),
                      )
                    ],
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
