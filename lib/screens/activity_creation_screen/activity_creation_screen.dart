/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:flutter/material.dart';
import 'package:zefyr/zefyr.dart';

class ActivityCreationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActivityCreationScreenState();
}

class ActivityCreationScreenState extends State<ActivityCreationScreen> {
  ZefyrController _controller;
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();

    final document = new NotusDocument();
    _controller = new ZefyrController(document);
    _focusNode = new FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Neue Aktivität"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(1.0))),
        child: ZefyrScaffold(
          child: ZefyrEditor(
            padding: EdgeInsets.all(0),
            autofocus: true,
            controller: _controller,
            focusNode: _focusNode,
          ),
        ),
      ),
    );
  }
}
