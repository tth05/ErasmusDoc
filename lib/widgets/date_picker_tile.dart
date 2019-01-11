/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:async';

import 'package:erasmus_app/globals.dart' as globals;
import 'package:flutter/material.dart';

class DatePickerTile extends FormField<DateTime> {
  DatePickerTile(String title, String error, {FormFieldSetter<DateTime> onSaved, DateTime initialValue})
      : super(
    onSaved: onSaved,
    validator: (value) {
      if (value.toString().substring(0, 10) == DateTime.now().toString().substring(0, 10)) return error;
    },
    initialValue: initialValue,
    autovalidate: false,
    builder: (FormFieldState<DateTime> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              title,
              style: TextStyle(fontSize: 20.0),
            ),
            subtitle: Text(globals.jsonManager.personalData.userBirthdayAsString),
            contentPadding: EdgeInsets.all(0.0),
            onTap: () {
              Future<DateTime> result = showDatePicker(
                context: state.context,
                locale: Locale("de"),
                initialDate: initialValue,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                initialDatePickerMode: DatePickerMode.year,
              );
              if (result == null) return;
              result.then((dateTime) {
                if (dateTime == null) return;
                state.didChange(globals.jsonManager.personalData.userBirthdayDate = dateTime);
              });
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
