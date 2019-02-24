/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/models/country.dart';
import 'package:erasmus_app/models/school.dart';
import 'package:erasmus_app/screens/country_screen/country_screen.dart';
import 'package:erasmus_app/screens/school_screen/school_screen.dart';
import 'package:flutter/material.dart';

class GlobalDrawer extends StatelessWidget {
  final drawerList = <Widget>[];

  //Using pushReplacement to prevent "infinite" replacements. (Home -> School -> Country -> School -> School ...)
  // The click on the back arrow should always lead back to the HomeScreen.
  void _handleSchool(BuildContext context, School s) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SchoolScreen(s)));
  }

  void _handleCountry(BuildContext context, Country c) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CountryScreen(c)));
  }

  @override
  Widget build(BuildContext context) {
    final jsonManager = ManagerContext.of(context).jsonManager;
    final theme = Theme.of(context);

    drawerList.clear();
    drawerList.add(Container(
      color: theme.primaryColorLight,
      child: ListTile(title: Text("Schulen", style: TextStyle(fontSize: 20.0, color: theme.primaryColor))),
    ));
    drawerList.addAll(
      jsonManager.schools.map(
        (s) => Column(
              children: <Widget>[
                Container(
                  child: InkWell(
                    onTap: () => _handleSchool(context, s),
                    child: ListTile(
                      title: Text("${s.translatedName}"),
                      leading: Image.asset(
                        "assets/schools/${s.fileName}/logo.png",
                        width: 40.0,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
    drawerList.add(Divider(color: Colors.white));
    drawerList.add(Container(
      color: theme.primaryColorLight,
      child: ListTile(
        title: Text(
          "Länder",
          style: TextStyle(
            fontSize: 20.0,
            color: theme.primaryColor,
          ),
        ),
      ),
    ));
    drawerList.addAll(
      jsonManager.countries.map(
        (c) => Column(
              children: <Widget>[
                Container(
                  child: InkWell(
                    onTap: () => _handleCountry(context, c),
                    child: ListTile(
                      title: Text(c.translatedName),
                      leading: Image.asset(
                        "assets/countries/${c.fileName}/flag.png",
                        width: 40.0,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );

    return Drawer(
      child: ListView(
        children: drawerList,
      ),
    );
  }
}
