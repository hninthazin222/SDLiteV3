import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdlite/style.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
  ));
}

appbarStyle(
  BuildContext context,
  title,
  leading,
  action,
  bottom,
) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: false,
    automaticallyImplyLeading: false,
    shadowColor: Colors.white,
    foregroundColor: Colors.white,
    surfaceTintColor: Colors.white,
    leadingWidth: 50,
    titleSpacing: leading == null ? 16 : 0,
    leading: leading,
    actions: action,
    bottom: bottom,
    title: Text(
      '$title',
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: fontRoboto,
        color: const Color(0xFF1D1F1F),
      ),
    ),
  );
}

bindDatePicker(datetime) {
  DateTime dateAndtime = DateTime.now();
  if (datetime != null && datetime != "") {
    var date = datetime.toString();
    var day = date.substring(0, 2);
    var month = date.substring(3, 5);
    var year = date.substring(6, 10);
    dateAndtime = DateTime(int.parse(year), int.parse(month), int.parse(day));
  }
  return dateAndtime;
}

getCurrentYear(aStatus) {
  var date = DateFormat("dd/MM/yyyy").format(DateTime.now());
  var year;
  if (aStatus == "max") {
    year = int.parse(date.substring(6, 10)) + 1;
    return DateTime(year, 12, 31);
  } else {
    year = int.parse(date.substring(6, 10)) - 20;
    return DateTime(year, 01, 01);
  }
}
