/*
    Created by Tim Theisinger on 26.08.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

library erasmus_app.globals;

var selectedSchool = "";

var _userBirthdayDate;

set userBirthdayDate(DateTime date) => _userBirthdayDate = date;

DateTime get userBirthdayDate => _userBirthdayDate == null ? (_userBirthdayDate = DateTime.now()) : _userBirthdayDate;

String get userBirthdayAsString => userBirthdayDate.toString().substring(0, 10);

final schools = ["Hessenwaldschule", "Schule 2"];
