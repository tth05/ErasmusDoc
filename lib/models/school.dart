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

  School(this.fileName, this.translatedName, this.info, this.address);

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  Map<String, dynamic> toJson() => _$SchoolToJson(this);

  @override
  String toString() {
    return "(fileName: '$fileName', translatedName: '$translatedName', info: '$info', address: '$address')";
  }
}
