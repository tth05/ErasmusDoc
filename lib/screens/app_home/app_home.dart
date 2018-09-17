/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/globals.dart' as globals;
import 'package:erasmus_app/screens/app_home/custom_button_location.dart';
import 'package:erasmus_app/screens/app_home/widgets/widgets.dart';
import 'package:erasmus_app/screens/school_screen/school_screen.dart';
import 'package:flutter/material.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  AppHomeState createState() => new AppHomeState();
}

class AppHomeState extends State<AppHomeScreen> {
  final drawerList = <Widget>[];

  @override
  void initState() {
    super.initState();
    drawerList.add(ListTile(title: Text("Schulen", style: TextStyle(fontSize: 20.0))));
    drawerList.add(Divider());
    drawerList.addAll(globals.schools.map(
      (s) => ListTile(
            title: Text("${s.translatedName}"),
        leading: Image.asset("assets/schools/${s.fileName}/small_logo.png"),
//            leading: Image.asset("assets/schools/hessenwaldschule/small_logo.png"),
        onTap: () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SchoolScreen(s))),
          ),
    ));
    drawerList.add(Divider(color: Colors.white));
    drawerList.add(ListTile(title: Text("Länder", style: TextStyle(fontSize: 20.0))));
    drawerList.add(Divider());
    drawerList.addAll(globals.countries.map(
      (s) => ListTile(
            title: Text("${s.translatedName}"),
          ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery
        .of(context)
        .devicePixelRatio);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Navigator.of(context).pushNamed("/profile"),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: drawerList,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text("Neuer Eintrag"),
      ),
      floatingActionButtonLocation: CustomCenterDockedFloatingActionButtonLocation(18.0),
      bottomNavigationBar: ErasmusBottomAppBar(),
      body: Column(
        children: <Widget>[
          JournalDataTable(),
        ],
      ),
    );
  }
}
