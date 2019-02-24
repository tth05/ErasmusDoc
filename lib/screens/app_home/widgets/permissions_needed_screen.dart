/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_doc/screens/app_home/app_home.dart';
import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';

class PermissionsNeededScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    AppHomeState parentState = context.ancestorStateOfType(TypeMatcher<AppHomeState>());

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 4,
            margin: EdgeInsets.all(4.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Diese App benötigt Berechtigungen um zu funktionieren",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  Divider(),
                  FlatButton(
                    color: theme.primaryColor,
                    textColor: theme.primaryTextTheme.button.color,
                    onPressed: () => SimplePermissions.requestPermission(Permission.WriteExternalStorage).then((p) {
                      if (p == PermissionStatus.authorized) {
                        parentState.setState(() {
                          parentState.permissionsGranted = true;
                        });
                      }
                    }),
                    child: Text("Berechtigungen geben"),
                  ),
                  FlatButton(
                    color: theme.primaryColor,
                    textColor: theme.primaryTextTheme.button.color,
                    onPressed: () => SimplePermissions.openSettings(),
                    child: Text("Einstellungen öffnen"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}