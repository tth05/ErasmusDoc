/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:async';

import 'package:erasmus_app/screens/activity_creation_screen/activity_creation_screen.dart';
import 'package:erasmus_app/screens/app_home/app_home.dart';
import 'package:erasmus_app/screens/personal_info/personal_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() {
//  globals.init();

  Intl.defaultLocale = 'de_DE';
  //Startup delay to show launch image
  Future.delayed(const Duration(seconds: 1)).whenComplete(() => runApp(App()));
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
        '/create_activity': (BuildContext context) => ActivityCreationScreen(),
      },
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        buttonColor: Colors.blue,
        errorColor: Colors.red[700],
      ),
      localizationsDelegates: [
        GermanCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('de', 'DE'),
      ],
    );
  }
}

class GermanCupertinoLocalizations implements CupertinoLocalizations {
  final materialDelegate = GlobalMaterialLocalizations.delegate;
  final widgetsDelegate = GlobalWidgetsLocalizations.delegate;
  final local = const Locale('de');

  MaterialLocalizations ml;

  Future init() async {
    ml = await materialDelegate.load(local);
  }

  @override
  String get alertDialogLabel => ml.alertDialogLabel;

  @override
  String get anteMeridiemAbbreviation => ml.anteMeridiemAbbreviation;

  @override
  String get copyButtonLabel => ml.copyButtonLabel;

  @override
  String get cutButtonLabel => ml.cutButtonLabel;

  @override
  DatePickerDateOrder get datePickerDateOrder => DatePickerDateOrder.mdy;

  @override
  DatePickerDateTimeOrder get datePickerDateTimeOrder => DatePickerDateTimeOrder.date_time_dayPeriod;

  @override
  String datePickerDayOfMonth(int dayIndex) {
    return dayIndex.toString();
  }

  @override
  String datePickerHour(int hour) {
    return hour.toString().padLeft(2, "0");
  }

  @override
  String datePickerHourSemanticsLabel(int hour) {
    return "$hour";
  }

  @override
  String datePickerMediumDate(DateTime date) {
    return ml.formatMediumDate(date);
  }

  @override
  String datePickerMinute(int minute) {
    return minute.toString().padLeft(2, '0');
  }

  @override
  String datePickerMinuteSemanticsLabel(int minute) {
    return "$minute";
  }

  @override
  String datePickerMonth(int monthIndex) {
    return "$monthIndex";
  }

  @override
  String datePickerYear(int yearIndex) {
    return yearIndex.toString();
  }

  // TODO: implement pasteButtonLabel
  @override
  String get pasteButtonLabel => ml.pasteButtonLabel;

  // TODO: implement postMeridiemAbbreviation
  @override
  String get postMeridiemAbbreviation => ml.postMeridiemAbbreviation;

  // TODO: implement selectAllButtonLabel
  @override
  String get selectAllButtonLabel => ml.selectAllButtonLabel;

  @override
  String timerPickerHour(int hour) {
    return hour.toString().padLeft(2, "0");
  }

  @override
  String timerPickerHourLabel(int hour) {
    return "$hour".toString().padLeft(2, "0");
  }

  @override
  String timerPickerMinute(int minute) {
    return minute.toString().padLeft(2, "0");
  }

  @override
  String timerPickerMinuteLabel(int minute) {
    return minute.toString().padLeft(2, "0");
  }

  @override
  String timerPickerSecond(int second) {
    return second.toString().padLeft(2, "0");
  }

  @override
  String timerPickerSecondLabel(int second) {
    return second.toString().padLeft(2, "0");
  }

  static const LocalizationsDelegate<CupertinoLocalizations> delegate = _ChineseDelegate();

  static Future<CupertinoLocalizations> load(Locale locale) async {
    var localizaltions = GermanCupertinoLocalizations();
    await localizaltions.init();
    return SynchronousFuture<CupertinoLocalizations>(localizaltions);
  }
}

class _ChineseDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const _ChineseDelegate();

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode == 'de';
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return GermanCupertinoLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<CupertinoLocalizations> old) {
    return false;
  }
}