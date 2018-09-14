/*
    Copyright (C) 2018-2019 Tim Theisinger
    This project is licensed under the terms of the GNU General Public License v3.0, see LICENSE.txt
*/

import 'package:flutter/material.dart';

class JournalDataTable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => JournalDataTableState();
}

class JournalDataTableState extends State<JournalDataTable> {
  final selectedRows = List<String>();

  //TODO: Implement Journal class
  //TODO: Implement DataTableSource https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/data_table_demo.dart
  final rows = ["Ausflug nach Spanien", "Ausflug nach Deutschland"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(8.0),
      child: DataTable(
        onSelectAll: (row) => print(row),
        columns: [
          DataColumn(
            label: Text("Titel"),
          ),
          DataColumn(
            label: Text("Von"),
          ),
          DataColumn(
            label: Text("Bis"),
          ),
        ],
        rows: rows
            .map(
              (s) => DataRow(
                      onSelectChanged: (selected) => selected ? selectedRows.add(s) : selectedRows.remove(s),
                      cells: [
                        DataCell(Text(s)),
                        //If there was a Journal class you could use s.startDate()
                        DataCell(Text("09-09-2018")),
                        DataCell(Text("10-09-2018")),
                      ]),
            )
            .toList(),
      ),
    );
  }
}
