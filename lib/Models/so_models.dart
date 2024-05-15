import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SOListModel with ChangeNotifier {
  final int id;
  final String date;
  final List datalist;

  SOListModel({
    required this.id,
    required this.date,
    required this.datalist,
  });

  factory SOListModel.fromJson(Map<String, dynamic> json) {
    return SOListModel(
      id: json['id'],
      date: json['date'],
      datalist: json['datalist'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date,
        "datalist": datalist,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
