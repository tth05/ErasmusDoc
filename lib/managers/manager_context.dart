/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/managers/json_manager.dart';
import 'package:flutter/material.dart';

//Lives at the root of the app to supply instances of the managers
class ManagerContext extends InheritedWidget {

  final JsonManager jsonManager;

  ManagerContext(this.jsonManager, {Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static ManagerContext of(BuildContext context) => context.inheritFromWidgetOfExactType(ManagerContext);
}