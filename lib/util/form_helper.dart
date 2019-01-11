/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:flutter/material.dart';

class FormHelper {
  static const _fieldFont = TextStyle(fontSize: 15.0, color: Colors.black);
  static const _textFont = TextStyle(fontSize: 20.0);

  static Widget buildTitle(String title) {
    return Text(
      title,
      style: _textFont,
    );
  }

  static Widget buildTextField({bool focus = false, String initialValue: "", FormFieldSetter<String> onSaved}) {
    return TextFormField(
      style: _fieldFont,
      autofocus: focus,
      initialValue: initialValue,
      onSaved: onSaved,
      validator: (s) {
        if (s.isEmpty) {
          return "Bitte fülle dieses Feld aus.";
        }
      },
    );
  }
}
