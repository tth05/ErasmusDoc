/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_doc/managers/manager_context.dart';
import 'package:erasmus_doc/models/country.dart';
import 'package:flutter/material.dart';

class SelectCountryDropdownButton extends FormField<Country> {
  SelectCountryDropdownButton(Country initialValue, FormFieldSetter<Country> onSaved)
      : super(
          onSaved: onSaved,
          validator: (value) {
            if (value == null) return 'Bitte wähle ein Land aus.';
          },
          initialValue: initialValue,
          builder: (FormFieldState<Country> state) {
            final isCountrySelected = state.value != null;
            final jsonManager = ManagerContext.of(state.context).jsonManager;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DropdownButton(
                  isExpanded: true,
                  items: jsonManager.countries.map((Country val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text("${val.translatedName}"),
                    );
                  }).toList(),
                  hint: Text(
                    isCountrySelected ? state.value.translatedName : "Land auswählen",
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isCountrySelected ? Colors.black : Colors.grey,
                    ),
                  ),
                  onChanged: (Country s) {
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
