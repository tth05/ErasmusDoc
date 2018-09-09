/*
    Created by Tim Theisinger on 19.08.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:async';

import 'package:erasmus_app/screens/app_home/app_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  //Startup delay to show launch image
  Future.delayed(const Duration(seconds: 4)).whenComplete(() => runApp(App()));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Erasmus',
      home: AppHomeScreen(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new AppHomeScreen()
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
        const Locale('en', 'US'),
        const Locale('de', 'DE'),
      ],
    );
  }
}