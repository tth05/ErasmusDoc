/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  String name;
  DateTime when;

  //Project this belongs to
//  final Project when;
  //Json data written by the user encrypted in base64 to correctly load it as a string
  String data;

  Activity(this.name, this.when, this.data);

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  @override
  String toString() {
    return "(name: '$name', when: '${when.toIso8601String()}', data: '$data')";
  }
}
