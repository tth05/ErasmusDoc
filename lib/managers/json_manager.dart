/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:convert';
import 'dart:io';

import 'package:erasmus_app/models/activity.dart';
import 'package:erasmus_app/models/country.dart';
import 'package:erasmus_app/models/personal_data.dart';
import 'package:erasmus_app/models/school.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

//Handles parsing, loading and writing of json
class JsonManager {
  //Stores all school instances
  final schools = <School>[];

  //Stores all country instances
  final countries = <Country>[];

  //Stores all activity instances
  final activities = <Activity>[];

  //Data the user can optionally input
  final personalData = PersonalData();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  JsonManager() {
    loadSchools();
    loadCountries();
    loadActivities();
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

  /// Saves an activity and also overwrites if it already exists
  void saveActivity(Activity activity) async {
    final path = await _localPath;
    final file = await createFileIfNotExists("$path/activities/${activity.name}.json") as File;
    file.writeAsStringSync(json.encode(activity.toJson()));
  }

  void loadActivities() async {
    final path = await _localPath;
    final dir = Directory("$path/activities");
    if (!dir.existsSync()) return;

    dir.listSync().forEach((f) {
      if (f is File) activities.add(Activity.fromJson(json.decode(f.readAsStringSync())));
    });
  }

  Future<FileSystemEntity> createFileIfNotExists(String path) async {
    if (FileSystemEntity.isDirectorySync(path))
      return Directory(path).create(recursive: true);
    else
      return File(path).create(recursive: true);
  }
}
