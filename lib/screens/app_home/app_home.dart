/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/screens/app_home/custom_button_location.dart';
import 'package:erasmus_app/screens/app_home/widgets/activities_list.dart';
import 'package:erasmus_app/screens/app_home/widgets/erasmus_info_body.dart';
import 'package:erasmus_app/screens/app_home/widgets/widgets.dart';
import 'package:erasmus_app/widgets/global_drawer.dart';
import 'package:flutter/material.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  AppHomeState createState() => new AppHomeState();
}

class AppHomeState extends State<AppHomeScreen> {
  var _index = 0;

  @override
  Widget build(BuildContext context) {
    print("devicePixelRatio: ${MediaQuery.of(context).devicePixelRatio}");
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
        onPressed: () {},
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
}
