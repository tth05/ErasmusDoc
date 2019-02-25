/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_doc/managers/manager_context.dart';
import 'package:erasmus_doc/models/school.dart';
import 'package:erasmus_doc/util/common_widgets_util.dart';
import 'package:erasmus_doc/util/url_util.dart';
import 'package:erasmus_doc/widgets/custom_app_bar.dart';
import 'package:erasmus_doc/widgets/global_drawer.dart';
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
    final country = jsonManager.countries.firstWhere((c) => c.fileName == school.country);

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
                    "Projekt",
                    Column(
                      children: <Widget>[
                        CommonWidgetsUtil.buildSimpleInfoCard(
                          title: "Projekttreffen",
//                          subtitle: country.translatedName,
                          leading: Image.asset(
                            "assets/countries/${school.country}/flag.png",
                            width: 40,
                          ),
                          divider: true,
                          dividerIndent: 60.0,
                          onInfoPressed: () => CommonWidgetsUtil.openMarkdownModal(context, school.projectDescription),
                        ),
                        CommonWidgetsUtil.buildSimpleInfoCard(
                          title: "Webseite",
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            //Workaround because url_launcher can't launch an url without http or https
                            onPressed: () => URLUtil.launchURL("https://bit.ly/2E8TIIp"),
                          ),
                          leading: Icon(
                            Icons.web,
                            size: 40.0,
                          ),
                        ),
                      ],
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
