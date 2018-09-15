/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

library erasmus_app.globals;

import 'dart:convert';

import 'package:erasmus_app/data/school.dart';
import 'package:flutter/services.dart' show rootBundle;

//TODO: Make a class for PersonalData
var selectedSchool = "";
//TODO: Load schools and countries from assets
var schools = <School>[];

final countries = ["Deutschland", "Griechenland", "Litauen", "Türkei", "Slowakei"];

//userBirthdayDate - Start
var _userBirthdayDate;

set userBirthdayDate(DateTime date) => _userBirthdayDate = date;

DateTime get userBirthdayDate => _userBirthdayDate == null ? (_userBirthdayDate = DateTime.now()) : _userBirthdayDate;

String get userBirthdayAsString => userBirthdayDate.toString().substring(0, 10);
//userBirthdayDate - End

void init() {
  loadSchools();
}

void loadSchools() async {
  String load = await rootBundle.loadString("assets/schools/all_schools.json");
  List<String> allSchools = List<String>.from(json.decode(load)["schools"]);
  for (String s in allSchools) {
    final data = await rootBundle.loadString("assets/schools/$s/data.json");
    schools.add(School.fromJson(json.decode(data)));
  }

  print("Schools: $schools");
}
