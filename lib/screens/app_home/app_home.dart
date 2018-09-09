/*
    Created by Tim Theisinger on 22.08.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/
import 'package:erasmus_app/globals.dart' as globals;
import 'package:erasmus_app/screens/app_home/custom_button_location.dart';
import 'package:flutter/material.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  AppHomeState createState() => new AppHomeState();
}

class AppHomeState extends State<AppHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () => Navigator.of(context).pushNamed("/"),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text("Neuer Eintrag"),
      ),
      floatingActionButtonLocation: CustomCenterDockedFloatingActionButtonLocation(18.0),
      bottomNavigationBar: BottomAppBar(
        elevation: 2.0,
        color: Theme
            .of(context)
            .primaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Row(
                children: <Widget>[
//                  Image.asset(
//                    "assets/images/erasmus.png",
//                    fit: BoxFit.contain,
//                    scale: 5.0,
//                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text(
                      "Erasmus-Projektinfo",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(globals.selectedSchool)],
        ),
      ),
    );
  }
}
