/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

library erasmus_app.globals;

//TODO: Make a class for PersonalData
var selectedSchool = "";
//TODO: Load schools and countries from assets
final schools = [
  "Hessenwaldschule",
  "2. Gymnasium Chalkida",
  "Juliaus Janonio gimnazija",
  "Muhittin Mustafa Böcek Anadolu Lisesi",
  "Gymnázium Grässlingová 18"
];

final countries = ["Deutschland", "Griechenland", "Litauen", "Türkei", "Slowakei"];

//userBirthdayDate - Start
var _userBirthdayDate;

set userBirthdayDate(DateTime date) => _userBirthdayDate = date;

DateTime get userBirthdayDate => _userBirthdayDate == null ? (_userBirthdayDate = DateTime.now()) : _userBirthdayDate;

String get userBirthdayAsString => userBirthdayDate.toString().substring(0, 10);
//userBirthdayDate - End
