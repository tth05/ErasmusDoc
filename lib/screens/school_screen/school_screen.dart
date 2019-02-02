/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'dart:math';

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/models/school.dart';
import 'package:erasmus_app/util/common_widgets_util.dart';
import 'package:erasmus_app/widgets/custom_app_bar.dart';
import 'package:erasmus_app/widgets/global_drawer.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class SchoolScreen extends StatefulWidget {
  final School school;

  @override
  State<StatefulWidget> createState() => SchoolScreenState(school);

  SchoolScreen(this.school);
}

class SchoolScreenState extends State<SchoolScreen> {
  final School school;

  SchoolScreenState(this.school);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final jsonManager = ManagerContext.of(context).jsonManager;
    final random = Random();

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushReplacementNamed("/");
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text("Info"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pushReplacementNamed("/"),
          ),
        ),
        endDrawer: GlobalDrawer(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  CommonWidgetsUtil.buildStickyHeader(
                    "Schule",
                    CommonWidgetsUtil.buildSimpleInfoCard(
                      title: school.translatedName,
                      subtitle: school.address,
                      leading: Image.asset("assets/schools/${school.fileName}/logo.png", width: 40.0,),
                      onInfoPressed: () => CommonWidgetsUtil.openMarkdownModal(context, school.info)
                    ),
                  ),
                  CommonWidgetsUtil.buildStickyHeader(
                    "Projekte",
                    Column(
                      children: List.generate(
                        10,
                        (index) => Column(
                              children: <Widget>[
                                ListTile(
                                  dense: true,
                                  leading: Image.asset(
                                    "assets/countries/${jsonManager.countries[random.nextInt(5)].fileName}/flag.png",
                                    width: 40.0,
                                  ),
                                  title: Text(
                                    "Projekt ${index + 1}",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                  subtitle: Text("Land\nDatum"),
                                  isThreeLine: true,
                                  trailing: IconButton(icon: Icon(Icons.arrow_forward_ios), onPressed: () => {}),
                                ),
                                index != 9
                                    ? Divider(
                                        height: 0,
                                        indent: 60,
                                      )
                                    : Container()
                              ],
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
