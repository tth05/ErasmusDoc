/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  final String path;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            image: DecorationImage(
              image: AssetImage(path),
            ),
          ),
        ),
      ),
    );
  }

  ImageViewScreen(this.path);
}
