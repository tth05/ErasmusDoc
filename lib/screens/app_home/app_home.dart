/*
    Created by Tim Theisinger on 22.08.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/
import 'package:erasmus_app/globals.dart' as globals;
import 'package:flutter/material.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  AppHomeState createState() => new AppHomeState();
}

class AppHomeState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.person), onPressed: () => Navigator.of(context).pushNamed("/")),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(globals.selectedSchool)],
        ),
      ),
    );
  }
}