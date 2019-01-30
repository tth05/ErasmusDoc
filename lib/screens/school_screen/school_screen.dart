/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/models/school.dart';
import 'package:erasmus_app/widgets/custom_app_bar.dart';
import 'package:erasmus_app/widgets/global_drawer.dart';
import 'package:flutter/material.dart';

class SchoolScreen extends StatefulWidget {
  final School school;

  @override
  State<StatefulWidget> createState() => SchoolScreenState(school);

  SchoolScreen(this.school);
}

class SchoolScreenState extends State<SchoolScreen> {
  final School school;

  SchoolScreenState(this.school);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed("/");
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text("Info"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pushReplacementNamed("/"),
          ),
        ),
        endDrawer: GlobalDrawer(),
        body: Padding(
          padding: EdgeInsets.all(4.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          school.translatedName,
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Divider(),
                        Text(
                          school.info,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        Divider(),
                        Text(
                          school.address,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(4.0),
                  child: Text(
                    "Projekte",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                Divider(),
                Column(
                  children: List.generate(
                    10,
                    (index) => ListTile(
                          leading: Icon(Icons.airport_shuttle),
                          title: Text(
                            "Projekt ${index + 1}",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          subtitle: Text(""),
                          trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent), onPressed: () => {}),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
