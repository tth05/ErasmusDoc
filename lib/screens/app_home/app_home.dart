/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/screens/activity_screen/activity_screen.dart';
import 'package:erasmus_app/screens/app_home/custom_button_location.dart';
import 'package:erasmus_app/screens/app_home/widgets/activities_list.dart';
import 'package:erasmus_app/screens/app_home/widgets/erasmus_info_body.dart';
import 'package:erasmus_app/screens/app_home/widgets/permissions_needed_screen.dart';
import 'package:erasmus_app/screens/school_screen/school_screen.dart';
import 'package:erasmus_app/util/after_layout_mixin.dart';
import 'package:erasmus_app/util/common_widgets_util.dart';
import 'package:erasmus_app/widgets/custom_app_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    if (!permissionsGranted)
      //Permissions not granted screen
      return PermissionsNeededScreen();

    final jsonManager = ManagerContext.of(context).jsonManager;
    final hasSelectedSchool = jsonManager.personalData.school != null;
    //Normal screen
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(_index == 0 ? "Überblick" : "Erasmus-Projektinfo"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Navigator.of(context).pushNamed("/profile"),
        ),
      ),
      endDrawer: GlobalDrawer(),
      floatingActionButton: _index == 0
          ? FloatingActionButton.extended(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ActivityScreen(mode: Mode.create))),
              icon: Icon(Icons.add),
              label: Text("Neuer Eintrag"),
            )
          : null,
      floatingActionButtonLocation: CustomCenterDockedFloatingActionButtonLocation(20.0),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) {
          if (index != _index)
            setState(() {
              _index = index;
            });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Überblick"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            title: Text("Erasmus"),
          ),
        ],
      ),
      body: _index == 1
          ? ErasmusInfoBody()
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      hasSelectedSchool
                          ? CommonWidgetsUtil.buildStickyHeader(
                              "Schule",
                              CommonWidgetsUtil.buildSimpleInfoCard(
                                title: jsonManager.personalData.school.translatedName,
                                subtitle: jsonManager.personalData.school.address,
                                leading: Image.asset(
                                  "assets/schools/${jsonManager.personalData.school.fileName}/logo.png",
                                  width: 40.0,
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => SchoolScreen(jsonManager.personalData.school)))),
                              ),
                            )
                          : Container(),
                      ActivitiesList(),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
