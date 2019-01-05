/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:async';

import 'package:erasmus_app/globals.dart' as globals;
import 'package:erasmus_app/screens/app_home/app_home.dart';
import 'package:erasmus_app/screens/erasmus_info/erasmus_info.dart';
import 'package:erasmus_app/screens/personal_info/personal_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  globals.init();
  //Startup delay to show launch image
  Future.delayed(const Duration(seconds: 4)).whenComplete(() => runApp(App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Erasmus',
      home: AppHomeScreen(),
      //TODO: Implement back button listener for android to navigate between routes
      routes: <String, WidgetBuilder>{
        '/profile': (BuildContext context) => PersonalInfoScreen(),
        '/erasmus_info': (BuildContext context) => ErasmusInfoScreen(),
      },
      theme: new ThemeData(
        primaryColor: Colors.blueAccent,
        buttonColor: Colors.blue,
        errorColor: Colors.red[700],
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('de', 'DE'),
      ],
    );
  }
}