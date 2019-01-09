/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:convert';

import 'package:erasmus_app/data/country.dart';
import 'package:erasmus_app/data/personal_data.dart';
import 'package:erasmus_app/data/school.dart';
import 'package:flutter/services.dart' show rootBundle;

//Handles parsing, loading and writing of json
class JsonManager {
  final schools = <School>[];
  final countries = <Country>[];

  final personalData = PersonalData();

  JsonManager() {
    loadSchools();
    loadCountries();
  }

  void loadSchools() async {
    String load = await rootBundle.loadString("assets/schools/all_schools.json");
    final allSchools = List<String>.from(json.decode(load)["schools"]);
    for (String s in allSchools) {
      final data = await rootBundle.loadString("assets/schools/$s/data.json");
      schools.add(School.fromJson(json.decode(data)));
    }
  }

  void loadCountries() async {
    String load = await rootBundle.loadString("assets/countries/all_countries.json");
    final allCountries = List<String>.from(json.decode(load)["countries"]);
    for (String s in allCountries) {
      final data = await rootBundle.loadString("assets/countries/$s/data.json");
      countries.add(Country.fromJson(json.decode(data)));
    }
  }
}
