/*
    Created by Tim Theisinger on 09.09.2018
    License: This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:flutter/material.dart';

class ErasmusBottomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 2.0,
      color: Theme.of(context).primaryColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Row(
              children: <Widget>[
//                  Image.asset(
//                    "assets/images/erasmus.png",
//                    fit: BoxFit.contain,
//                    scale: 5.0,
//                  ),
                Padding(
                  padding: EdgeInsets.only(left: 5.0),
                  child: Text(
                    "Erasmus-Projektinfo",
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
