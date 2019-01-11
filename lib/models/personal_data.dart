/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

//Handles user data
import 'package:erasmus_app/models/school.dart';

class PersonalData {
  School selectedSchool;

  var _userBirthdayDate;

  set userBirthdayDate(DateTime date) => _userBirthdayDate = date;

  DateTime get userBirthdayDate => _userBirthdayDate == null ? (_userBirthdayDate = DateTime.now()) : _userBirthdayDate;

  String get userBirthdayAsString => userBirthdayDate.toString().substring(0, 10);
}
