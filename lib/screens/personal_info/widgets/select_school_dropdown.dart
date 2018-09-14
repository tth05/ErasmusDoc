/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButton(
            items: globals.schools.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(val),
              );
            }).toList(),
            hint: Text(
              globals.selectedSchool == "" ? "Schule" : globals.selectedSchool,
              style: TextStyle(
                fontSize: 20.0,
                color: globals.selectedSchool == "" ? Colors.grey : Colors.black,
              ),
            ),
            onChanged: (String s) {
              state.didChange(globals.selectedSchool = s);
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
