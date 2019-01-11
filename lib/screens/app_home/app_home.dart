/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/screens/app_home/custom_button_location.dart';
import 'package:erasmus_app/screens/app_home/widgets/activities_list.dart';
import 'package:erasmus_app/screens/app_home/widgets/erasmus_info_body.dart';
import 'package:erasmus_app/screens/app_home/widgets/widgets.dart';
import 'package:erasmus_app/util/after_layout_mixin.dart';
import 'package:erasmus_app/widgets/global_drawer.dart';
import 'package:flutter/material.dart';
import 'package:simple_permissions/simple_permissions.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  AppHomeState createState() => AppHomeState();
}

class AppHomeState extends State<AppHomeScreen> with AfterLayoutMixin<AppHomeScreen> {
  var _index = 0;
  var permissionsGranted = true;

  @override
  Widget build(BuildContext context) {
    if (!permissionsGranted)
      //Permissions not granted screen
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
                      color: Colors.blueAccent,
                      textColor: Colors.white,
                      onPressed: () =>
                          SimplePermissions.requestPermission(Permission.WriteExternalStorage).then((p) {
                            if (p == PermissionStatus.authorized) {
                              setState(() {
                                permissionsGranted = true;
                              });
                            }
                          }),
                      child: Text("Berechtigungen geben"),
                    ),
                    FlatButton(
                      color: Colors.blueAccent,
                      textColor: Colors.white,
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

    //Normal screen
    return Scaffold(
      //TODO: Disable tooltips on AppBar
      appBar: AppBar(
        title: Text(_index == 0 ? "Startseite" : "Erasmus-Projektinfo"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Navigator.of(context).pushNamed("/profile"),
        ),
      ),
      endDrawer: GlobalDrawer(),
      floatingActionButton: _index == 0
          ? FloatingActionButton.extended(
        onPressed: () => Navigator.of(context).pushNamed("/create_activity"),
        icon: Icon(Icons.add),
        label: Text("Neuer Eintrag"),
      )
          : null,
      floatingActionButtonLocation: CustomCenterDockedFloatingActionButtonLocation(20.0),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) =>
            setState(() {
              _index = index;
            }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Start"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            title: Text("Erasmus"),
          ),
        ],
      ),
      body: _index == 1
          ? ErasmusInfoBody()
          : Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //TODO: Remove if no school is selected
              SelectedSchoolButton(),
              Divider(
                height: 20.0,
              ),
              ActivityListView(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    //Check status
    SimplePermissions.getPermissionStatus(Permission.WriteExternalStorage).then((p) {
      if (p != PermissionStatus.authorized) {
        //Request once if not authorized
        SimplePermissions.requestPermission(Permission.WriteExternalStorage).then((p) {
          if (p != PermissionStatus.authorized) {
            //Switch to other screen if still not authorized
            setState(() {
              permissionsGranted = false;
            });
          }
        });
      }
    });
  }
}
