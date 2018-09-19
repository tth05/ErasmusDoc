/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/data/country.dart';
import 'package:erasmus_app/data/school.dart';
import 'package:erasmus_app/globals.dart' as globals;
import 'package:erasmus_app/screens/country_screen/country_screen.dart';
import 'package:erasmus_app/screens/school_screen/school_screen.dart';
import 'package:flutter/material.dart';

class GlobalDrawer extends StatelessWidget {
  final drawerList = <Widget>[];

  void pressedSchool(BuildContext context, School s) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SchoolScreen(s)));
  }

  void pressedCountry(BuildContext context, Country c) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CountryScreen(c)));
  }

  @override
  Widget build(BuildContext context) {
    if (drawerList.isEmpty) {
      drawerList.add(ListTile(title: Text("Schulen", style: TextStyle(fontSize: 20.0))));
      drawerList.add(Divider());
      drawerList.addAll(globals.schools.map(
        (s) => Column(
              children: <Widget>[
                Divider(
                  height: 10.0,
                  color: Colors.grey[50],
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.grey[50], boxShadow: <BoxShadow>[
                    BoxShadow(blurRadius: 1.0, offset: Offset(0.0, 2.0), color: Colors.grey[300]),
                  ]),
                  child: ListTile(
                    title: Text("${s.translatedName}"),
                    leading: Image.asset("assets/schools/${s.fileName}/logo.png"),
                    onTap: () => {},
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueAccent,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => pressedSchool(context, s),
                    ),
                  ),
                ),
              ],
            ),
      ));
      drawerList.add(Divider(color: Colors.white));
      drawerList.add(ListTile(title: Text("Länder", style: TextStyle(fontSize: 20.0))));
      drawerList.add(Divider());
      drawerList.addAll(
        globals.countries.map(
          (c) => Column(
                children: <Widget>[
                  Divider(
                    height: 10.0,
                    color: Colors.grey[50],
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[50], boxShadow: <BoxShadow>[
                      BoxShadow(blurRadius: 1.0, offset: Offset(0.0, 2.0), color: Colors.grey[300]),
                    ]),
                    child: ListTile(
                      title: Text("${c.translatedName}"),
                      leading: Image.asset("assets/countries/${c.fileName}/flag.png"),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blueAccent,
                        ),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => pressedCountry(context, c),
                      ),
                    ),
                  ),
                ],
              ),
        ),
      );
    }

    return Drawer(
      child: ListView(
        children: drawerList,
      ),
    );
  }
}
