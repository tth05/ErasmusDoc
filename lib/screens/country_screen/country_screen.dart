/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/models/country.dart';
import 'package:erasmus_app/screens/country_screen/widgets/rounded_modal.dart';
import 'package:erasmus_app/screens/image_view_screen/image_view_screen.dart';
import 'package:erasmus_app/util/common_widgets_util.dart';
import 'package:erasmus_app/widgets/custom_app_bar.dart';
import 'package:erasmus_app/widgets/global_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CountryScreen extends StatefulWidget {
  final Country country;

  @override
  State<StatefulWidget> createState() => CountryScreenState(country);

  CountryScreen(this.country);
}

class CountryScreenState extends State<CountryScreen> {
  final Country country;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

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
                    "Land",
                    CommonWidgetsUtil.buildSimpleInfoCard(
                      leading: Image.asset(
                        "assets/countries/${country.fileName}/flag.png",
                        width: 40.0,
                      ),
                      title: country.translatedName,
                      onInfoPressed: () => CommonWidgetsUtil.openMarkdownModal(context, country.info)
                    ),
                  ),
                  CommonWidgetsUtil.buildStickyHeader(
                    "Bildung",
                    Column(
                      children: <Widget>[
                        CommonWidgetsUtil.buildSimpleInfoCard(
                          title: "Schulsystem",
                          divider: true,
                          dividerIndent: 15.0,
                          onInfoPressed: () => CommonWidgetsUtil.openMarkdownModal(context, country.schoolSystem),
                        ),
                        CommonWidgetsUtil.buildSimpleInfoCard(
                          title: "Berufsorientierung",
                          onInfoPressed: () => CommonWidgetsUtil.openMarkdownModal(context, country.orientation),
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

  CountryScreenState(this.country);
}
