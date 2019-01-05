/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/screens/app_home/custom_button_location.dart';
import 'package:erasmus_app/screens/app_home/widgets/activities_list.dart';
import 'package:erasmus_app/screens/app_home/widgets/widgets.dart';
import 'package:erasmus_app/widgets/global_drawer.dart';
import 'package:flutter/material.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  AppHomeState createState() => new AppHomeState();
}

class AppHomeState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    print("devicePixelRatio: ${MediaQuery.of(context).devicePixelRatio}");
    return Scaffold(
      //TODO: Disable tooltips on AppBar
      appBar: AppBar(
        title: Text("Startseite"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Navigator.of(context).pushNamed("/profile"),
        ),
      ),
      endDrawer: GlobalDrawer(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text("Neuer Eintrag"),
      ),
      floatingActionButtonLocation: CustomCenterDockedFloatingActionButtonLocation(20.0),
      bottomNavigationBar: ErasmusBottomAppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(4.0, 4.0, 4.0, 0.0),
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
}
