/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_doc/globals.dart' as globals;
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  String name;

  //Date of the activity
  DateTime when;

  //Random file name based on timestamp to avoid duplicates
  @JsonKey(ignore: true)
  String _fileName;

  String get fileName => _fileName == null ? (_fileName = globals.uuid.v1()) : _fileName;

  set fileName(String name) => _fileName = name;

  //Country this activity was in
  String country;

  //Json data in notus format encrypted in base64 to correctly load it and save it
  String data;

  Activity(this.name, this.when, this.country, this.data);

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
