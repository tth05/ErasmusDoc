/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class Country extends Object with _$CountrySerializerMixin {
  final String fileName;
  final String translatedName;
  final String orientation;
  final String schoolSystemInfo;

  Country(this.fileName, this.translatedName, this.orientation, this.schoolSystemInfo);

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
}
