/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/data/country.dart';
import 'package:erasmus_app/widgets/global_drawer.dart';
import 'package:flutter/material.dart';

class CountryScreen extends StatefulWidget {
  final Country country;

  @override
  State<StatefulWidget> createState() => CountryScreenState(country);

  CountryScreen(this.country);
}

class CountryScreenState extends State<CountryScreen> {
  final Country country;

  var expanded1 = false;
  var expanded2 = false;

  ExpansionPanelHeaderBuilder buildHeader(String text) {
    return (BuildContext c, bool expanded) {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(left: 24.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
//      return Text(
//        text,
//        style: TextStyle(fontSize: 20.0),
//      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Info"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pushReplacementNamed("/"),
        ),
      ),
      endDrawer: GlobalDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: <Widget>[
              Card(
                shape: BeveledRectangleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
//                          Opacity(
//                            child: Image.asset(
//                              "assets/countries/${country.fileName}/3.0x/flag.png",
//                              fit: BoxFit.fill,
//                            ),
//                            opacity: 0.4,
//                          ),
                              Text(
                                country.translatedName,
                                style: TextStyle(fontSize: 40.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(),
                      Text(
                        country.info,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ExpansionPanelList(
                  expansionCallback: (index, expanded) => setState(() {
                        if (index == 0) expanded1 = !expanded;
                        if (index == 1) expanded2 = !expanded;
                      }),
                  children: <ExpansionPanel>[
                    ExpansionPanel(
                      headerBuilder: buildHeader("Berufsorientierung"),
                      body: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Divider(),
                            Text(
                              country.orientation,
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      isExpanded: expanded1,
                    ),
                    ExpansionPanel(
                      headerBuilder: buildHeader("Schulsystem"),
                      body: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Divider(),
                            Text(
                              country.schoolSystemInfo,
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                      isExpanded: expanded2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CountryScreenState(this.country);
}
