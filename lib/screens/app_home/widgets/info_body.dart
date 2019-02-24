/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_doc/util/common_widgets_util.dart';
import 'package:erasmus_doc/util/url_util.dart';
import 'package:flutter/material.dart';

class InfoBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              CommonWidgetsUtil.buildStickyHeader(
                context,
                "Erasmus",
                Column(
                  children: <Widget>[
                    CommonWidgetsUtil.buildSimpleInfoCard(
                      title: "Kurzinfo",
                      leading: Image.asset(
                        "assets/images/erasmus_logo.png",
                        width: 40.0,
                      ),
                      onInfoPressed: () => CommonWidgetsUtil.openMarkdownModal(
                          context,
                          "## Kurzinfo\n***\nDas Erasmus-Programm ist ein Förderprogramm der Europäischen Union. Sein Name erinnert an Erasmus von "
                          "Rotterdam, einen europäisch gebildeten Humanisten der Renaissance. Es wurde zum weltweit größten "
                          "Förderprogramm von Auslandsaufenthalten an Universitäten, über Europa hinaus erweitert seit dem Jahr "
                          "2003 durch das Zusatzprogramm Erasmus Mundus, und finanzierte bis dahin in seinen ersten rund 15 Jahren "
                          "etwa 1 Million Stipendien. Für andere Zielgruppen folgte beispielsweise Erasmus für Jungunternehmer. "
                          "Seit dem Jahr 2014 ist Erasmus mit anderen Programmen zu Erasmus+ verschmolzen."),
                    ),
                    CommonWidgetsUtil.buildSimpleInfoCard(
                      title: "Webseite",
                      leading: Image.asset(
                        "assets/images/europe_logo.png",
                        width: 40.0,
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward_ios),
                        onPressed: () => URLUtil.launchURL("https://www.erasmusplus.de"),
                      ),
                    )
                  ],
                ),
              ),
              CommonWidgetsUtil.buildStickyHeader(
                context,
                "Entwickler",
                CommonWidgetsUtil.buildSimpleInfoCard(
                  title: "Tim Theisinger",
                  trailing: Container(
                    width: 1,
                  ),
                ),
              ),
              CommonWidgetsUtil.buildStickyHeader(
                context,
                "Source Code",
                CommonWidgetsUtil.buildSimpleInfoCard(
                  title: "Github",
                  leading: Image.asset(
                    "assets/images/github_logo.png",
                    width: 40.0,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () => URLUtil.launchURL("https://github.com/KotlinIsCool/ErasmusDoc"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
