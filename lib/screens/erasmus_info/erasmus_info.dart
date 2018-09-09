/*
    Created by Tim Theisinger on 09.09.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/screens/erasmus_info/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ErasmusInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Erasmus-Projektinfo"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ErasmusWebsiteRaisedButton(),
          ],
        ),
      ),
    );
  }
}
