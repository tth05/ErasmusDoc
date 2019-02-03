/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:async';

import 'package:erasmus_app/globals.dart' as globals;
import 'package:erasmus_app/util/common_widgets_util.dart';
import 'package:flutter/material.dart';

class DatePickerTile extends FormField<DateTime> {
  DatePickerTile(String title, String error,
      {FormFieldSetter<DateTime> onSaved,
      FormFieldValidator<DateTime> validator,
      DateTime initialValue,
      DateTime firstDate,
      DateTime lastDate})
      : super(
          onSaved: onSaved,
          validator: validator == null
              ? (value) => value.difference(DateTime.now()).inDays.abs() < 1 ? error : null
              : validator,
          initialValue: initialValue,
          autovalidate: false,
          builder: (FormFieldState<DateTime> state) {
            return CommonWidgetsUtil.buildStickyHeader(
              state.context,
              title,
              Column(
                children: <Widget>[
                  CommonWidgetsUtil.buildSimpleInfoCard(
                    leading: Icon(Icons.date_range),
                    title: globals.dateFormat.format(state.value),
                    trailing: Icon(Icons.edit,),
                    onTap: () {
                      Future<DateTime> result = showDatePicker(
                        context: state.context,
                        locale: Locale("de"),
                        initialDate: initialValue,
                        firstDate: firstDate != null ? firstDate : DateTime(1900),
                        lastDate: lastDate != null ? lastDate : DateTime.now(),
                        initialDatePickerMode: DatePickerMode.year,
                      );
                      result.then(
                        (dateTime) {
                          if (dateTime == null) return;
                          state.didChange(dateTime);
                        },
                      );
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
              ),
            );
          },
        );
}
