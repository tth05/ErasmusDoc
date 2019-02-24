/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/
import 'package:json_annotation/json_annotation.dart';

part 'school.g.dart';

@JsonSerializable()
class School {
  final String fileName;
  final String translatedName;
  final String info;
  final String address;
  final String country;
  final String projectDescription;

  School(this.fileName, this.translatedName, this.info, this.address, this.country, this.projectDescription);

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
