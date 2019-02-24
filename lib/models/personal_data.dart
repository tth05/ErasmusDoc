/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

//Handles user data
import 'package:erasmus_doc/globals.dart' as globals;
import 'package:erasmus_doc/models/school.dart';
import 'package:json_annotation/json_annotation.dart';

part 'personal_data.g.dart';

@JsonSerializable()
class PersonalData {
  String name;
  String addressPart1;
  String addressPart2;
  String email;
  String interests;
  String strengths;
  String jobGoals;

  School school;
  DateTime userBirthdayDate;

  String get userBirthdayAsString => globals.dateFormat.format(userBirthdayDate);

  PersonalData(this.school, this.name, this.addressPart1, this.addressPart2, this.email, this.interests, this.strengths,
      this.jobGoals, this.userBirthdayDate);

  factory PersonalData.fromJson(Map<String, dynamic> json) => _$PersonalDataFromJson(json);

  Map<String, dynamic> toJson() => _$PersonalDataToJson(this);
}
