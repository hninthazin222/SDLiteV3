import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductListModel with ChangeNotifier {
  late int id;
  late String syskey;
  late String code;
  late String desc;
  late String onhand;
  late String amount;
  late String qty;
  late String qtyTotalAmt;
  late bool check;

  ProductListModel({
    required this.id,
    required this.syskey,
    required this.code,
    required this.desc,
    required this.onhand,
    required this.amount,
    required this.qty,
    required this.qtyTotalAmt,
    required this.check,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
      id: json['id'],
      syskey: json['syskey'],
      code: json['code'],
      desc: json['desc'],
      onhand: json['onhand'],
      amount: json['amount'],
      qty: json['qty'],
      qtyTotalAmt: json['qtyTotalAmt'],
      check: json['check'],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "syskey": syskey,
        "code": code,
        "desc": desc,
        "onhand": onhand,
        "amount": amount,
        "qty": qty,
        "qtyTotalAmt": qtyTotalAmt,
        "check": check,
      };
  @override
  String toString() {
    return toJson().toString();
  }
}
