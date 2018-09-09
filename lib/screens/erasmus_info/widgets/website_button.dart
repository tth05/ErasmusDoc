/*
    Created by Tim Theisinger on 09.09.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/util/URLUtil.dart';
import 'package:flutter/material.dart';

class ErasmusWebsiteRaisedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: RaisedButton(
            padding: EdgeInsets.all(10.0),
            elevation: 5.0,
            child: Text(
              "Zur Webseite",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
            onPressed: () => URLUtil.launchURL("https://erasmusplus.de"),
          ),
        ),
      ],
    );
  }
}
