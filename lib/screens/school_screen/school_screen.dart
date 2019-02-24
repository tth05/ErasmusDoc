/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/managers/manager_context.dart';
import 'package:erasmus_app/models/school.dart';
import 'package:erasmus_app/util/common_widgets_util.dart';
import 'package:erasmus_app/widgets/custom_app_bar.dart';
import 'package:erasmus_app/widgets/global_drawer.dart';
import 'package:flutter/material.dart';

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
    final jsonManager = ManagerContext.of(context).jsonManager;
    print(jsonManager.personalData.school.country);
    print(jsonManager.personalData.school.fileName);

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
                    context,
                    "Schule",
                    CommonWidgetsUtil.buildSimpleInfoCard(
                        title: school.translatedName,
                        subtitle: school.address,
                        leading: Image.asset(
                          "assets/schools/${school.fileName}/logo.png",
                          width: 40.0,
                        ),
                        onInfoPressed: () => CommonWidgetsUtil.openMarkdownModal(context, school.info)),
                  ),
                  CommonWidgetsUtil.buildStickyHeader(
                    context,
                    "Projekte",
                    CommonWidgetsUtil.buildSimpleInfoCard(
                      title:
                          "Projekttreffen in ${jsonManager.countries.firstWhere((c) => c.fileName == school.country).translatedName}",
                      leading: Image.asset(
                        "assets/countries/${school.country}/flag.png",
                        width: 40,
                      ),
                      onInfoPressed: () => CommonWidgetsUtil.openMarkdownModal(context, school.projectDescription),
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
