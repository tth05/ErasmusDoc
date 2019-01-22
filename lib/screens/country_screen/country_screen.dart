/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/models/country.dart';
import 'package:erasmus_app/screens/image_view_screen/image_view_screen.dart';
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
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ImageViewScreen("assets/countries/${country.fileName}/big_flag.png"),
                      fullscreenDialog: true)),
                  child: Card(
                    elevation: 2.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                country.translatedName,
                                style: TextStyle(fontSize: 30.0),
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
                ),
                Card(
                  elevation: 1.0,
                  child: Column(
                    children: <Widget>[
                      //First tile
                      ListTile(
                        title: Text(
                          "Berufsorientierung",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            fontSize: 25.0,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blueAccent,
                        ),
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Markdown(
                                styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
                                padding: EdgeInsets.all(0.0),
                                data: country.orientation,
                              ),
                            );
                          },
                        ),
                      ),
                      Divider(),
                      //Second tile
                      ListTile(
                        title: Text(
                          "Schulsystem",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            fontSize: 25.0,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.blueAccent,
                        ),
                        onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Markdown(
                                    padding: EdgeInsets.all(0.0),
                                    data: country.schoolSystem,
                                  ),
                                );
                              },
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CountryScreenState(this.country);
}
