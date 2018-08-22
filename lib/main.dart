/*
    Created by Tim Theisinger on 19.08.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:async';

import 'package:erasmus_app/screens/app_home/app_home.dart';
import 'package:erasmus_app/screens/personal_info/personal_info.dart';
import 'package:flutter/material.dart';

void main() {
  Future.delayed(const Duration(seconds: 1));
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Erasmus',
      home: PersonalInfoScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new AppHomeScreen()
      },
      theme: new ThemeData(
        primaryColor: Colors.blueAccent,
        buttonColor: Colors.blue,
      ),
    );
  }
}