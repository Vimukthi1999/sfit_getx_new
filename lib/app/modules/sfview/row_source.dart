import 'package:flutter/material.dart';

import '../../../res/widgets/app_custom_text_styles.dart';

class RowSource extends DataTableSource {
  var myData;
  final count;

  RowSource({required this.myData, required this.count});

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return getDataRow(myData![index]);
    } else {
      return null;
    }
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow getDataRow(var data) {

  return DataRow(
    cells: [
      DataCell(appitemtableDatatxt(data.item)),
      DataCell(appitemtableDatatxt(data.itemDes)),
      DataCell(appitemtableDatatxt(data.sp)),
      DataCell(appitemtableDatatxt(data.purpose)),
      DataCell(appitemtableDatatxt(data.serialNo)),
      DataCell(appitemtableDatatxt(data.quantity)),
    ],
  );
}
