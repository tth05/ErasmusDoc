/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:erasmus_app/screens/country_screen/widgets/rounded_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:sticky_headers/sticky_headers.dart';

class CommonWidgetsUtil {
  static Widget buildStickyHeader(String title, Widget content,
      {EdgeInsets contentPadding: const EdgeInsets.all(0.0)}) {
    return StickyHeader(
      header: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[200]),
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
                ),
              ),
            ),
          )
        ],
      ),
      content: Padding(
        padding: contentPadding,
        child: content,
      ),
    );
  }

  static Widget buildSimpleInfoCard({
    String title,
    String subtitle,
    Widget leading,
    Widget trailing,
    bool divider: false,
    double dividerIndent: 40,
    bool dense: false,
    bool isThreeLine: false,
    VoidCallback onTap,
    VoidCallback onInfoPressed,
  }) {
    if (divider)
      return Column(
        children: <Widget>[
          ListTile(
            title: title == null ? null : Text(title),
            subtitle: subtitle == null ? null : Text(subtitle),
            leading: leading,
            dense: dense,
            isThreeLine: isThreeLine,
            onTap: onTap,
            trailing: trailing != null
                ? trailing
                : IconButton(
                    icon: Icon(Icons.info),
                    onPressed: onInfoPressed,
                  ),
          ),
          Divider(
            indent: dividerIndent,
            height: 0.0,
          ),
        ],
      );

    return ListTile(
      title: title == null ? null : Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      leading: leading,
      dense: dense,
      isThreeLine: isThreeLine,
      onTap: onTap,
      trailing: trailing != null
          ? trailing
          : IconButton(
              icon: Icon(Icons.info),
              onPressed: onInfoPressed,
            ),
    );
  }

  static void openMarkdownModal(BuildContext context, String data) {
    ThemeData theme = Theme.of(context);
    showRoundedModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Markdown(
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
          padding: EdgeInsets.all(8.0),
          data: data,
        );
      },
    );
  }
}
