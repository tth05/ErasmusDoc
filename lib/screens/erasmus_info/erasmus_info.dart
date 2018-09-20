/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/screens/erasmus_info/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ErasmusInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Erasmus-Projektinfo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                elevation: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/erasmus_logo.png",
                        fit: BoxFit.scaleDown,
                      ),
                      Divider(
                        color: Colors.grey[700],
                      ),
                      Text(
                        "Das Erasmus-Programm ist ein Förderprogramm der Europäischen Union. Sein Name erinnert an Erasmus von "
                            "Rotterdam, einen europäisch gebildeten Humanisten der Renaissance. Es wurde zum weltweit größten "
                            "Förderprogramm von Auslandsaufenthalten an Universitäten, über Europa hinaus erweitert seit dem Jahr "
                            "2003 durch das Zusatzprogramm Erasmus Mundus, und finanzierte bis dahin in seinen ersten rund 15 Jahren "
                            "etwa 1 Million Stipendien. Für andere Zielgruppen folgte beispielsweise Erasmus für Jungunternehmer. "
                            "Seit dem Jahr 2014 ist Erasmus mit anderen Programmen zu Erasmus+ verschmolzen.",
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              ErasmusWebsiteRaisedButton(),
            ],
          ),
        ),
      ),
    );
  }
}
