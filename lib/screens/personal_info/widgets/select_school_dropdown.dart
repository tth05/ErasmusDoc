/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/data/school.dart';
import 'package:erasmus_app/globals.dart' as globals;
import 'package:flutter/material.dart';

class SelectSchoolDropdownButton extends FormField<String> {
  SelectSchoolDropdownButton({FormFieldSetter<String> onSaved, String initialValue})
      : super(
    onSaved: onSaved,
    validator: (value) {
      if (value == null) return 'Bitte wähle deine Schule aus.';
    },
    initialValue: initialValue,
    autovalidate: false,
    builder: (FormFieldState<String> state) {
      final isSchoolSelected = globals.jsonManager.personalData.selectedSchool != null;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton(
            items: globals.jsonManager.schools.map((School val) {
              return DropdownMenuItem(
                value: val,
                child: Text(val.translatedName),
              );
            }).toList(),
            hint: Text(
              isSchoolSelected ? globals.jsonManager.personalData.selectedSchool.translatedName : "Schule",
              style: TextStyle(
                fontSize: 20.0,
                color: isSchoolSelected ? Colors.black : Colors.grey,
              ),
            ),
            onChanged: (School s) {
              state.didChange((globals.jsonManager.personalData.selectedSchool = s).translatedName);
            },
          ),
          state.hasError
              ? Text(
            state.errorText,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Theme
                  .of(state.context)
                  .errorColor,
              fontSize: 12.0,
            ),
          )
              : Container()
        ],
      );
    },
  );
}
