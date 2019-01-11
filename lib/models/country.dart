/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country {
  final String fileName;
  final String translatedName;
  final String info;
  final String orientation;
  final String schoolSystem;

  Country(this.fileName, this.translatedName, this.info, this.orientation, this.schoolSystem);

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);

  @override
  String toString() {
    return "(fileName: '$fileName', translatedName: '$translatedName', info: '$info', orientation: '$orientation', schoolSystemInfo: '$schoolSystem')";
  }
}
