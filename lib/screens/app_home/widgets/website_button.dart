/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/
import 'package:erasmus_app/util/url_util.dart';
import 'package:flutter/material.dart';

class ErasmusWebsiteRaisedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: RaisedButton(
              padding: EdgeInsets.all(10.0),
              elevation: 4,
              child: Text(
                "Zur Webseite",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () => URLUtil.launchURL("https://www.erasmusplus.de"),
            ),
          ),
        ],
      ),
    );
  }
}
