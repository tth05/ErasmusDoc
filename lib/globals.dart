/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/data/country.dart';
import 'package:erasmus_app/data/school.dart';
import 'package:erasmus_app/services/json_service.dart';

//TODO: Make a class for PersonalData and move the instance of that to JsonService
School selectedSchool;
final schools = <School>[];
final countries = <Country>[];

//userBirthdayDate - Start
var _userBirthdayDate;

set userBirthdayDate(DateTime date) => _userBirthdayDate = date;

DateTime get userBirthdayDate => _userBirthdayDate == null ? (_userBirthdayDate = DateTime.now()) : _userBirthdayDate;

String get userBirthdayAsString => userBirthdayDate.toString().substring(0, 10);
//userBirthdayDate - End

final json_service = JsonService();

void init() {
  json_service.loadSchools(schools);
  json_service.loadCountries(countries);
}

