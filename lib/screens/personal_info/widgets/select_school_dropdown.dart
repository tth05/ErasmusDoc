/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/models/school.dart';
import 'package:flutter/material.dart';

class SelectSchoolDropdownButton extends FormField<School> {
  SelectSchoolDropdownButton(School initialValue, {FormFieldSetter<School> onSaved, FormFieldValidator<School> validator})
      : super(
          onSaved: onSaved,
          validator: validator == null
              ? (value) {
                  if (value == null) return 'Bitte wähle deine Schule aus.';
                }
              : validator,
          initialValue: initialValue,
          autovalidate: false,
          builder: (FormFieldState<School> state) {
            final isSchoolSelected = state.value != null;
            final jsonManager = ManagerContext.of(state.context).jsonManager;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButton(
                  items: jsonManager.schools.map((School val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(val.translatedName),
                    );
                  }).toList(),
                  hint: Text(
                    isSchoolSelected ? state.value.translatedName : "Schule",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: isSchoolSelected ? Colors.black : Colors.grey,
                    ),
                  ),
                  onChanged: (School s) {
                    state.didChange(s);
                  },
                ),
                state.hasError
                    ? Text(
                        state.errorText,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(state.context).errorColor,
                          fontSize: 12.0,
                        ),
                      )
                    : Container()
              ],
            );
          },
        );
}
